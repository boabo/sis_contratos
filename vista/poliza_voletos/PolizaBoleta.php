<?php
/**
*@package pXP
*@file gen-PolizaBoleta.php
*@author  (breydi.vasquez)
*@date 18-04-2018 20:02:21
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.PolizaBoleta=Ext.extend(Phx.gridInterfaz,{
	
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
	bnewGroups:[],
    bdelGroups:  [0,1],
    bsaveGroups:[],
    bactGroups:  [0,1],
    btestGroups: [0,1],
    bexcelGroups: [0,1],

  preparaMenu:function(n){
      var data = this.getSelectedData();
      var tb =this.tbar;
      Phx.vista.PolizaBoleta.superclass.preparaMenu.call(this,n);  
      //habilitar reporte de colicitud de comrpa y preorden de compra
      //this.menuAdq.enable();    
           this.getBoton('edit').disable();
           this.getBoton('new').disable();
           this.getBoton('del').disable();
          this.getBoton('save').disable();
        return tb 
    },


	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.PolizaBoleta.superclass.constructor.call(this,config);
		
		this.init();
		
		this.store.baseParams={tipo_interfaz:this.PolizaBoleta};
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
					name: 'id_contrato'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
				type:'TextField',
				filters:{pfiltro:'pobo.estado_reg',type:'string'},
				id_grupo:1,
				grid:false,
				form:false
		},
		{
			config:{
				name: 'banco',
				fieldLabel: 'Banco',
				allowBlank: true,
				//anchor: '100%',
				//gwidth: 400,
				anchor: '100%',
				gwidth: 200,
				maxLength:200,
				//maxLength:30,
	
			},
				type:'TextField',
				filters:{pfiltro:'pobo.banco',type:'string'},
				id_grupo:1,
				grid:true,
				form:true,
				bottom_filter:true,
				
		},
		{
			config:{
				name: 'nro_documento',
				fieldLabel: 'NRO Documento',
				allowBlank: true,
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
				name: 'tipo',
				fieldLabel: 'Tipo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:30
			},
				type:'TextField',
				filters:{pfiltro:'pobo.tipo',type:'string'},
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
				gwidth: 60,
				maxLength:30
			},
				type:'TextField',
				filters:{pfiltro:'pobo.codigo',type:'string'},
				id_grupo:1,
				grid:true,
				form:true,
				bottom_filter:true
		},
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
				grid:true,
				form:true,
				bottom_filter:true
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
				grid:true,
				form:true,
				bottom_filter:true
		},
		{
			config:{
				name: 'agencia',
				fieldLabel: 'Agencia',
				allowBlank: true,
				anchor: '100%',
				gwidth: 200,
				maxLength:255
			},
				type:'TextField',
				filters:{pfiltro:'pobo.agencia',type:'string'},
				id_grupo:1,
				grid:true,
				form:true,
				bottom_filter:true
		},
		{
			config:{
				name: 'tipo_agencia',
				fieldLabel: 'Tipo Agencia',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:300
			},
				type:'TextField',
				filters:{pfiltro:'pobo.tipo_agencia',type:'string'},
				id_grupo:1,
				grid:true,
				form:true,
				bottom_filter:true
		},
		{
			config:{
				name: 'numero',
				fieldLabel: 'Nro Contrato',
				allowBlank: true,
				anchor: '80%',
				gwidth: 150,
				maxLength:1
			},
				type:'TextField',
				filters:{pfiltro:'pobo.numero',type:'string'},
				id_grupo:1,
				grid:true,
				form:true,
				bottom_filter:true
		},

		{
			config:{
				name: 'fecha_desde',
				fieldLabel: 'Fecha Inicio',
				allowBlank: true,
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
				form:true
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
				form:true
		},
	 {
			config:{
				name: 'fecha_hasta',
				fieldLabel: 'Fecha Vencimiento',
				allowBlank: true,
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
				gwidth: 70,
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
				form:true
		},
		{
			config:{
				name: 'asegurado',
				fieldLabel: 'Valor',
				allowBlank: true,
				anchor: '100%',
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
				form:true
		},
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'usu1.cuenta',type:'string'},
				id_grupo:1,
				grid:false,
				form:false
		},
		{
			config:{
				name: 'usuario_ai',
				fieldLabel: 'Funcionaro AI',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:300
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
				grid:false,
				form:false
		},
		{
			config:{
				name: 'id_usuario_ai',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
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
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'usu2.cuenta',type:'string'},
				id_grupo:1,
				grid:false,
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
				grid:false,
				form:false
		}
	],
	tam_pag:50,	
	title:'Poliza Boleta',	
	ActList:'../../sis_contratos/control/PolizaBoleta/listarPolizaBoleta',
	id_store:'id_contrato',
	fields: [
		//{name:'id_contrato', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'banco', type: 'string'},
		{name:'nro_documento', type: 'string'},
		{name:'tipo', type: 'string'},
		{name:'codigo', type: 'string'},
		{name:'codigo_int', type: 'string'},
		{name:'codigo_noiata', type: 'string'},
		{name:'agencia', type: 'string'}, 
		{name:'numero', type: 'string'},
		{name:'tipo_agencia', type: 'string'},
		{name:'fecha_desde', type: 'date',dateFormat:'Y-m-d'},
		{name:'fecha_fin_uso', type: 'date',dateFormat:'Y-m-d'},
		{name:'fecha_notif', type: 'date',dateFormat:'Y-m-d'},
		{name:'fecha_corte', type: 'date',dateFormat:'Y-m-d'},
		{name:'fecha_hasta', type: 'date',dateFormat:'Y-m-d'},
		{name:'moneda', type: 'string'},
		{name:'asegurado', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'usuario_ai', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name: 'tipo_reg', type: 'string'},
		{name: 'total_asegurado', type: 'numeric'},
		
	],
	sortInfo:{
		field: 'fecha_hasta',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		