<?Php
/**
 *@package PXP
 *@file   ReporteBoletasGarantia.php
 *@author  BVP
 *@date    11-01-2019
 *@description Reportes de Boletas de garantia
 */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.ReporteBoletasGarantia = Ext.extend(Phx.frmInterfaz, {
        Atributos : [
	        {
	            config : {
	                name :'boleta_filtro',
	                fieldLabel : 'Filtro',
	                allowBlank : false,
	                triggerAction : 'all',
	                lazyRender : true,
	                //listWidth: 200,
	                mode : 'local',
	                store : new Ext.data.ArrayStore({
	                    fields : ['tipo', 'valor'],
	                    data : [['vencida', 'Boletas Vencidas'],
	                            ['vigente', 'Boletas Vigentes'],
                                ['ejecutado', 'Ejecutada'],
                                ['devuelto', 'Devuelta']]
	                }),
	                anchor : '30%',
	                gwidth : 100,
	                valueField : 'tipo',
	                displayField : 'valor'
	            },
	            type : 'ComboBox',
	            id_grupo : 1,
	            grid : false,
	            form : true
	        },                              
            {
                config:{
                    name: 'fecha_desde',
                    fieldLabel: 'Fecha Desde',
                    allowBlank: false,
                    anchor: '30%',
                    gwidth: 100,
                    format: 'd/m/Y',
                    renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
                },
                type:'DateField',
                filters:{pfiltro:'fecha_ini',type:'date'},
                id_grupo:1,
                grid:true,
                form:true
            },
            {
                config:{
                    name: 'fecha_hasta',
                    fieldLabel: 'Fecha Hasta',
                    allowBlank: false,
                    anchor: '30%',
                    gwidth: 100,
                    format: 'd/m/Y',
                    renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
                },
                type:'DateField',
                filters:{pfiltro:'fecha_fin',type:'date'},
                id_grupo:1,
                grid:true,
                form:true
            }            
            ],

        title : 'Reporte Boletas De Garantia',
        ActSave : '../../sis_contratos/control/PolizaBoleta/RepBoletasGarantia',

        topBar : true,
        botones : false,
        labelSubmit : 'Imprimir',
        tooltipSubmit : '<b>Reporte Boleta Garantia</b>',

        constructor : function(config) {
            Phx.vista.ReporteBoletasGarantia.superclass.constructor.call(this, config);
            this.init();
            this.iniciarEvento();
            
        },        
        tipo : 'reporte',
        clsSubmit : 'bprint',
        
        iniciarEvento : function (){
        	this.Cmp.boleta_filtro.on('select', function (combo,record,index){
        		var  combo = record.data.tipo;
        		if (combo == 'vigente' || combo == 'ejecutado' || combo == 'devuelto') {
        			this.ocultarComponente(this.Cmp.fecha_desde);
        			this.Cmp.fecha_desde.allowBlank = true;
        		}
                else{
        			this.mostrarComponente(this.Cmp.fecha_desde);
        			this.Cmp.fecha_desde.allowBlank = false;        			
        		}       		
        	},this)
        }

    })
</script>
