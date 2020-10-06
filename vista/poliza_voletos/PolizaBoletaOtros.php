<?php
/**
*@package pXP
*@file PolizaBoletaOtros.php
*@author  (breydi.vasquez)
*@date 18-04-2018 20:02:21
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.PolizaBoletaOtros=Ext.extend(Phx.gridInterfaz,{
	nombreVista : 'servicio',

	gruposBarraTareas:[{name:'vigente',title:'<H1 align="center"><i class="fa fa-thumbs-o-up"></i>Vigentes</h1>',grupo:0,height:0},
                       {name:'caducado',title:'<H1 align="center"><i class="fa fa-thumbs-o-down"></i>Caducadas</h1>',grupo:1,height:0},
                     ],

	actualizarSegunTab: function(name){
    	if(this.finCons){
    		 this.store.baseParams.pes_estado = name;
    	     this.load({params:{start:0, limit:this.tam_pag}});
    	   }
    },
	beditGroups: [0,1],
	bnewGroups:[0],
    bdelGroups:  [0,1],
    bsaveGroups:[],
    bactGroups:  [0,1],
    btestGroups: [0,1],
    bexcelGroups: [0,1],

  preparaMenu:function(n){
      var data = this.getSelectedData();
      var tb =this.tbar;
      Phx.vista.PolizaBoletaOtros.superclass.preparaMenu.call(this,n);
      //habilitar reporte de colicitud de comrpa y preorden de compra
      //this.menuAdq.enable();
           //this.getBoton('edit').disable();
           //this.getBoton('new').disable();
           //this.getBoton('del').disable();
          this.getBoton('save').hide();
        return tb
    },


	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.PolizaBoletaOtros.superclass.constructor.call(this,config);

		this.addButton('btnChequeoDocumentosWf',{
        text: 'Documentos del Proceso',
        iconCls: 'bchecklist',
        disabled: false,
        handler: this.loadCheckDocumentosWf,
        tooltip: '<b>Documentos del Proceso</b><br/>Subir los documetos requeridos en el proceso seleccionado.'});

	    this.addButton('diagrama_gantt',{
	   	text:'Diagrama Gantt',
	   	iconCls: 'bgantt',
	   	disabled:false,
	   	handler:this.diagramGantt,
	   	tooltip: '<b>Diagrama Gantt de proceso macro</b>'});

	    this.addButton('sig_estado',{
        text:'Siguiente',
        iconCls:'badelante',
        disabled:true,
        handler:this.sigEstado,
        tooltip: '<b>Cambiar al siguientes estado</b>'});

		this.init();
		this.iniciarEventos();

		this.store.baseParams={tipo_interfaz:this.nombreVista};
		if(config.filtro_directo){
           this.store.baseParams.filtro_valor = config.filtro_directo.valor;
           this.store.baseParams.filtro_campo = config.filtro_directo.campo;
       }
		//primera carga
		this.store.baseParams.pes_estado = 'vigente';
    	this.load({params:{start:0, limit:this.tam_pag}});

		this.finCons = true;
		//this.load({params:{start:0, limit:this.tam_pag}})
	},

	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_anexo'
			},
			type:'Field',
			form:true
		},
		{
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name:'id_proceso_wf'
			},
			type:'Field',
			form:true
		},
		{
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name:'id_estado_wf'
			},
			type:'Field',
			form:true
		},
		{
			config:{
				name: 'origen',
				inputType:'hidden',
				anchor: '100%',
				gwidth: 200
			},
				type:'TextField',
				id_grupo:1,
				form:true,
		},
       /* {
            config:{
                name:'id_gestion',
                fieldLabel:'Gestión',
                allowBlank:false,
                emptyText:'Gestión...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_parametros/control/Gestion/listarGestion',
                    id: 'id_gestion',
                    root: 'datos',
                    sortInfo:{
                        field: 'gestion',
                        direction: 'DESC'
                    },
                    totalProperty: 'total',
                    fields: ['id_gestion','gestion','moneda','codigo_moneda'],
                    remoteSort: true,
                    baseParams:{par_filtro:'gestion'}
                }),
                valueField: 'id_gestion',
                displayField: 'gestion',
                hiddenName: 'id_gestion',
                forceSelection:true,
                typeAhead: false,
                triggerAction: 'all',
                lazyRender:true,
                mode:'remote',
                pageSize:10,
                queryDelay:1000,
                listWidth:200,
                resizable:true,
                anchor:'50%',
                gwidth: 50,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['gestion']);
				}
            },
            type:'ComboBox',
            id_grupo:0,
            filters:{
                pfiltro:'gestion',
                type:'string'
            },
            grid:false,
            form:true
        },*/
		{
            config: {
                name: 'id_proveedor',
                hiddenName: 'id_proveedor',
                fieldLabel: 'Proveedor',
                //typeAhead: false,
                forceSelection: false,
                allowBlank: true,
                emptyText: 'Proveedor...',
                store: new Ext.data.JsonStore({
                    url:'../../sis_parametros/control/Proveedor/listarProveedorCombos',
                    id: 'id_proveedor',
                    root: 'datos',
                    sortInfo:{
                        field: 'rotulo_comercial',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_proveedor','desc_proveedor','codigo','nit','rotulo_comercial','lugar','email'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams:Ext.apply({par_filtro:'desc_proveedor#codigo#nit#rotulo_comercial'})

                }),
                valueField: 'id_proveedor',
                displayField: 'desc_proveedor',
                triggerAction: 'all',
                lazyRender: true,
                resizable: true,
                mode: 'remote',
                pageSize: 10,
                queryDelay: 1000,
                listWidth: 280,
                minChars: 2,
                gwidth: 200,
                anchor: '100%',
                tpl: '<tpl for="."><div class="x-combo-list-item"><p><b>{rotulo_comercial}</b></p><p>{desc_proveedor}</p><p>{codigo}</p><p>NIT:{nit}</p><p>Lugar:{lugar}</p><p>Email: {email}</p></div></tpl>',
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['proveedor']);
				}
            },
            type: 'ComboBox',
            id_grupo: 0,
            filters: {
                pfiltro: 'pobo.proveedor',
                type: 'string'
            },
            bottom_filter: true,
            grid: true,
            form: true
        },
        {
            config: {
                name: 'id_contrato',
                hiddenName: 'id_contrato',
                fieldLabel: 'Contrato',
                typeAhead: false,
                forceSelection: false,
                allowBlank: true,
                disabled: false,
                emptyText: 'Contratos...',
                store: new Ext.data.JsonStore({
                    url : '../../sis_contratos/control/PolizaBoleta/listarContratoBoleta',
                    id: 'id_contrato',
                    root: 'datos',
                    sortInfo: {
                        field: 'numero',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_contrato','nro_tramite', 'numero', 'tipo', 'objeto', 'estado', 'desc_proveedor', 'monto', 'moneda', 'fecha_inicio', 'fecha_fin'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams:{
                        par_filtro: 'pw.nro_tramite#con.numero#con.tipo#con.monto'
                    }
                }),
                valueField: 'id_contrato',
                displayField: 'numero',
                gdisplayField: 'numero',
                triggerAction: 'all',
                lazyRender: true,
                resizable: true,
                mode: 'remote',
                pageSize: 20,
                queryDelay: 200,
                listWidth: 380,
                minChars: 2,
                gwidth: 100,
								hidden: true,
                anchor: '80%',
                tpl: '<tpl for="."><div class="x-combo-list-item"><p><b>Nro: {numero} ({tipo})</b></p><p>Obj: <strong>{objeto}</strong></p><p>Prov : {desc_proveedor}</p> <p>Nro.Trámite: {nro_tramite}</p><p>Monto: {monto} {moneda}</p><p>Rango: {fecha_inicio} al {fecha_fin}</p></div></tpl>'
            },
            type: 'ComboBox',
            id_grupo: 0,
            filters: {
                pfiltro: 'con.numero',
                type: 'numeric'
            },
            grid: false,
            form: true
        },
        {
            config: {
                name: 'id_institucion',
                hiddenName: 'id_institucion',
                fieldLabel: 'Banco',
                typeAhead: false,
                forceSelection: false,
                allowBlank: false,
                disabled: false,
                emptyText: 'Bancos...',
                store: new Ext.data.JsonStore({
                    url : '../../sis_contratos/control/PolizaBoleta/listarBancos',
                    id: 'id_institucion',
                    root: 'datos',
                    sortInfo: {
                        field: 'nombre',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_institucion','nombre'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams: {
                        par_filtro: 'instit.id_institucion#instit.nombre'
                    }
                }),
                valueField: 'id_institucion',
                displayField: 'nombre',
                gdisplayField: 'id_institucion',
                triggerAction: 'all',
                lazyRender: true,
                resizable: true,
                mode: 'remote',
                pageSize: 20,
                queryDelay: 200,
                listWidth: 380,
                minChars: 2,
                gwidth: 100,
                anchor: '80%',
                tpl: '<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p></div></tpl>'
            },
            type: 'ComboBox',
            id_grupo: 0,
            filters: {
                pfiltro: 'instit.nombre',
                type: 'numeric'
            },
            grid: false,
            form: true
        }, /*
		{
			config:{
				name: 'proveedor',
				fieldLabel: 'Empresa',
				allowBlank: true,
				anchor: '100%',
				gwidth: 200,
				maxLength:255
			},
				type:'TextField',
				filters:{pfiltro:'pobo.proveedor',type:'string'},
				id_grupo:1,
				grid:true,
				form:false,
				bottom_filter:true
		},	*/
		{
			config:{
				name: 'codigo_int',
				fieldLabel: 'Office ID',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:25
			},
				type:'TextField',
				filters:{pfiltro:'pobo.codigo_int',type:'string'},
				id_grupo:1,
				grid:false,
				form:false,
				bottom_filter:false
		},

		{
			config:{
				name: 'banco',
				fieldLabel: 'Banco',
				allowBlank: true,
				anchor: '80%',
				gwidth: 200

			},
				type:'TextField',
				filters:{pfiltro:'pobo.banco',type:'string'},
				id_grupo:1,
				grid:true,
				form:false,
				bottom_filter:true
		},
        {
            config : {
                name :'tipo',
                fieldLabel : 'Tipo Boleta',
                allowBlank : false,
                triggerAction : 'all',
                lazyRender : true,
                mode : 'local',
                store : new Ext.data.ArrayStore({
                    fields : ['tipo', 'valor'],
                    data : [['boleta', 'Boleta Garantía'],
                            ['poliza', 'Poliza Garantía']]
                }),
                anchor : '100%',
                gwidth : 100,
                valueField : 'tipo',
                displayField : 'valor'
            },
            type : 'ComboBox',
            id_grupo : 1,
            grid : true,
            form : true
        },
		{
			config:{
				name: 'nro_documento',
				fieldLabel: 'Nro Documento Boleta',
				allowBlank: false,
				anchor: '80%',
				gwidth: 150,
				maxLength:30
			},
				type:'TextField',
				filters:{pfiltro:'pobo.nro_documento',type:'string'},
				id_grupo:1,
				grid:true,
				form:true,
				bottom_filter:true
		},
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Ciudad',
				allowBlank: true,
				anchor: '80%',
				gwidth: 80,
				maxLength:30
			},
				type:'TextField',
				filters:{pfiltro:'pobo.codigo',type:'string'},
				id_grupo:1,
				grid:false,
				form:false,
				bottom_filter:false
		},
		{
			config:{
				name: 'codigo_noiata',
				fieldLabel: 'Cod Iata',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:30
			},
				type:'TextField',
				filters:{pfiltro:'pobo.codigo_noiata',type:'string'},
				id_grupo:1,
				grid:false,
				form:false,
				bottom_filter:false
		},
		{
			config:{
				name: 'tipo_agencia',
				fieldLabel: 'Tipo Agencia',
				allowBlank: true,
				anchor: '80%',
				gwidth: 80,
				maxLength:300,
                renderer:function(value,p,record){
                    if ((record.data.id_anexo != '') &&(value == '' || value == 'servicio') ) return 'servicio';
                }
			},
				type:'TextField',
				filters:{pfiltro:'pobo.tipo_agencia',type:'string'},
				id_grupo:1,
				grid:true,
				form:false,
				bottom_filter:true
		},
		{
			config:{
				name: 'numero',
				fieldLabel: 'Nro Contrato',
				allowBlank: true,
				anchor: '80%',
				gwidth: 200,
				maxLength:1
			},
				type:'TextField',
				filters:{pfiltro:'pobo.numero',type:'string'},
				id_grupo:1,
				grid:true,
				form:false,
				bottom_filter:true
		},

		{
			config:{
				name: 'fecha_desde',
				fieldLabel: 'Fecha Inicio',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y',
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
				type:'DateField',
				filters:{pfiltro:'pobo.fecha_desde',type:'date'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'fecha_fin_uso',
				fieldLabel: 'Fecha Fin Uso',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y',
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}

			},
				type:'DateField',
				filters:{pfiltro:'pobo.fecha_fin_uso',type:'date'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'fecha_notif',
				fieldLabel: 'Fecha Notificacion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y',
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
				type:'DateField',
				filters:{pfiltro:'pobo.fecha_notif',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'fecha_corte',
				fieldLabel: 'Fecha de Corte',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y',
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
				type:'DateField',
				filters:{pfiltro:'pobo.fecha_corte',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		},
	 {
			config:{
				name: 'fecha_hasta',
				fieldLabel: 'Fecha Vencimiento',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y',
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
				type:'DateField',
				filters:{pfiltro:'pobo.fecha_hasta',type:'date'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'moneda',
				fieldLabel: 'Moneda',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:3,
                renderer:function (value,p,record){
						if(record.data.tipo_reg != 'summary'){
							return  String.format('{0}', record.data['moneda']);
						}
						else{
							return '<b><p align="right">Total: &nbsp;&nbsp; </p></b>';
						}
					}
			},
				type:'TextField',
				filters:{pfiltro:'pobo.moneda',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'asegurado',
				fieldLabel: 'Importe',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:300,
                renderer:function (value,p,record){
						if(record.data.tipo_reg != 'summary'){
							return  String.format('{0}', Ext.util.Format.number(value,'0.000,00/i'));
						}
						else{
							return  String.format('<b><font size=2 >{0}</font><b>', Ext.util.Format.number(record.data.total_asegurado,'0.000,00/i'));
						}
					}

			},
				type:'NumberField',
				filters:{pfiltro:'pobo.asegurado',type:'numeric'},
				id_grupo:1,
				grid:true,
				form:true,
				bottom_filter:true,
		},
		{
			config:{
				name: 'nro_hoja_ruta',
				fieldLabel: 'Nº Hoja De Ruta',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100
			},
				type:'NumberField',
				filters:{pfiltro:'pobo.nro_hoja_ruta',type:'string'},
				id_grupo:1,
				grid:true,
				form:true,
				bottom_filter:true
		},
		{
			config:{
				name: 'estado_contrato',
				fieldLabel: 'Estado contrato',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
			},
				type:'TextField',
				filters:{pfiltro:'pobo.estado_contrato',type:'string'},
				id_grupo:1,
				grid:true,
				form:false,
				bottom_filter:true
		},
		{
			config: {
				name: 'estado',
				fieldLabel: 'Estado Boleta',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100
			},
			type: 'TextField',
			filters: {pfiltro: 'pobo.estado', type:'string'},
			id_grupo: 1,
			grid: true,
			form: false,
			bottom_filter: true
		},
		{
			config:{
				name: 'observaciones',
				fieldLabel: 'Observaciones',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:30
			},
				type:'TextArea',
				filters:{pfiltro:'pobo.observaciones',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100
			},
				type:'Field',
				filters:{pfiltro:'usu1.cuenta',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'usuario_ai',
				fieldLabel: 'Funcionaro AI',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100
			},
				type:'TextField',
				filters:{pfiltro:'pobo.usuario_ai',type:'string'},
				id_grupo:1,
				grid:false,
				form:false
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y',
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'pobo.fecha_reg',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'id_usuario_ai',
				fieldLabel: 'usuario ai',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100
			},
				type:'Field',
				filters:{pfiltro:'pobo.id_usuario_ai',type:'numeric'},
				id_grupo:1,
				grid:false,
				form:false
		},
		{
			config:{
				name: 'usr_mod',
				fieldLabel: 'Modificado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100
			},
				type:'Field',
				filters:{pfiltro:'usu2.cuenta',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y',
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'pobo.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100
			},
				type:'TextField',
				filters:{pfiltro:'pobo.estado_reg',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},




	],
	tam_pag:50,
	title:'Poliza Boleta Otras',
	ActSave:'../../sis_contratos/control/PolizaBoleta/insertarPolizaBoleta',
	ActDel:'../../sis_contratos/control/PolizaBoleta/eliminarPolizaBoleta',
	ActList:'../../sis_contratos/control/PolizaBoleta/listarPolizaBoletaOtra',
	id_store:'id_anexo',
	fields: [
		{name:'id_anexo', type: 'numeric'},
		{name:'banco', type: 'string'},
		{name:'nro_documento', type: 'string'},
		{name:'tipo', type: 'string'},
		{name:'codigo', type: 'string'},
		{name:'proveedor', type: 'string'},
		{name:'numero', type: 'string'},
		{name:'tipo_agencia', type: 'string'},
		{name:'fecha_desde', type: 'date',dateFormat:'Y-m-d'},
		{name:'fecha_fin_uso', type: 'date',dateFormat:'Y-m-d'},
		{name:'fecha_notif', type: 'date',dateFormat:'Y-m-d'},
		{name:'fecha_corte', type: 'date',dateFormat:'Y-m-d'},
		{name:'fecha_hasta', type: 'date',dateFormat:'Y-m-d'},
		{name:'moneda', type: 'string'},
		{name:'asegurado', type: 'numeric'},
		{name:'estado',type:'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'usuario_ai', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'tipo_reg', type: 'string'},
		{name:'total_asegurado', type: 'numeric'},
		{name:'observaciones', type:'string'},
		{name:'estado_contrato', type:'string'},
		{name:'id_proceso_wf',type:'numeric'},
		{name:'id_estado_wf',type:'numeric'},
		{name:'nro_hoja_ruta',type:'numeric'},
		{name:'id_contrato',type:'numeric'},
		{name:'id_gestion',type:'numeric'},
		{name:'gestion',type:'numeric'},
        {name:'id_proveedor',type:'numeric'},
        {name:'id_institucion',type:'numeric'},
				{name:'estado_reg', type:'string'},

	],
	sortInfo:{
		field: 'fecha_hasta',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	btest:false,

    onButtonNew: function() {
    	this.window.setSize(450,420);
    	this.ocultarComponente(this.Cmp.fecha_fin_uso);
    	Phx.vista.PolizaBoletaOtros.superclass.onButtonNew.call(this);
    	this.Cmp.origen.setValue('servicio');
    },
	onButtonEdit:function(){
		this.window.setSize(450,420);
		this.mostrarComponente(this.Cmp.fecha_fin_uso);
		Phx.vista.PolizaBoletaOtros.superclass.onButtonEdit.call(this);
		this.Cmp.origen.setValue('servicio');
		//var data = this.getSelectedData();
	},
    iniciarEventos:function(){
    	this.ocultarComponente(this.Cmp.fecha_fin_uso);
    	this.Cmp.id_contrato.store.baseParams={vista:'otros'};
    },
	loadCheckDocumentosWf:function() {
        var rec=this.sm.getSelected();
        rec.data.nombreVista = this.nombreVista;
        Phx.CP.loadWindows('../../../sis_workflow/vista/documento_wf/DocumentoWf.php',
            'Chequear documento del WF',
            {
                width:'90%',
                height:500
            },
            rec.data,
            this.idContenedor,
            'DocumentoWf'
    	)
    },
    sigEstado:function(){
      var rec=this.sm.getSelected();
      console.log('this',rec);
      this.objWizard = Phx.CP.loadWindows('../../../sis_workflow/vista/estado_wf/FormEstadoWf.php',
            'Estado de Wf',
            {
                modal:true,
                width:700,
                height:450
            },
            {data:{
                   id_estado_wf:rec.data.id_estado_wf,
                   id_proceso_wf:rec.data.id_proceso_wf,
                }}, this.idContenedor,'FormEstadoWf',
	        {
	            config:[{
                  event:'beforesave',
                  delegate: this.onSaveWizard,

                }],
	            scope:this
	        });

    },
    onSaveWizard:function(wizard,resp){
    	console.log('respp',resp);
        Phx.CP.loadingShow();
        Ext.Ajax.request({
            url:'../../sis_contratos/control/PolizaBoleta/siguienteEstadoBoleta',
            params:{
                id_proceso_wf_act:  resp.id_proceso_wf_act,
                id_estado_wf_act:   resp.id_estado_wf_act,
                id_tipo_estado:     resp.id_tipo_estado,
                id_funcionario_wf:  resp.id_funcionario_wf,
                id_depto_wf:        resp.id_depto_wf,
                obs:                resp.obs,
                json_procesos:      Ext.util.JSON.encode(resp.procesos)
                },
            success:this.successWizard,
            failure: this.conexionFailure,
            argument:{wizard:wizard},
            timeout:this.timeout,
            scope:this
        });
    },
    successWizard:function(resp){
        Phx.CP.loadingHide();
        resp.argument.wizard.panel.destroy()
        this.reload();
    },

    diagramGantt:function (){
        var data=this.sm.getSelected().data.id_proceso_wf;
        console.log('data',data);
        Phx.CP.loadingShow();
        Ext.Ajax.request({
            url:'../../sis_workflow/control/ProcesoWf/diagramaGanttTramite',
            params:{'id_proceso_wf':data},
            success:this.successExport,
            failure: this.conexionFailure,
            timeout:this.timeout,
            scope:this
        });
	},


})
</script>
