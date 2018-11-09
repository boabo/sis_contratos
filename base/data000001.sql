/***********************************I-DAT-FEA-LEG-0-07/11/2018*****************************************/

select pxp.f_insert_tgui ('<i class="fa fa-file fa-2x"></i> CONTRATOS', '', 'LEG', 'si', 12, '', 1, '', '', 'LEG');
select pxp.f_insert_tfuncion ('leg.f_lista_firma_contraparte_wf_sel', 'Funcion para tabla     ', 'LEG');
select pxp.f_insert_tfuncion ('leg.f_lista_abogado_asignado_wf_sel', 'Funcion para tabla     ', 'LEG');
select pxp.f_insert_tfuncion ('leg.f_tr_contrato', 'Funcion para tabla     ', 'LEG');
select pxp.f_insert_tfuncion ('leg.ft_contrato_sel', 'Funcion para tabla     ', 'LEG');
select pxp.f_insert_tfuncion ('leg.f_tr_contrato_fecha', 'Funcion para tabla     ', 'LEG');
select pxp.f_insert_tfuncion ('leg.ft_poliza_boleta_sel', 'Funcion para tabla     ', 'LEG');
select pxp.f_insert_tprocedimiento ('LEG_CONTRA_SEL', 'Consulta de la vista de contratos', 'si', '', '', 'leg.ft_contrato_sel');
select pxp.f_insert_tprocedimiento ('LEG_CONTRA_CONT', 'Conteo de registros', 'si', '', '', 'leg.ft_contrato_sel');
select pxp.f_insert_tprocedimiento ('LG_POBOA_SEL', 'Consulta de datos', 'si', '', '', 'leg.ft_poliza_boleta_sel');
select pxp.f_insert_tprocedimiento ('LG_POBOA_CONT', 'Conteo de registros', 'si', '', '', 'leg.ft_poliza_boleta_sel');
select pxp.f_insert_tprocedimiento ('LG_POBOO_SEL', 'Consulta de datos', 'si', '', '', 'leg.ft_poliza_boleta_sel');
select pxp.f_insert_tprocedimiento ('LG_POBOO_CONT', 'Conteo de registros', 'si', '', '', 'leg.ft_poliza_boleta_sel');
select pxp.f_delete_trol ('CONTFIN');
select pxp.f_insert_trol ('', 'LEG- Contrato Finalizado', 'LEG');
select pxp.f_insert_trol ('', 'LEG-Revision', 'LEG');
select pxp.f_insert_trol ('', 'LEG-Firma comercial', 'LEG');


/***********************************F-DAT-FEA-LEG-0-07/11/2018*****************************************/