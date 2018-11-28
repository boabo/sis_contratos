/***********************************I-DAT-FEA-LEG-0-07/11/2018*****************************************/

INSERT INTO segu.tsubsistema ("codigo", "nombre", "fecha_reg", "prefijo", "estado_reg", "nombre_carpeta", "id_subsis_orig")
VALUES (E'LEG', E'Módulo de Contratos', E'2014-10-27', E'LG', E'activo', E'legal', NULL);

select pxp.f_insert_tgui ('<i class="fa fa-file fa-2x"></i> CONTRATOS', '', 'LEG', 'si', 1, '', 1, '', '', 'LEG');

select pxp.f_insert_tgui ('<i class="fa fa-legal fa-2x"></i> Contratos', '', 'WF.CON', 'si', 1, '', 2, '', '', 'LEG');

select pxp.f_insert_tgui ('<i class="fa fa-legal fa-2x"></i> Contratos Elaborados', '', 'WF.CON_finalizado', 'si', 1, '', 3, '', '', 'LEG');
select pxp.f_insert_tgui ('<i class="fa fa-legal fa-2x"></i> Contratos en Firma Contraparte Regional', '', 'WF.CON_contraparte_regional', 'si', 2, '', 3, '', '', 'LEG');
select pxp.f_insert_tgui ('<i class="fa fa-legal fa-2x"></i> Contratos Visto Bueno RPC', '', 'WF.CON_vobo_rpc', 'si', 3, '', 3, '', '', 'LEG');
select pxp.f_insert_tgui ('<i class="fa fa-legal fa-2x"></i> Contratos Anulados', '', 'WF.CON_anulado', 'si', 4, '', 3, '', '', 'LEG');
select pxp.f_insert_tgui ('<i class="fa fa-legal fa-2x"></i> Contratos para Digitalizacion', '', 'WF.CON_digitalizacion', 'si', 5, '', 3, '', '', 'LEG');
select pxp.f_insert_tgui ('<i class="fa fa-legal fa-2x"></i> Contratos Archivo Depto Legal', '', 'WF.CON_archivo_legal', 'si', 6, '', 3, '', '', 'LEG');
select pxp.f_insert_tgui ('<i class="fa fa-legal fa-2x"></i> Contratos Visto Bueno Legal', '', 'WF.CON_vobo_jefe_legal', 'si', 7, '', 3, '', '', 'LEG');
select pxp.f_insert_tgui ('<i class="fa fa-legal fa-2x"></i> Contratos en Firma Gerente', '', 'WF.CON_firma_gerente', 'si', 8, '', 3, '', '', 'LEG');
select pxp.f_insert_tgui ('<i class="fa fa-legal fa-2x"></i> Contratos Por Elaborar/Revisar', '', 'WF.CON_registro', 'si', 9, '', 3, '', '', 'LEG');
select pxp.f_insert_tgui ('<i class="fa fa-legal fa-2x"></i> Contratos Solicitados', '', 'WF.CON_borrador', 'si', 10, '', 3, '', '', 'LEG');
select pxp.f_insert_tgui ('<i class="fa fa-legal fa-2x"></i> Contratos VoBo Gerencia Comercial', '', 'WF.CON_vobo_comercial', 'si', 11, '', 3, '', '', 'LEG');
select pxp.f_insert_tgui ('<i class="fa fa-legal fa-2x"></i> Contratos Revisión', '', 'WF.CON_revision', 'si', 12, '', 3, '', '', 'LEG');
select pxp.f_insert_tgui ('<i class="fa fa-legal fa-2x"></i> Contratos Visto Bueno Abogado', '', 'WF.CON_vobo_abogado', 'si', 13, '', 3, '', '', 'LEG');
select pxp.f_insert_tgui ('<i class="fa fa-legal fa-2x"></i> Contratos Pendientes de Asignación', '', 'WF.CON_pendiente_asignacion', 'si', 14, '', 3, '', '', 'LEG');
select pxp.f_insert_tgui ('<i class="fa fa-legal fa-2x"></i> Contratos en Firma de Contraparte', '', 'WF.CON_firma_contraparte', 'si', 15, '', 3, '', '', 'LEG');
select pxp.f_insert_tgui ('<i class="fa fa-legal fa-2x"></i> Contratos Visto Bueno GAF', '', 'WF.CON_vobo_gaf', 'si', 16, '', 3, '', '', 'LEG');


/***********************************F-DAT-FEA-LEG-0-07/11/2018*****************************************/


