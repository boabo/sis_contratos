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
            }],

        title : 'Reporte Boletas De Garantia',
        ActSave : '../../sis_contratos/control/PolizaBoleta/RepBoletasGarantia',

        topBar : true,
        botones : false,
        labelSubmit : 'Imprimir',
        tooltipSubmit : '<b>Reporte Boleta Garantia</b>',

        constructor : function(config) {
            Phx.vista.ReporteBoletasGarantia.superclass.constructor.call(this, config);
            this.init();
            
        },        
        tipo : 'reporte',
        clsSubmit : 'bprint'

    })
</script>