/***********************************I-DAT-FEA-LEG-0-27/11/2018*****************************************/
select wf.f_import_tproceso_macro ('insert','LEGAL', 'LEG', 'Registro de Contratos','si');
select wf.f_import_tcategoria_documento ('insert','legales', 'Legales');
select wf.f_import_tcategoria_documento ('insert','proceso', 'Proceso');
select wf.f_import_ttipo_proceso ('insert','CON',NULL,NULL,'LEGAL','Contrato','leg.vcontrato','','si','','','Registro
de Contratos Externos, Internos, Adquisiciones y
Personal','CON',NULL);
select wf.f_import_ttabla ('insert','CON','CON','contrato','Contrato
de cualquier Tipo','','maestro','',NULL,'id_contrato','DESC','','{
	btnReclamar: true,
	gruposBarraTareasDocumento: [{name:"legales",title:"Doc. Legales",grupo:1,height:0},
                            {name:"proceso",title:"Doc del Proceso",grupo:0,height:0}],
	estadoReclamar: "pendiente_asignacion",
    constructor: function(config){

		if (config.estado != "borrador") {
			this.rowExpander= new Ext.ux.grid.RowExpander({
			        tpl : new Ext.Template(
			            "<br>",
			            "<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Objeto:&nbsp;&nbsp;</b> {objeto}</p>",
			            "<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Solicitud:&nbsp;&nbsp;</b> {solicitud}</p>",
			            "<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Fecha Inicio:&nbsp;&nbsp;</b> {fecha_inicio:date(\"d/m/Y\")}</p>",
			            "<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Fecha Fin\":&nbsp;&nbsp;</b> {fecha_fin:date(\"d/m/Y\")}</p>",
			            "<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Monto:&nbsp;&nbsp;</b> {monto}</p>",
			            "<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Moneda:&nbsp;&nbsp;</b> {moneda}</p>",
			            "<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Conceptos:&nbsp;&nbsp;</b> {desc_ingas}</p>",
			            "<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Ordenes de Trabajo:&nbsp;&nbsp;</b> {desc_ot}</p><br>"
			        )
		    });

		    this.arrayDefaultColumHidden=	["estado","fecha_mod","usr_reg","usr_mod","estado_reg","fecha_reg","objeto","fecha_inicio",
						"fecha_fin","id_gestion","id_persona","id_institucion","observaciones","solicitud","monto","id_moneda",
						"fecha_elaboracion","plazo","tipo_plazo","id_cotizacion","periodicidad_pago","tiene_retencion","modo",
						"id_contrato_fk","id_concepto_ingas","id_orden_trabajo","cargo","lugar","forma_contratacion","modalidad",
						"representante_legal","rpc","mae"];

		}
		Phx.vista[config.clase_generada].superclass.constructor.call(this,config);
		if (this.config.estado == "borrador") {
		  this.construyeVariablesContratos();
		}

		if (this.config.estado == "finalizado") {
		  this.getBoton("sig_estado").setDisabled(true);
		}
		this.getBoton("btnReclamar").hide();
		if(this.config.estado == this.estadoReclamar){
			this.getBoton("btnReclamar").show();
		}

		//Definición de evento para mostrar/ocultar componentes en función del tipo de contratos
		//this.Cmp.tipo.on("select", function(c,r,i){
		//		if(this.Cmp.tipo.getValue() == "administrativo"){
		//			alert("administrativo");
		//		} else if(this.Cmp.tipo.getValue() == "administrativo_alquiler"){
		//			alert("administrativo_alquiler");
		//		} else if (this.Cmp.tipo.getValue() == "administrativo_internacional"){
		//			alert("administrativo_internacional");
		//		}
		//	},
		//this);

    },
    construyeVariablesContratos: function(){
		Phx.CP.loadingShow();
		Ext.Ajax.request({
                url: "../../sis_workflow/control/Tabla/cargarDatosTablaProceso",
                params: { "tipo_proceso": "CON", "tipo_estado":"finalizado" , "limit":"100","start":"0"},
                success: this.successCotratos,
                failure: this.conexionFailure,
                timeout: this.timeout,
                scope:   this
        });
    },
    successCotratos: function(resp){
        Phx.CP.loadingHide();
        var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
	    if(reg.datos){
			this.ID_CONT = reg.datos[0].atributos.id_tabla
console.log(this.Cmp);
			this.Cmp.id_contrato_fk.store.baseParams.id_tabla = this.ID_CONT;
		 }else{
			alert("Error al cargar datos de contratos")
		}
     },
    agregarArgsExtraSubmit: function(){
		if (this.config.estado == "borrador") {
		   if (this.Cmp.id_contrato_fk.getValue() == "" || this.Cmp.id_contrato_fk.getValue() == null || this.Cmp.id_contrato_fk.getValue() == undefined) {
			   delete this.argumentExtraSubmit.nro_tramite;
			 } else {
			   var recContrato = this.Cmp.id_contrato_fk.store.getById(this.Cmp.id_contrato_fk.getValue());
			   this.argumentExtraSubmit.nro_tramite = recContrato.data.nro_tramite;
		   }
		}
    },
    iniciarEventos: function(){

        if (this.config.estado == "registro") {
			this.Cmp.tipo_plazo.on("select",function(c,r,i){
				if (this.Cmp.tipo_plazo.getValue() == "fecha_fija") {
					this.mostrarComponente(this.Cmp.fecha_fin);
					this.Cmp.fecha_fin.reset();
					this.Cmp.fecha_fin.allowBlank = false;
					this.ocultarComponente(this.Cmp.plazo);
					this.Cmp.plazo.reset();
					this.Cmp.plazo.allowBlank = true;
				} else if (this.Cmp.tipo_plazo.getValue() == "tiempo_indefinido") {
					this.ocultarComponente(this.Cmp.fecha_fin);
					this.Cmp.fecha_fin.reset();
					this.Cmp.fecha_fin.allowBlank = true;
					this.ocultarComponente(this.Cmp.plazo);
					this.Cmp.plazo.reset();
					this.Cmp.plazo.allowBlank = true;
				} else {
					this.ocultarComponente(this.Cmp.fecha_fin);
					this.Cmp.fecha_fin.reset();
					this.Cmp.fecha_fin.allowBlank = true;
					this.mostrarComponente(this.Cmp.plazo);
					this.Cmp.plazo.reset();
					this.Cmp.plazo.allowBlank = false;
				}


			},this);
		} else if (this.config.estado == "borrador") {
			this.Cmp.modo.on("select",function(c,r,i){
				if (this.Cmp.modo.getValue() == "adenda") {
					this.mostrarComponente(this.Cmp.id_contrato_fk);
					this.Cmp.id_contrato_fk.reset();
					this.Cmp.id_contrato_fk.allowBlank = false;
				} else {
					this.ocultarComponente(this.Cmp.id_contrato_fk);
					this.Cmp.id_contrato_fk.reset();
					this.Cmp.id_contrato_fk.allowBlank = true;
				}

			},this);

		}
   },
   onSubmit: function(o, x, force) {
   		var error = false;
   		if (this.Cmp.fecha_fin) {
   			if (this.Cmp.fecha_fin.getValue()) {
   				if (this.Cmp.fecha_fin.getValue() < this.Cmp.fecha_inicio.getValue()) {
   					error = true;
   				}
   			}
   		}
   		if (error) {
   			alert("La fecha de finalización del contrato no puede ser menor a la fecha de inicio");
   		} else {
   			Phx.vista[this.clase_generada].superclass.onSubmit.call(this,o, x, force);
   		}
   }
}

','Contratos','','REGCONT','borrador','borrador');
select wf.f_import_ttabla ('insert','ANX','CON','anexo','Anexos del contrato como ser Boletas de Garantías, Adendas, Memorandums, etc.','','detalle','south','CON','id_anexo','ASC','id_contrato','','','','','borrador','borrador');
select wf.f_import_ttipo_estado ('insert','borrador','CON','Solicitados','si','no','no','ninguno','','ninguno','','','no','no',NULL,'<font
color="99CC00" size="5"><font
size="4">{TIPO_PROCESO}</font></font><br><br><b>&nbsp;</b>Tramite:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp; &nbsp;&nbsp; <b>{NUM_TRAMITE}</b><br><b>&nbsp;</b>Usuario
:<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {USUARIO_PREVIO} </b>en
estado<b>&nbsp;
{ESTADO_ANTERIOR}<br></b>&nbsp;<b>Responsable:&nbsp;&nbsp;
&nbsp;&nbsp; </b><b>{FUNCIONARIO_PREVIO}&nbsp;
{DEPTO_PREVIO}<br>&nbsp;</b>Estado Actual<b>: &nbsp; &nbsp;&nbsp;
{ESTADO_ACTUAL}</b><br><br><br>&nbsp;{OBS} <br>','Nuevo tramite {NUM_TRAMITE} en estado "{ESTADO_ACTUAL}"','','no','','','','','','','',NULL);
select wf.f_import_ttipo_estado ('insert','pendiente_asignacion','CON','Pendientes de Asignación','no','no','no','listado','','ninguno','','','si','no',NULL,'Estimad@ {FUNCIONARIO_ACTUAL}<br><br>Existe una nueva solicitud de elaboración/revisión de contrato para&nbsp;&nbsp;<b>{$tabla.sujeto_contrato}&nbsp;</b>por&nbsp;<b>{$tabla.monto} {$tabla.moneda}</b>. El número de trámite es&nbsp;<b>{NUM_TRAMITE}.&nbsp;</b><br><br><br>Para los siguientes conceptos:&nbsp;<b>{$tabla.desc_ingas}</b><br><br>Por favor designe un abogado responsable para realizar esta tarea.<br><br><br><br>Atte.<br><br>ERP-BOA<br>','Nuevo tramite {NUM_TRAMITE} en estado "{ESTADO_ACTUAL}"','','si','','','','','','','',NULL);
select wf.f_import_ttipo_estado ('insert','registro','CON','Por Elaborar/Revisar','no','no','no','listado','','ninguno','','','si','no',NULL,'Estimad@ {FUNCIONARIO_ACTUAL}<br><br>Usted ha sido desaginado para la elaboración/revisión del contrato con número de &nbsp;trámite&nbsp;<b>{NUM_TRAMITE}</b>&nbsp;corresponiente al proveedor &nbsp;<b>{$tabla.sujeto_contrato}&nbsp;</b>por un monto de &nbsp;<b>{$tabla.monto} {$tabla.moneda}</b>.&nbsp;<br><br>Para los siguientes conceptos:&nbsp;<b>{$tabla.desc_ingas}</b><br><br>Por favor revise la información en el ERP para mayor información.<br><br><br><br>Atte.<br><br>ERP-BOA<br><br>OBS:<b>{OBS}</b>','Nuevo tramite {NUM_TRAMITE} en estado "{ESTADO_ACTUAL}"','','no','','','','','','','',NULL);
select wf.f_import_ttipo_estado ('insert','finalizado','CON','Elaborados','no','no','si','funcion_listado','leg.f_lista_abogado_asignado_wf_sel','ninguno','','','no','no',NULL,'<font
color="99CC00" size="5"><font
size="4">{TIPO_PROCESO}</font></font><br><br><b>&nbsp;</b>Tramite:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp; &nbsp;&nbsp; <b>{NUM_TRAMITE}</b><br><b>&nbsp;</b>Usuario
:<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {USUARIO_PREVIO} </b>en
estado<b>&nbsp;
{ESTADO_ANTERIOR}<br></b>&nbsp;<b>Responsable:&nbsp;&nbsp;
&nbsp;&nbsp; </b><b>{FUNCIONARIO_PREVIO}&nbsp;
{DEPTO_PREVIO}<br>&nbsp;</b>Estado Actual<b>: &nbsp; &nbsp;&nbsp;
{ESTADO_ACTUAL}</b><br><br><br>&nbsp;{OBS} <br>','Nuevo tramite {NUM_TRAMITE} en estado "{ESTADO_ACTUAL}"','','no','','','','','','','',NULL);
select wf.f_import_ttipo_estado ('insert','anulado','CON','Anulados','no','no','si','anterior','','ninguno','','','no','si',NULL,'<font
color="99CC00" size="5"><font
size="4">{TIPO_PROCESO}</font></font><br><br><b>&nbsp;</b>Tramite:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp; &nbsp;&nbsp; <b>{NUM_TRAMITE}</b><br><b>&nbsp;</b>Usuario
:<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {USUARIO_PREVIO} </b>en
estado<b>&nbsp;
{ESTADO_ANTERIOR}<br></b>&nbsp;<b>Responsable:&nbsp;&nbsp;
&nbsp;&nbsp; </b><b>{FUNCIONARIO_PREVIO}&nbsp;
{DEPTO_PREVIO}<br>&nbsp;</b>Estado Actual<b>: &nbsp; &nbsp;&nbsp;
{ESTADO_ACTUAL}</b><br><br><br>&nbsp;{OBS} <br>','Nuevo tramite {NUM_TRAMITE} en estado "{ESTADO_ACTUAL}"','','no','','','','','','','',NULL);
select wf.f_import_ttipo_estado ('insert','firma_gerente','CON','en Firma Gerente','no','no','no','listado','','ninguno','','','si','no',NULL,'Estimad@ {FUNCIONARIO_ACTUAL}<br><br>Se ha remitido a su persona un nuevo contrato para gestionar la firma de la gerencia general GGN. El contrato tiene el número "{$tabla.numero}".&nbsp;<br><br>Una vez que el contrato tenga la firma en el documento físico, porfavor revise el módulo de contratos "Contratos en Firma Gerente" y busque el numero de tramite "{NUM_TRAMITE}" para pasarlo al siguiente estado.<br><br>Atte.<br><br>ERP-BOA<br><br><br>OBS:{OBS}','Nuevo tramite {NUM_TRAMITE} en estado "{ESTADO_ACTUAL}"','','no','','','','','','','','registro');
select wf.f_import_ttipo_estado ('insert','firma_contraparte','CON','en Firma de Contraparte','no','no','no','funcion_listado','leg.f_lista_firma_contraparte_wf_sel','ninguno','','','si','no',NULL,'Estimad@ {FUNCIONARIO_ACTUAL}<br><br>Usted ha sido designado para gestionar la firma del proveedor en el contrato "{$tabla.numero}". Por favor revise el módulo de contratos "Contratos en Firma Contraparte" y busque el numero de tramite "{NUM_TRAMITE}".<br><br>Una vez que el contrato haya sido firmado, pasar el contrato al siguiente estado previo registro de la información o documentación que el sistema requiera.<br><br><br><br>Atte.<br><br>ERP-BOA<br><br><br>OBS:{OBS}','Nuevo tramite {NUM_TRAMITE} en estado "{ESTADO_ACTUAL}"','','no','','','','','','','',NULL);
select wf.f_import_ttipo_estado ('insert','digitalizacion','CON','para Digitalizacion','no','no','no','listado','','ninguno','','','no','no',NULL,'<font color="99CC00" size="5"><font size="4">{TIPO_PROCESO}</font></font><br><br><b>&nbsp;</b>Tramite:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; <b>{NUM_TRAMITE}</b><br><b>&nbsp;</b>Usuario :<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {USUARIO_PREVIO} </b>en estado<b>&nbsp; {ESTADO_ANTERIOR}<br></b>&nbsp;<b>Responsable:&nbsp;&nbsp; &nbsp;&nbsp; </b><b>{FUNCIONARIO_PREVIO}&nbsp; {DEPTO_PREVIO}<br>&nbsp;</b>Estado Actual<b>: &nbsp; &nbsp;&nbsp; {ESTADO_ACTUAL}</b><br><br><br>&nbsp;{OBS} <br>','Nuevo tramite {NUM_TRAMITE} en estado "{ESTADO_ACTUAL}"','','no','','','','','','','',NULL);
select wf.f_import_ttipo_estado ('insert','vobo_abogado','CON','Visto Bueno Abogado','no','no','no','funcion_listado','leg.f_lista_abogado_asignado_wf_sel','ninguno','','','no','no',NULL,'<font color="99CC00" size="5"><font size="4">{TIPO_PROCESO}</font></font><br><br><b>&nbsp;</b>Tramite:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; <b>{NUM_TRAMITE}</b><br><b>&nbsp;</b>Usuario :<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {USUARIO_PREVIO} </b>en estado<b>&nbsp; {ESTADO_ANTERIOR}<br></b>&nbsp;<b>Responsable:&nbsp;&nbsp; &nbsp;&nbsp; </b><b>{FUNCIONARIO_PREVIO}&nbsp; {DEPTO_PREVIO}<br>&nbsp;</b>Estado Actual<b>: &nbsp; &nbsp;&nbsp; {ESTADO_ACTUAL}</b><br><br><br>&nbsp;{OBS} <br>','Nuevo tramite {NUM_TRAMITE} en estado "{ESTADO_ACTUAL}"','','no','','','','','','','',NULL);
select wf.f_import_ttipo_estado ('insert','vobo_jefe_legal','CON','Visto Bueno Legal','no','no','no','funcion_listado','leg.f_lista_abogado_asignado_wf_sel','ninguno','','','no','no',NULL,'<font color="99CC00" size="5"><font size="4">{TIPO_PROCESO}</font></font><br><br><b>&nbsp;</b>Tramite:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; <b>{NUM_TRAMITE}</b><br><b>&nbsp;</b>Usuario :<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {USUARIO_PREVIO} </b>en estado<b>&nbsp; {ESTADO_ANTERIOR}<br></b>&nbsp;<b>Responsable:&nbsp;&nbsp; &nbsp;&nbsp; </b><b>{FUNCIONARIO_PREVIO}&nbsp; {DEPTO_PREVIO}<br>&nbsp;</b>Estado Actual<b>: &nbsp; &nbsp;&nbsp; {ESTADO_ACTUAL}</b><br><br><br>&nbsp;{OBS} <br>','Nuevo tramite {NUM_TRAMITE} en estado "{ESTADO_ACTUAL}"','','no','','','','','','','',NULL);
select wf.f_import_ttipo_estado ('insert','vobo_rpc','CON','Visto Bueno RPC','no','no','no','listado','','ninguno','','','si','no',NULL,'Estimad@ {FUNCIONARIO_ACTUAL}<br><br>Se ha remitido a su persona un nuevo contrato para el correspondiente visto bueno de RPC. El contrato tiene el número "{$tabla.numero}".&nbsp;<br><br>Una vez que haya dado su visto bueno al contrato físico, porfavor revise el módulo de contratos "Contratos Visto Bueno RPC" y busque el numero de tramite "{NUM_TRAMITE}" para pasarlo al siguiente estado.<br><br>Atte.<br><br>ERP-BOA<br><br><br>OBS:{OBS}','Nuevo tramite {NUM_TRAMITE} en estado "{ESTADO_ACTUAL}"','','no','','','','','','','','registro');
select wf.f_import_ttipo_estado ('insert','vobo_gaf','CON','Visto Bueno GAF','no','no','no','listado','','ninguno','','','si','no',NULL,'Estimad@ {FUNCIONARIO_ACTUAL}<br><br>Se ha remitido a su persona un nuevo contrato para gestionar el visto bueno de la gerencia administrativa GAF. El contrato tiene el número "{$tabla.numero}".&nbsp;<br><br>Una vez que el contrato tenga el visto bueno en el documento físico, porfavor revise el módulo de contratos "Contratos Visto Bueno&nbsp;GAF" y busque el numero de tramite "{NUM_TRAMITE}" para pasarlo al siguiente estado.<br><br>Atte.<br><br>ERP-BOA<br><br><br>OBS:{OBS}','Nuevo tramite {NUM_TRAMITE} en estado "{ESTADO_ACTUAL}"','','no','','','','','','','','registro');
select wf.f_import_ttipo_estado ('insert','contraparte_regional','CON','en Firma Contraparte Regional','no','no','no','listado','','ninguno','','','no','no',NULL,'<font color="99CC00" size="5"><font size="4">{TIPO_PROCESO}</font></font><br><br><b>&nbsp;</b>Tramite:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; <b>{NUM_TRAMITE}</b><br><b>&nbsp;</b>Usuario :<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {USUARIO_PREVIO} </b>en estado<b>&nbsp; {ESTADO_ANTERIOR}<br></b>&nbsp;<b>Responsable:&nbsp;&nbsp; &nbsp;&nbsp; </b><b>{FUNCIONARIO_PREVIO}&nbsp; {DEPTO_PREVIO}<br>&nbsp;</b>Estado Actual<b>: &nbsp; &nbsp;&nbsp; {ESTADO_ACTUAL}</b><br><br><br>&nbsp;{OBS} <br>','Nuevo tramite {NUM_TRAMITE} en estado "{ESTADO_ACTUAL}"','','no','','','','','','','',NULL);
select wf.f_import_ttipo_estado ('insert','revision','CON','Revisión','no','no','no','ninguno','','depto_listado','','','no','no',NULL,'<font color="99CC00" size="5"><font size="4">{TIPO_PROCESO}</font></font><br><br><b>&nbsp;</b>Tramite:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; <b>{NUM_TRAMITE}</b><br><b>&nbsp;</b>Usuario :<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {USUARIO_PREVIO} </b>en estado<b>&nbsp; {ESTADO_ANTERIOR}<br></b>&nbsp;<b>Responsable:&nbsp;&nbsp; &nbsp;&nbsp; </b><b>{FUNCIONARIO_PREVIO}&nbsp; {DEPTO_PREVIO}<br>&nbsp;</b>Estado Actual<b>: &nbsp; &nbsp;&nbsp; {ESTADO_ACTUAL}</b><br><br><br>&nbsp;{OBS} <br>','Nuevo tramite {NUM_TRAMITE} en estado "{ESTADO_ACTUAL}"','','no','','','','','','','',NULL);
select wf.f_import_ttipo_estado ('insert','archivo_legal','CON','Archivo Depto Legal','no','no','no','listado','','ninguno','','','si','no',NULL,'Estimad@ {FUNCIONARIO_ACTUAL}<br><br>Se ha remitido a su persona un nuevo contrato para la finalización del proceso de elaboración/revision y digitalizacion del contrato.<br><br>Por favor ingrese al ERP módulo de contratos y &nbsp;"Contratos Archivo Depto Legal" y busque el numero de tramite "{NUM_TRAMITE}" , revise que el contrato se encuentre escaneado con las dos firmas y pase al siguiente estado.<br><br>Atte.<br><br>ERP-BOA<br><br><br>OBS:En caso de que no se tenga el contrato escaneado con las dos firmas, puede observar a la unidad solicitante hasta que le remitan esta documentación.','Nuevo tramite {NUM_TRAMITE} en estado "{ESTADO_ACTUAL}"','','no','','','','','','','',NULL);
select wf.f_import_ttipo_estado ('insert','vobo_comercial','CON','VoBo Gerencia Comercial','no','no','no','listado','','ninguno','','','no','no',NULL,'<font color="99CC00" size="5"><font size="4">{TIPO_PROCESO}</font></font><br><br><b>&nbsp;</b>Tramite:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; <b>{NUM_TRAMITE}</b><br><b>&nbsp;</b>Usuario :<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {USUARIO_PREVIO} </b>en estado<b>&nbsp; {ESTADO_ANTERIOR}<br></b>&nbsp;<b>Responsable:&nbsp;&nbsp; &nbsp;&nbsp; </b><b>{FUNCIONARIO_PREVIO}&nbsp; {DEPTO_PREVIO}<br>&nbsp;</b>Estado Actual<b>: &nbsp; &nbsp;&nbsp; {ESTADO_ACTUAL}</b><br><br><br>&nbsp;{OBS} <br>','Nuevo tramite {NUM_TRAMITE} en estado "{ESTADO_ACTUAL}"','','no','','','','','','','',NULL);
select wf.f_import_ttipo_columna ('insert','tipo','CON','CON','varchar','','30','','','Elija el Tipo de
Contrato','','','TextField','Tipo de Contrato','si','','{"config":{"emptyText":"Tipo...",
"typeAhead": false,       "triggerAction": "all",
"lazyRender":true,
"mode": "local",
"store":["administrativo","administrativo_alquiler","administrativo_internacional","comercial"]}}',1,NULL);
select wf.f_import_ttipo_columna ('insert','objeto','CON','CON','text','','','','','','','','TextArea','Objeto del Contrato','no','','{bottom_filter: true}',1,NULL);
select wf.f_import_ttipo_columna ('insert','fecha_inicio','CON','CON','date','','','','','La fecha en
la que empieza a correr el contrato','','','DateField','Fecha Inicio Estimada','no','','{"config":{format: "d/m/Y", renderer:function
(value,p,record){return value?value.dateFormat("d/m/Y"):""},
anchor : "50%"}}',6,NULL);
select wf.f_import_ttipo_columna ('insert','fecha_fin','CON','CON','date','','','','','Fecha en la que
termina la validez del contrato. Dejar en blanco si no tiene fecha
final de validez','','','DateField','Fecha Fin Estimada','no','','{"config":{format:
"d/m/Y",
renderer:function (value,p,record){return value?value.dateFormat("d/m/Y"):""},
anchor:"50%"}}',9,NULL);
select wf.f_import_ttipo_columna ('insert','numero','CON','CON','varchar','Número de
contrato','','','','','','','TextField','Número deContrato','no','','{"config":{anchor:"80%", allowBlank:true},
bottom_filter: true}',3,NULL);
select wf.f_import_ttipo_columna ('insert','id_gestion','CON','CON','integer','','','ges.gestion gestion integer','inner join param.tgestion ges on ges.id_gestion =
con.id_gestion','Gestión en la que fue suscrito el contrato','{
       pfiltro : "ges.gestion",
type : "numeric"
}','gestion numeric','NumberField','Gestión','si','GESTION','{"config":{
  name : "id_gestion",
  origen : "GESTION",
  fieldLabel : "Gestion",
  allowBlank : false,
  gdisplayField : "gestion",//mapea al store del grid
  gwidth : 100,
  renderer : function (value, p, record){return String.format("{0}",
record.data["gestion"]);}
          }}',3,NULL);
select wf.f_import_ttipo_columna ('insert','id_persona','CON','CON','integer','','','','','Persona con
la que se suscribe el
contrato','','','NumberField','Persona','si','','',4,NULL);
select wf.f_import_ttipo_columna ('insert','id_institucion','CON','CON','integer','','','','','Institución
con la que se suscribe el
contrato','','','NumberField','Institucion','si','','',NULL,NULL);
select wf.f_import_ttipo_columna ('insert','id_proveedor','CON','CON','integer','','','prov.desc_proveedor desc_proveedor varchar','left join param.vproveedor prov on
prov.id_proveedor = con.id_proveedor','Proveedor con el que se
suscribe el contrato','{pfiltro:"prov.desc_proveedor",type:"string"}','desc_proveedor string','NumberField','Proveedor','si','PROVEEDOR','{"config":{
                name:"id_proveedor",
                origen:"PROVEEDOR",
                fieldLabel:"Proveedor",
                allowBlank:true,
                tinit:false,
                gwidth:200,
                gdisplayField: "desc_proveedor"
             },
bottom_filter: true}',4,NULL);
select wf.f_import_ttipo_columna ('insert','observaciones','CON','CON','text','','','','','Observaciones
a este Contrato','','','TextArea','Observaciones','no','','',12,NULL);
select wf.f_import_ttipo_columna ('insert','solicitud','CON','CON','text','','','','','Detalle de la
solicitud para elaboración de
contrato','','','TextArea','Solicitud','no','','',4,NULL);
select wf.f_import_ttipo_columna ('insert','monto','CON','CON','numeric','','18_2','','','El monto del
contrato por lo general debe ser el monto
total','','','NumberField','Monto del Contrato','no','','',4,NULL);
select wf.f_import_ttipo_columna ('insert','id_moneda','CON','CON','integer','','','mon.moneda moneda varchar','inner join param.tmoneda mon on mon.id_moneda =
con.id_moneda','','{
                pfiltro:"mon.moneda",
                type:"string"
            }','moneda string','NumberField','Moneda delContrato','si','MONEDA','{"config":{
               name:"id_moneda",
                origen:"MONEDA",
                 allowBlank:false,
                fieldLabel:"Moneda",
                gdisplayField:"moneda",//mapea al store del grid
                gwidth:50
             }}',5,NULL);
select wf.f_import_ttipo_columna ('insert','fecha_elaboracion','CON','CON','date','','','','','Fecha de
Elaboración','','','DateField','Fecha de
Elaboración','no','','{"config":{renderer:function (value,p,record){return
value?value.dateFormat("d/m/Y"):""},
anchor:"50%",
format: "d/m/Y"}}',2,NULL);
select wf.f_import_ttipo_columna ('insert','plazo','CON','CON','integer','','','','','Plazo en
Días','','','NumberField','Plazo','no','','{"config":{anchor:"80%"}}',8,NULL);
select wf.f_import_ttipo_columna ('insert','tipo_plazo','CON','CON','varchar','','','','','Días hábiles
o días calendario','','','string','Tipo de Plazo','si','','{"config":{"emptyText":"Tipo...",
"typeAhead": false,       "triggerAction": "all",
anchor:"50%",
"lazyRender":true,
"mode": "local",
"store":["fecha_fija","tiempo_indefinido"]}}',7,NULL);
select wf.f_import_ttipo_columna ('insert','id_cotizacion','CON','CON','integer','','','','','','','','NumberField','','no','','',NULL,NULL);
select wf.f_import_ttipo_columna ('delete','MARRI','CON','CON',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
							NULL,NULL,NULL,NULL,NULL,NULL,NULL);
select wf.f_import_ttipo_columna ('insert','periodicidad_pago','CON','CON','varchar','','50','','','Periodicidad
con la que se realizará los pagos al
proveedor','','','TextField','Periodicidad
Pago','si','','{"config":{"emptyText":"Period...",
"typeAhead": false,       "triggerAction": "all",
anchor:"50%",
"lazyRender":true,
"mode": "local",
"store":["mensual","bimestral","trimestral","anual","pago_unico","otro"]}}',10,NULL);
select wf.f_import_ttipo_columna ('insert','tiene_retencion','CON','CON','varchar','','2','','','Si
tiene retención de garantía','','','TextField','Tiene
Retención','si','','{"config":{"emptyText":"Tiene...",
"typeAhead": false,       "triggerAction": "all",
anchor:"50%",
"lazyRender":true,
"mode": "local",
"store":["si","no"]}}',11,NULL);
select wf.f_import_ttipo_columna ('delete','fk_id_contrato','CON','CON',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
							NULL,NULL,NULL,NULL,NULL,NULL,NULL);
select wf.f_import_ttipo_columna ('insert','tipo','ANX','CON','varchar','','30','','','Tipo del anexo ','','','TextField','Tipo de Anexo','si','','{"config":{"emptyText":"Tipo de Anexo ...",
"typeAhead": false,       		"triggerAction": "all",
"lazyRender":true,
"mode": "local",
"store":["boleta_garantia","memo","adenda"]}}',NULL,NULL);
select wf.f_import_ttipo_columna ('insert','descripcion','ANX','CON','varchar','','1000','','','Descripción del anexo registrado','','','TextArea','Descripción','no','','',NULL,NULL);
select wf.f_import_ttipo_columna ('insert','fecha_desde','ANX','CON','date','','','','','Fecha inicial de la vigencia del anexo','','','DateField','Fecha desde','no','','{"config":{format: "d/m/Y",				renderer:function (value,p,record){return value?value.dateFormat("d/m/Y"):""},
anchor : "50%"}}',NULL,NULL);
select wf.f_import_ttipo_columna ('insert','fecha_hasta','ANX','CON','date','','','','','Fecha final de la vigencia del anexo','','','DateField','Fecha hasta','no','','{"config":{format: "d/m/Y",				renderer:function (value,p,record){return value?value.dateFormat("d/m/Y"):""},
anchor : "50%"}}',NULL,NULL);
select wf.f_import_ttipo_columna ('insert','modo','CON','CON','varchar','','30','','','Se refiere si será Contrato normal, adenda u otra modalidad','','','TextField','Tipo','si','','{"config":{"emptyText":"Modo...",
"typeAhead": false,       		"triggerAction": "all",
"lazyRender":true,
"mode": "local",
"store":["contrato","adenda"]}}',22,NULL);
select wf.f_import_ttipo_columna ('insert','id_contrato_fk','CON','CON','integer','','','view.desc_contrato_fk desc_contrato_fk text','','',NULL,'desc_contrato_fk string','NumberField','','si','','{"config":{
				name: "id_contrato_fk",
				hiddenName: "id_contrato_fk",
				fieldLabel: "Contrato",
				typeAhead: false,
				forceSelection: false,
				allowBlank: true,
				disabled: false,
				emptyText: "Contratos...",
				store: new Ext.data.JsonStore({
					url: "../../sis_workflow/control/Tabla/listarTablaCombo",
					id: "id_contrato",
					root: "datos",
					sortInfo: {
						field: "id_contrato",
						direction: "ASC"
					},
					totalProperty: "total",
					fields: ["id_contrato", "numero", "tipo", "objeto", "estado", "desc_proveedor","monto","moneda","fecha_inicio","fecha_fin","nro_tramite","solicitud"],
					// turn on remote sorting
					remoteSort: true,
					baseParams: {par_filtro:"con.numero#con.tipo#con.monto#prov.desc_proveedor#con.objeto#con.monto", tipo_proceso:"CON",tipo_estado:"finalizado","id_tabla":"3"}
				}),
				valueField: "id_contrato",
				displayField: "numero",
				tpl: "<tpl for=\".\"><div class=\"x-combo-list-item\"><p> {desc_proveedor}</p><p>{solicitud}</p><p>Nro: <b>{numero}</b></p></div></tpl>",
				gdisplayField: "desc_contrato_fk",
				triggerAction: "all",
				lazyRender: true,
				mode: "remote",
				pageSize: 20,
				queryDelay: 200,
				listWidth:280,
				minChars: 2,
				gwidth: 100,
				anchor: "80%",
				renderer: function(value, p, record) {
					return String.format("{0}", record.data["desc_contrato_fk"]);
				}

			}}',23,NULL);
select wf.f_import_ttipo_columna ('insert','id_concepto_ingas','CON','CON','integer[]','Conceptos de Gasto','','view.desc_ingas desc_ingas text','inner join leg.vcontrato view on view.id_contrato = con.id_contrato','','','desc_ingas string','TextField','Concepto de Gasto','si','','			{"config":{
                name:"id_concepto_ingas",
                fieldLabel:"Conceptos Gasto",
                emptyText:"Conceptos de Gasto ...",
                store: new Ext.data.JsonStore({
					 url: "../../sis_parametros/control/ConceptoIngas/listarConceptoIngasMasPartida",
					 id: "id_concepto_ingas",
					 root: "datos",
					 sortInfo:{
						field: "desc_ingas",
						direction: "ASC"
                    },
                    totalProperty: "total",
                    fields: ["id_concepto_ingas","tipo","desc_ingas","movimiento","desc_partida","id_grupo_ots","filtro_ot","requiere_ot"],
                    remoteSort: true,
                    baseParams:{par_filtro:"desc_ingas#par.codigo#par.nombre_partida",movimiento:"gasto"}
                    }),
                valueField: "id_concepto_ingas",
                displayField: "desc_ingas",
                gdisplayField:"desc_ingas",
                hiddenName: "id_concepto_ingas",
                forceSelection:true,
                typeAhead: false,
                triggerAction: "all",
                lazyRender:true,
                mode:"remote",
                pageSize:10,
                queryDelay:1000,
                listWidth:600,
                resizable:true,
                gwidth: 200,
				enableMultiSelect:true,
                renderer:function(value, p, record){return String.format("{0}", record.data["desc_ingas"]);}
            }}',20,NULL);
select wf.f_import_ttipo_columna ('insert','id_orden_trabajo','CON','CON','integer[]','Ordenes de Trabajo','','view.desc_ot desc_ot text','','','','desc_ot string','TextField','Ordenes de Trabajo','si','','			{"config":{
                name:"id_orden_trabajo",
                fieldLabel:"Ordenes de Trabajo",
                emptyText:"Ordenes de Trabajo ...",
                store: new Ext.data.JsonStore({
					 url: "../../sis_contabilidad/control/OrdenTrabajo/listarOrdenTrabajo",
					 id: "id_orden_trabajo",
					 root: "datos",
					 sortInfo:{
						field: "motivo_orden",
						direction: "ASC"
                    },
                    totalProperty: "total",
                    fields: ["id_orden_trabajo","motivo_orden","desc_orden"],
                    remoteSort: true,
                    baseParams:{par_filtro: "desc_orden#motivo_orden"}
                    }),
                valueField: "id_orden_trabajo",
                displayField: "desc_orden",
                gdisplayField:"desc_ot",
                hiddenName: "id_orden_trabajo",
                forceSelection:true,
                typeAhead: false,
                triggerAction: "all",
                lazyRender:true,
                mode:"remote",
                pageSize:10,
                queryDelay:1000,
                listWidth:600,
                resizable:true,
                gwidth: 200,
				gwidth: 200,
				enableMultiSelect:true,
                renderer:function(value, p, record){return String.format("{0}", record.data["desc_ot"]);}
            }}',15,NULL);
select wf.f_import_ttipo_columna ('insert','cargo','CON','CON','varchar','','50','','','Cargo','','','TextField','Cargo','no','','',16,NULL);
select wf.f_import_ttipo_columna ('insert','forma_contratacion','CON','CON','varchar','','30','','','Forma de contratación','','','TextField','Forma Contratación','si','','{"config":{"emptyText":"Tipo...",
"typeAhead": false,       "triggerAction": "all",
anchor:"50%",
"lazyRender":true,
"mode": "local",
"store":["forma1","forma2","forma3"]}}',18,NULL);
select wf.f_import_ttipo_columna ('insert','modalidad','CON','CON','varchar','','30','','','Modalidad del contrato','','','TextField','Modalidad','si','','{"config":{"emptyText":"Tipo...",
"typeAhead": false,       "triggerAction": "all",
anchor:"50%",
"lazyRender":true,
"mode": "local",
"store":["modalidad1","modalidad2"]}}',19,NULL);
select wf.f_import_ttipo_columna ('insert','representante_legal','CON','CON','varchar','','100','','','Representante Legal','','','TextField','Representante Legal','no','','',20,NULL);
select wf.f_import_ttipo_columna ('insert','rpc','CON','CON','varchar','','100','','','RPC','','','TextField','RPC','no','','',21,NULL);
select wf.f_import_ttipo_columna ('insert','mae','CON','CON','varchar','','100','','','MAE','','','TextField','MAE','no','','',22,NULL);
select wf.f_import_ttipo_columna ('insert','contrato_adhesion','CON','CON','varchar','','2','','','','','','TextField','Adhesion','si','','{"config":{"emptyText":"Adhesion...",
"typeAhead": false,       "triggerAction": "all",
"lazyRender":true,
"mode": "local",
"store":["si","no"]}}',2,NULL);
select wf.f_import_ttipo_columna ('insert','id_abogado','CON','CON','integer','Abogado Asignado','','desc_abogado desc_abogado text','','','','desc_abogado string','NumberField','Abogado','si','FUNCIONARIO','{"config":{
       		    name:"id_abogado",
       		     hiddenName: "id_abogado",
   				origen:"FUNCIONARIO",
   				fieldLabel:"Abogado",
   				allowBlank:false,
                gwidth:200,
   				valueField: "id_funcionario",
   			    gdisplayField: "desc_abogado",
      			renderer:function(value, p, record){return String.format("{0}", record.data["desc_abogado"]);}
       	     }}



',16,NULL);
select wf.f_import_ttipo_columna ('insert','id_lugar','CON','CON','integer','','','lug.nombre nombre_lugar varchar','left join param.tlugar lug on lug.id_lugar = con.id_lugar','Lugar en el que firmará el proveedor','{
                pfiltro:"lug.nombre",
                type:"string"
            }','nombre_lugar string','TextField','Lugar de Firma','si','','{
			config:{
				name: "id_lugar",
				allowBlank: false,
				emptyText:"Lugar...",
                                                                forceSelection:true,
				store:new Ext.data.JsonStore(
				{
					url: "../../sis_parametros/control/Lugar/listarLugar",
					id: "id_lugar",
					root: "datos",
					sortInfo:{
						field: "nombre",
						direction: "ASC"
					},
					totalProperty: "total",
					fields: ["id_lugar","id_lugar_fk","codigo","nombre","tipo","sw_municipio","sw_impuesto","codigo_largo"],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:"nombre",tipo:"departamento"}
				}),
				valueField: "id_lugar",
				displayField: "nombre",
				gdisplayField:"nombre_lugar",
				hiddenName: "id_lugar",
    			triggerAction: "all",
    			lazyRender:true,
				mode:"remote",
				pageSize:50,
				queryDelay:500,
				anchor:"100%",
				gwidth:220,
				minChars:2,
				renderer:function (value, p, record){return String.format("{0}", record.data["lugar"]);}

			}
		}',11,NULL);
select wf.f_import_ttipo_columna ('insert','id_funcionario','CON','CON','integer','Nombre del solicitante del contrato','','solicitante solicitante text','','','','solicitante string','NumberField','Solicitante','si','FUNCIONARIO','
{"config":{
       		    name:"id_funcionario",
       		     hiddenName: "id_funcionario",
   				origen:"FUNCIONARIO",
   				fieldLabel:"Solicitante",
   				allowBlank:false,

                gwidth:200,
   				valueField: "id_funcionario",
   			    gdisplayField: "solicitante",
      			renderer:function(value, p, record){return String.format("{0}", record.data["solicitante"]);}
       	     }}',1,NULL);
select wf.f_import_ttipo_columna ('insert','rpc_regional','CON','CON','varchar','','','','','','','','TextField','','no','','',NULL,NULL);
select wf.f_import_ttipo_columna ('insert','bancarizacion','CON','CON','varchar','','2','','','Si se bancariza o no este contrato','','','TextField','Bancarizacion','si','','{"config":{"emptyText":"Banc...",
"typeAhead": false,       "triggerAction": "all",
"lazyRender":true,
"mode": "local",
"store":["si","no"]}}',19,NULL);
select wf.f_import_ttipo_columna ('insert','tipo_monto','CON','CON','varchar','','','','','Si el monto del contrato es abierto (por tasa o precio unitario) o cerrado con un monto total fijo','','','TextField','Tipo Monto','si','','{"config":{"emptyText":"Monto...",
"typeAhead": false,       "triggerAction": "all",
"lazyRender":true,
"mode": "local",
"store":["abierto","cerrado"]}}',18,NULL);
select wf.f_import_ttipo_columna ('insert','resolucion_bancarizacion','CON','CON','varchar','','','','','Que resolución de bancarización aplica','','','TextField','Resolución','si','','{"config":{"emptyText":"Reso...",
"typeAhead": false,       "triggerAction": "all",
"lazyRender":true,
"mode": "local",
"store":["10-0017-15","10-0011-11"]}}',20,NULL);
select wf.f_import_ttipo_columna ('insert','tipo_boleta','ANX','CON','varchar','','20','','','','','','TextField','Tipo Boleta','si','','{"config":{"emptyText":"tipo...",
"typeAhead": false,       		"triggerAction": "all",
"lazyRender":true,
"mode": "local",
"store":["boleta","poliza"]}}',NULL,NULL);
select wf.f_import_ttipo_columna ('insert','moneda','ANX','CON','varchar','','3','','','','','','TextField','Moneda','no','','',NULL,NULL);
select wf.f_import_ttipo_columna ('insert','monto','ANX','CON','numeric','','','','','','','','NumberField','Monto','no','','',NULL,NULL);
select wf.f_import_ttipo_columna ('insert','id_agencia','CON','CON','integer','','','age.nombre nombre_agencia varchar','left join obingresos.tagencia age on
age.id_agencia = con.id_agencia','Agecnia con la que se firma el contrato','{pfiltro:"age.nombre",type:"string"}','nombre_agencia string','NumberField','Agencia','si','','   {"config":{
                name:"id_agencia",
                fieldLabel:"Agencia",
                emptyText:"Agencia ...",
                store: new Ext.data.JsonStore({
      url: "../../sis_obingresos/control/Agencia/listarAgencia",
      id: "id_agencia",
      root: "datos",
      sortInfo:{
      field: "nombre",
      direction: "ASC"
                    },
                    totalProperty: "total",
                    fields: ["id_agencia","nombre"],
                    remoteSort: true,
                    baseParams:{par_filtro: "nombre"}
                    }),
                valueField: "id_agencia",
                displayField: "nombre",
                gdisplayField:"nombre_agencia",
                hiddenName: "id_agencia",
                forceSelection:true,
                typeAhead: false,
                triggerAction: "all",
                lazyRender:true,
                mode:"remote",
                pageSize:10,
                queryDelay:1000,
                listWidth:600,
                resizable:true,
                gwidth: 200,
    gwidth: 200,

                renderer:function(value, p, record){return String.format("{0}", record.data["nombre_agencia"]);}
            },
bottom_filter: true}',6,NULL);
select wf.f_import_ttipo_columna ('insert','tipo_agencia','CON','CON','varchar','','30','','','Elija el tipo de agencia','','','TextField','Tipo de Agencia','si','','{"config":{"emptyText":"Tipo...",
"typeAhead": false,       "triggerAction": "all",
"lazyRender":true,
"mode": "local",
"store":["iata","noiata","corporativa","freelancer"]}}',9,NULL);
select wf.f_import_ttipo_columna ('insert','moneda_restrictiva','CON','CON','varchar','','2','','','Si se va a exigir que el pago sea en la misma moneda que la venta','','','TextField','','si','','{"config":{"emptyText":"Moneda...",
"typeAhead": false,       "triggerAction": "all",
"lazyRender":true,
"mode": "local",
"store":["si","no"]}}',10,NULL);
select wf.f_import_ttipo_columna ('insert','cuenta_bancaria1','CON','CON','varchar','','30','','','','','','TextField','Cuenta Bancaria 1','no','','',NULL,NULL);
select wf.f_import_ttipo_columna ('insert','entidad_bancaria1','CON','CON','varchar','','45','','','','','','TextField','Entidad Bancaria 1','no','','',NULL,NULL);
select wf.f_import_ttipo_columna ('insert','nombre_cuenta_bancaria1','CON','CON','varchar','','100','','','','','','TextField','Nombre Cuenta Bancaria','no','','',NULL,NULL);
select wf.f_import_ttipo_columna ('insert','cuenta_bancaria2','CON','CON','varchar','','30','','','','','','TextField','Cuenta Bancaria 2','no','','',NULL,NULL);
select wf.f_import_ttipo_columna ('insert','entidad_bancaria2','CON','CON','varchar','','45','','','','','','TextField','Entidad Bancaria 2','no','','',NULL,NULL);
select wf.f_import_ttipo_columna ('insert','nombre_cuenta_bancaria2','CON','CON','varchar','','100','','','','','','TextField','Nombre Cuenta Bancaria 2','no','','',NULL,NULL);
select wf.f_import_ttipo_columna ('insert','formas_pago','CON','CON','varchar[]','Formas de pago habilitadas para la agencia','','','','','','','TextField','Formas de Pago','si','','{"config":{
                name:"formas_pago",
                fieldLabel:"Formas de Pago",
                store:["prepago","postpago","billetera_movil","banca_internet"],
                forceSelection:true,
                typeAhead: false,
                triggerAction: "all",
                lazyRender:true,
                mode:"local",
                resizable:true,
		gwidth: 200,
		enableMultiSelect:true
            }}',NULL,NULL);
select wf.f_import_ttipo_columna ('insert','banco','ANX','CON','varchar','','30','','','','','','TextField','Banco','no','','',NULL,NULL);
select wf.f_import_ttipo_documento ('insert','CONTRATO','CON','Contrato','','','escaneado',0.00,NULL);
select wf.f_import_ttipo_documento ('insert','ADJ1','CON','Adjunto a Contrato 1','Adjunto a Contrato 1','','escaneado',1.00,'{}');
select wf.f_import_ttipo_documento ('insert','ADJ2','CON','Adjunto a Contrato 2','ADJ2','','escaneado',1.00,'{}');
select wf.f_import_ttipo_documento ('insert','contrato_adhesion','CON','Contrato de Adhesion','Contrato de Adhesion','','escaneado',1.00,'{legales}');
select wf.f_import_ttipo_documento ('insert','EPCONS','CON','Escritura Pública de Constitución de la Empresa','Fotocopia Legalizada de la Escritura Pública de Constitución de la Empresa','','escaneado',1.00,'{}');
select wf.f_import_ttipo_documento ('insert','PODRL','CON','Poder del Representante Legal','Poder del Representante Legal','','escaneado',1.00,'{}');
select wf.f_import_ttipo_documento ('insert','CIREP','CON','Carnet de Identidad','Carnet de Identidad','','escaneado',1.00,'{}');
select wf.f_import_ttipo_documento ('insert','NIT','CON','NIT','NIT','','escaneado',1.00,'{}');
select wf.f_import_ttipo_documento ('insert','LICFUN','CON','Licencia de Funcionamiento','Licencia de Funcionamiento','','escaneado',1.00,'{}');
select wf.f_import_ttipo_documento ('insert','REGFUN','CON','Registro Fundempresa','Registro Fundempresa','','escaneado',1.00,'{}');
select wf.f_import_ttipo_documento ('insert','CERPODFUN','CON','Certificado de Poder Fundepmresa','Certificado de Poder Fundepmresa','','escaneado',1.00,'{}');
select wf.f_import_ttipo_documento ('insert','BOLGAR','CON','Boleta de Garantia','Boleta de Garantia','','escaneado',1.00,'{}');
select wf.f_import_ttipo_documento ('insert','CARCONT','CON','Carta aceptacion contrato','Carta aceptacion contrato','','escaneado',1.00,'{}');
select wf.f_import_ttipo_documento ('insert','CERCUE','CON','Certificacion de Cuenta Bancaria','Certificacion de Cuenta Bancaria','','escaneado',1.00,'{}');
select wf.f_import_tcolumna_estado ('insert','tipo','CON','CON','borrador','exigir',NULL);
select wf.f_import_tcolumna_estado ('insert','objeto','CON','CON','registro','exigir',NULL);
select wf.f_import_tcolumna_estado ('insert','numero','CON','CON','registro','exigir','"{$tabla.contrato_adhesion}" = "no"');
select wf.f_import_tcolumna_estado ('insert','solicitud','CON','CON','borrador','registrar',NULL);
select wf.f_import_tcolumna_estado ('insert','monto','CON','CON','borrador','exigir','');
select wf.f_import_tcolumna_estado ('insert','id_moneda','CON','CON','borrador','exigir','');
select wf.f_import_tcolumna_estado ('insert','id_proveedor','CON','CON','borrador','exigir','');
select wf.f_import_tcolumna_estado ('insert','id_gestion','CON','CON','borrador','exigir','');
select wf.f_import_tcolumna_estado ('insert','objeto','CON','CON','borrador','ninguno','');
select wf.f_import_tcolumna_estado ('insert','fecha_inicio','CON','CON','borrador','ninguno','');
select wf.f_import_tcolumna_estado ('insert','fecha_fin','CON','CON','borrador','ninguno','');
select wf.f_import_tcolumna_estado ('insert','numero','CON','CON','borrador','ninguno','');
select wf.f_import_tcolumna_estado ('insert','id_persona','CON','CON','borrador','ninguno','');
select wf.f_import_tcolumna_estado ('insert','id_institucion','CON','CON','borrador','ninguno','');
select wf.f_import_tcolumna_estado ('insert','observaciones','CON','CON','borrador','ninguno','');
select wf.f_import_tcolumna_estado ('insert','fecha_elaboracion','CON','CON','borrador','ninguno','');
select wf.f_import_tcolumna_estado ('insert','plazo','CON','CON','borrador','ninguno','');
select wf.f_import_tcolumna_estado ('insert','tipo_plazo','CON','CON','borrador','ninguno','');
select wf.f_import_tcolumna_estado ('insert','fecha_inicio','CON','CON','registro','exigir','"{$tabla.contrato_adhesion}" = "no"');
select wf.f_import_tcolumna_estado ('insert','fecha_elaboracion','CON','CON','registro','exigir','"{$tabla.contrato_adhesion}"="no"');
select wf.f_import_tcolumna_estado ('insert','plazo','CON','CON','registro','registrar','');
select wf.f_import_tcolumna_estado ('insert','tipo_plazo','CON','CON','registro','exigir','"{$tabla.contrato_adhesion}" = "no"');
select wf.f_import_tcolumna_estado ('insert','periodicidad_pago','CON','CON','borrador','ninguno','');
select wf.f_import_tcolumna_estado ('insert','periodicidad_pago','CON','CON','registro','exigir','"{$tabla.contrato_adhesion}" = "no"');
select wf.f_import_tcolumna_estado ('insert','tiene_retencion','CON','CON','borrador','ninguno','');
select wf.f_import_tcolumna_estado ('insert','tiene_retencion','CON','CON','registro','exigir','"{$tabla.contrato_adhesion}" = "no"');
select wf.f_import_tcolumna_estado ('insert','fecha_fin','CON','CON','registro','registrar','');
select wf.f_import_tcolumna_estado ('insert','observaciones','CON','CON','registro','registrar','');
select wf.f_import_tcolumna_estado ('insert','monto','CON','CON','registro','registrar','');
select wf.f_import_tcolumna_estado ('delete','fk_id_contrato','CON','CON','borrador',NULL,NULL);
select wf.f_import_tcolumna_estado ('insert','tipo','ANX','CON','borrador','exigir','');
select wf.f_import_tcolumna_estado ('insert','descripcion','ANX','CON','borrador','exigir','');
select wf.f_import_tcolumna_estado ('insert','fecha_desde','ANX','CON','borrador','exigir','');
select wf.f_import_tcolumna_estado ('insert','fecha_hasta','ANX','CON','borrador','registrar','');
select wf.f_import_tcolumna_estado ('insert','modo','CON','CON','borrador','exigir','');
select wf.f_import_tcolumna_estado ('insert','id_concepto_ingas','CON','CON','borrador','exigir','');
select wf.f_import_tcolumna_estado ('delete','id_contrato_fk','CON','CON','borrador',NULL,NULL);
select wf.f_import_tcolumna_estado ('insert','id_orden_trabajo','CON','CON','borrador','registrar','');
select wf.f_import_tcolumna_estado ('insert','id_lugar','CON','CON','borrador','ninguno','');
select wf.f_import_tcolumna_estado ('insert','id_lugar','CON','CON','registro','exigir','"{$tabla.contrato_adhesion}" = "no" and "{$tabla.tipo}" != "administrativo_internacional"');
select wf.f_import_tcolumna_estado ('insert','id_contrato_fk','CON','CON','borrador','registrar','');
select wf.f_import_tcolumna_estado ('insert','contrato_adhesion','CON','CON','borrador','exigir','');
select wf.f_import_tcolumna_estado ('insert','contrato_adhesion','CON','CON','registro','exigir','');
select wf.f_import_tcolumna_estado ('insert','objeto','CON','CON','finalizado','registrar','');
select wf.f_import_tcolumna_estado ('insert','observaciones','CON','CON','finalizado','registrar','');
select wf.f_import_tcolumna_estado ('insert','objeto','CON','CON','revision','registrar',NULL);
select wf.f_import_tcolumna_estado ('insert','numero','CON','CON','revision','registrar',NULL);
select wf.f_import_tcolumna_estado ('insert','fecha_inicio','CON','CON','revision','registrar','');
select wf.f_import_tcolumna_estado ('insert','fecha_elaboracion','CON','CON','revision','registrar','');
select wf.f_import_tcolumna_estado ('insert','plazo','CON','CON','revision','registrar','');
select wf.f_import_tcolumna_estado ('insert','tipo_plazo','CON','CON','revision','registrar','');
select wf.f_import_tcolumna_estado ('insert','periodicidad_pago','CON','CON','revision','registrar','');
select wf.f_import_tcolumna_estado ('insert','tiene_retencion','CON','CON','revision','registrar','');
select wf.f_import_tcolumna_estado ('insert','fecha_fin','CON','CON','revision','registrar','');
select wf.f_import_tcolumna_estado ('insert','observaciones','CON','CON','revision','registrar','');
select wf.f_import_tcolumna_estado ('insert','monto','CON','CON','revision','registrar','');
select wf.f_import_tcolumna_estado ('insert','id_lugar','CON','CON','revision','registrar','');
select wf.f_import_tcolumna_estado ('insert','contrato_adhesion','CON','CON','revision','registrar','');
select wf.f_import_tcolumna_estado ('insert','objeto','CON','CON','finalizado','preregistro',NULL);
select wf.f_import_tcolumna_estado ('insert','numero','CON','CON','finalizado','registrar','');
select wf.f_import_tcolumna_estado ('insert','fecha_inicio','CON','CON','finalizado','registrar','');
select wf.f_import_tcolumna_estado ('insert','fecha_elaboracion','CON','CON','finalizado','preregistro','');
select wf.f_import_tcolumna_estado ('insert','tipo_plazo','CON','CON','finalizado','preregistro','');
select wf.f_import_tcolumna_estado ('insert','periodicidad_pago','CON','CON','finalizado','preregistro','');
select wf.f_import_tcolumna_estado ('insert','tiene_retencion','CON','CON','finalizado','preregistro','');
select wf.f_import_tcolumna_estado ('delete','id_lugar','CON','CON','finalizado',NULL,NULL);
select wf.f_import_tcolumna_estado ('insert','contrato_adhesion','CON','CON','finalizado','preregistro','');
select wf.f_import_tcolumna_estado ('insert','id_abogado','CON','CON','revision','registrar','');
select wf.f_import_tcolumna_estado ('insert','id_abogado','CON','CON','finalizado','registrar','');
select wf.f_import_tcolumna_estado ('insert','id_proveedor','CON','CON','finalizado','registrar','');
select wf.f_import_tcolumna_estado ('insert','id_funcionario','CON','CON','borrador','exigir','');
select wf.f_import_tcolumna_estado ('insert','fecha_fin','CON','CON','finalizado','registrar','');
select wf.f_import_tcolumna_estado ('delete','contrato_adhesion','CON','CON','registro',NULL,NULL);
select wf.f_import_tcolumna_estado ('insert','fecha_elaboracion','CON','CON','firma_contraparte','exigir','"{$tabla.contrato_adhesion}"="si"');
select wf.f_import_tcolumna_estado ('insert','numero','CON','CON','firma_contraparte','exigir','"{$tabla.contrato_adhesion}" = "si"');
select wf.f_import_tcolumna_estado ('insert','fecha_inicio','CON','CON','firma_contraparte','exigir','"{$tabla.contrato_adhesion}" = "si"');
select wf.f_import_tcolumna_estado ('insert','tipo_plazo','CON','CON','firma_contraparte','exigir','"{$tabla.contrato_adhesion}" = "si"');
select wf.f_import_tcolumna_estado ('insert','periodicidad_pago','CON','CON','firma_contraparte','exigir','"{$tabla.contrato_adhesion}" = "si"');
select wf.f_import_tcolumna_estado ('insert','tiene_retencion','CON','CON','firma_contraparte','exigir','"{$tabla.contrato_adhesion}" = "si"');
select wf.f_import_tcolumna_estado ('insert','id_lugar','CON','CON','firma_contraparte','exigir','"{$tabla.contrato_adhesion}" = "si"  and  "{$tabla.tipo}" = "administrativo_internacional"');
select wf.f_import_tcolumna_estado ('insert','fecha_fin','CON','CON','firma_contraparte','registrar','"{$tabla.contrato_adhesion}" = "si"');
select wf.f_import_tcolumna_estado ('insert','bancarizacion','CON','CON','finalizado','registrar','');
select wf.f_import_tcolumna_estado ('insert','tipo_plazo','CON','CON','finalizado','registrar','');
select wf.f_import_tcolumna_estado ('insert','monto','CON','CON','finalizado','registrar','');
select wf.f_import_tcolumna_estado ('insert','tipo_monto','CON','CON','finalizado','registrar','');
select wf.f_import_tcolumna_estado ('insert','resolucion_bancarizacion','CON','CON','finalizado','registrar','');
select wf.f_import_tcolumna_estado ('insert','id_funcionario','CON','CON','finalizado','registrar','');
select wf.f_import_tcolumna_estado ('insert','tiene_retencion','CON','CON','finalizado','registrar','');
select wf.f_import_tcolumna_estado ('insert','id_agencia','CON','CON','borrador','registrar','');
select wf.f_import_tcolumna_estado ('insert','tipo_agencia','CON','CON','borrador','registrar','');
select wf.f_import_tcolumna_estado ('insert','formas_pago','CON','CON','borrador','registrar','');
select wf.f_import_testructura_estado ('delete','borrador','pendiente_asignacion','CON',NULL,NULL);
select wf.f_import_testructura_estado ('delete','borrador','registro','CON',NULL,NULL);
select wf.f_import_testructura_estado ('delete','registro','finalizado','CON',NULL,NULL);
select wf.f_import_testructura_estado ('insert','pendiente_asignacion','registro','CON',1,'');
select wf.f_import_testructura_estado ('insert','digitalizacion','finalizado','CON',1,'"{$tabla.contrato_adhesion}"="no"');
select wf.f_import_testructura_estado ('delete','registro','firma_contraparte','CON',NULL,NULL);
select wf.f_import_testructura_estado ('insert','vobo_abogado','vobo_jefe_legal','CON',1,'');
select wf.f_import_testructura_estado ('insert','vobo_jefe_legal','vobo_rpc','CON',1,'"{$tabla.rpc_regional}"="no"');
select wf.f_import_testructura_estado ('delete','vobo_jefe_legal','vobo_gaf','CON',NULL,NULL);
select wf.f_import_testructura_estado ('insert','vobo_rpc','vobo_gaf','CON',1,'');
select wf.f_import_testructura_estado ('insert','vobo_gaf','firma_gerente','CON',1,'');
select wf.f_import_testructura_estado ('delete','firma_gerente','digitalizacion','CON',NULL,NULL);
select wf.f_import_testructura_estado ('delete','registro','contraparte_regional','CON',NULL,NULL);
select wf.f_import_testructura_estado ('insert','contraparte_regional','vobo_abogado','CON',1,'');
select wf.f_import_testructura_estado ('delete','registro','vobo_jefe_legal','CON',NULL,NULL);
select wf.f_import_testructura_estado ('delete','firma_gerente','firma_contraparte','CON',NULL,NULL);
select wf.f_import_testructura_estado ('delete','firma_contraparte','digitalizacion','CON',NULL,NULL);
select wf.f_import_testructura_estado ('delete','firma_contraparte','vobo_jefe_legal','CON',NULL,NULL);
select wf.f_import_testructura_estado ('delete','borrador','finalizado','CON',NULL,NULL);
select wf.f_import_testructura_estado ('delete','borrador','registro','CON',NULL,NULL);
select wf.f_import_testructura_estado ('delete','registro','finalizado','CON',NULL,NULL);
select wf.f_import_testructura_estado ('insert','registro','firma_contraparte','CON',1,'"{$tabla.contrato_adhesion}" = "no"');
select wf.f_import_testructura_estado ('delete','registro','vobo_jefe_legal','CON',NULL,NULL);
select wf.f_import_testructura_estado ('delete','registro','contraparte_regional','CON',NULL,NULL);
select wf.f_import_testructura_estado ('insert','revision','pendiente_asignacion','CON',1,'');
select wf.f_import_testructura_estado ('insert','revision','finalizado','CON',1,'');
select wf.f_import_testructura_estado ('delete','borrador','revision','CON',NULL,NULL);
select wf.f_import_testructura_estado ('delete','firma_contraparte','vobo_jefe_legal','CON',NULL,NULL);
select wf.f_import_testructura_estado ('insert','firma_contraparte','vobo_rpc','CON',1,'"{$tabla.contrato_adhesion}" = "no" and "{$tabla.tipo}" in ("administrativo","administrativo_alquiler")  and "{$tabla.rpc_regional}" = "no"');
select wf.f_import_testructura_estado ('insert','firma_gerente','digitalizacion','CON',1,'"{$tabla.contrato_adhesion}"="no"');
select wf.f_import_testructura_estado ('insert','borrador','vobo_comercial','CON',1,'"{$tabla.tipo}"="comercial"');
select wf.f_import_testructura_estado ('insert','registro','vobo_rpc','CON',1,'"{$tabla.contrato_adhesion}" = "si" and "{$tabla.tipo}"  in( "administrativo", "administrativo_alquiler")');
select wf.f_import_testructura_estado ('insert','firma_gerente','firma_contraparte','CON',1,'"{$tabla.contrato_adhesion}"="si" and "{$tabla.tipo}" != "administrativo_internacional"');
select wf.f_import_testructura_estado ('insert','firma_contraparte','archivo_legal','CON',1,'"{$tabla.contrato_adhesion}" = "si"');
select wf.f_import_testructura_estado ('insert','archivo_legal','finalizado','CON',1,'');
select wf.f_import_testructura_estado ('delete','registro','vobo_gaf','CON',NULL,NULL);
select wf.f_import_testructura_estado ('insert','vobo_comercial','pendiente_asignacion','CON',1,'');
select wf.f_import_testructura_estado ('delete','registro','vobo_gaf','CON',NULL,NULL);
select wf.f_import_testructura_estado ('insert','registro','firma_gerente','CON',1,'"{$tabla.contrato_adhesion}" = "si" and "{$tabla.tipo}"  in( "comercial","administrativo_internacional")');
select wf.f_import_testructura_estado ('insert','firma_contraparte','firma_gerente','CON',1,'"{$tabla.contrato_adhesion}" = "no" and "{$tabla.tipo}" in ("comercial")');
select wf.f_import_testructura_estado ('delete','registro','contraparte_regional','CON',NULL,NULL);
select wf.f_import_testructura_estado ('insert','vobo_jefe_legal','vobo_gaf','CON',1,'"{$tabla.rpc_regional}"="si"');
select wf.f_import_testructura_estado ('insert','firma_contraparte','vobo_gaf','CON',1,'"{$tabla.contrato_adhesion}" = "no" and "{$tabla.tipo}" in ("administrativo","administrativo_alquiler")  and "{$tabla.rpc_regional}" = "si"');
select wf.f_import_testructura_estado ('insert','borrador','pendiente_asignacion','CON',1,'"{$tabla.tipo}"!="comercial" and {$tabla.id_usuario_reg} not in (83,423,146,168,163,1,42,270)');
select wf.f_import_testructura_estado ('insert','borrador','revision','CON',1,'"{$tabla.tipo}"!="comercial" and {$tabla.id_usuario_reg} in (83,423,146,168,163,1,42,270)');
select wf.f_import_testructura_estado ('insert','firma_gerente','digitalizacion','CON',1,'"{$tabla.contrato_adhesion}"="si" and "{$tabla.tipo}" = "administrativo_internacional"');
select wf.f_import_testructura_estado ('insert','digitalizacion','firma_contraparte','CON',1,'"{$tabla.contrato_adhesion}"="si"');
select wf.f_import_testructura_estado ('delete','registro','finalizado','CON',NULL,NULL);
select wf.f_import_testructura_estado ('delete','registro','firma_gerente','CON',NULL,NULL);
select wf.f_import_testructura_estado ('delete','registro','firma_gerente','CON',NULL,NULL);
select wf.f_import_testructura_estado ('delete','registro','finalizado','CON',NULL,NULL);
select wf.f_import_tfuncionario_tipo_estado ('insert','registro','CON','4421368',NULL,'');
select wf.f_import_tfuncionario_tipo_estado ('insert','pendiente_asignacion','CON','965396',NULL,'');
select wf.f_import_tfuncionario_tipo_estado ('insert','registro','CON','2895077',NULL,'');
select wf.f_import_tfuncionario_tipo_estado ('insert','firma_gerente','CON','3723436',NULL,'');
select wf.f_import_tfuncionario_tipo_estado ('insert','contraparte_regional','CON','4777145',NULL,'"{$tabla.lugar}" = "LA PAZ"');
select wf.f_import_tfuncionario_tipo_estado ('insert','contraparte_regional','CON','4567831',NULL,'"{$tabla.lugar}" = "SANTA CRUZ"');
select wf.f_import_tfuncionario_tipo_estado ('insert','digitalizacion','CON','7891536',NULL,'"{$tabla.contrato_adhesion}"="no" or "{$tabla.tipo}" != "administrativo_internacional"');
select wf.f_import_tfuncionario_tipo_estado ('insert','registro','CON','3149212',NULL,'');
select wf.f_import_tfuncionario_tipo_estado ('insert','registro','CON','965396',NULL,'');
select wf.f_import_tfuncionario_tipo_estado ('insert','registro','CON',NULL,NULL,'');
select wf.f_import_tfuncionario_tipo_estado ('insert','registro','CON','7891536',NULL,'');
select wf.f_import_tfuncionario_tipo_estado ('insert','revision','CON',NULL,'LEG','');
select wf.f_import_tfuncionario_tipo_estado ('insert','archivo_legal','CON','7891536',NULL,'"{$tabla.contrato_adhesion}"="no" or "{$tabla.tipo}" != "administrativo_internacional"');
select wf.f_import_tfuncionario_tipo_estado ('insert','firma_contraparte','CON','4777145',NULL,'"{$tabla.lugar}" = "LA PAZ"');
select wf.f_import_tfuncionario_tipo_estado ('insert','firma_contraparte','CON','4567831',NULL,'"{$tabla.lugar}" = "SANTA CRUZ"');
select wf.f_import_tfuncionario_tipo_estado ('insert','vobo_gaf','CON','3728069',NULL,'');
select wf.f_import_tfuncionario_tipo_estado ('insert','firma_contraparte','CON','1067752',NULL,'"{$tabla.lugar}" = "CHUQUISACA"');
select wf.f_import_tfuncionario_tipo_estado ('insert','firma_contraparte','CON','4187733',NULL,'"{$tabla.lugar}" = "BENI"');
select wf.f_import_tfuncionario_tipo_estado ('insert','firma_contraparte','CON','4833416',NULL,'"{$tabla.lugar}" = "PANDO"');
select wf.f_import_tfuncionario_tipo_estado ('insert','firma_contraparte','CON','3999298',NULL,'"{$tabla.lugar}" = "TARIJA"');
select wf.f_import_tfuncionario_tipo_estado ('insert','archivo_legal','CON','3149212',NULL,'"{$tabla.contrato_adhesion}"="si" and "{$tabla.tipo}" = "administrativo_internacional"');
select wf.f_import_tfuncionario_tipo_estado ('insert','firma_contraparte','CON','5732317',NULL,'"{$tabla.lugar}" = "ORURO"');
select wf.f_import_tfuncionario_tipo_estado ('insert','vobo_rpc','CON','4280479',NULL,'');
select wf.f_import_tfuncionario_tipo_estado ('insert','vobo_comercial','CON','3000748',NULL,'');
select wf.f_import_tfuncionario_tipo_estado ('insert','registro','CON','3512117',NULL,'');
select wf.f_import_tfuncionario_tipo_estado ('insert','digitalizacion','CON','3149212',NULL,'');
select wf.f_import_tplantilla_correo ('insert','prueba','revision','CON','','prueba','jaime.rivera@boa.bo','prueba');
/***********************************F-DAT-FEA-LEG-0-27/11/2018*****************************************/