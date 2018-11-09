/***********************************I-DEP-RCM-LEG-1-17/01/2015*****************************************/
CREATE VIEW leg.vcontrato (
    id_usuario_reg,
    id_usuario_mod,
    fecha_reg,
    fecha_mod,
    estado_reg,
    id_usuario_ai,
    usuario_ai,
    id_contrato,
    id_estado_wf,
    id_proceso_wf,
    estado,
    tipo,
    objeto,
    fecha_inicio,
    fecha_fin,
    numero,
    id_gestion,
    id_persona,
    id_institucion,
    id_proveedor,
    observaciones,
    solicitud,
    monto,
    id_moneda,
    fecha_elaboracion,
    plazo,
    tipo_plazo,
    id_cotizacion,
    sujeto_contrato,
    moneda)
AS
SELECT con.id_usuario_reg,
    con.id_usuario_mod,
    con.fecha_reg,
    con.fecha_mod,
    con.estado_reg,
    con.id_usuario_ai,
    con.usuario_ai,
    con.id_contrato,
    con.id_estado_wf,
    con.id_proceso_wf,
    con.estado,
    con.tipo,
    con.objeto,
    con.fecha_inicio,
    con.fecha_fin,
    con.numero,
    con.id_gestion,
    con.id_persona,
    con.id_institucion,
    con.id_proveedor,
    con.observaciones,
    con.solicitud,
    con.monto,
    con.id_moneda,
    con.fecha_elaboracion,
    con.plazo,
    con.tipo_plazo,
    con.id_cotizacion,
        CASE
            WHEN con.id_persona IS NOT NULL THEN per.nombre_completo1
            WHEN con.id_institucion IS NOT NULL THEN ins.nombre::text
            WHEN con.id_proveedor IS NOT NULL THEN pro.desc_proveedor::text
            ELSE 'S/N'::text
        END AS sujeto_contrato,
    mon.moneda
FROM leg.tcontrato con
     JOIN param.tmoneda mon ON mon.id_moneda = con.id_moneda
     LEFT JOIN segu.vpersona per ON per.id_persona = con.id_persona
     LEFT JOIN param.tinstitucion ins ON ins.id_institucion = con.id_institucion
     LEFT JOIN param.vproveedor pro ON pro.id_proveedor = con.id_proveedor;
/***********************************F-DEP-RCM-LEG-1-17/01/2015*****************************************/

/***********************************I-DEP-JRR-LEG-1-25/02/2015*****************************************/
CREATE OR REPLACE VIEW leg.vcontrato (
    id_usuario_reg,
    id_usuario_mod,
    fecha_reg,
    fecha_mod,
    estado_reg,
    id_usuario_ai,
    usuario_ai,
    id_contrato,
    id_estado_wf,
    id_proceso_wf,
    estado,
    tipo,
    objeto,
    fecha_inicio,
    fecha_fin,
    numero,
    id_gestion,
    id_persona,
    id_institucion,
    id_proveedor,
    observaciones,
    solicitud,
    monto,
    id_moneda,
    fecha_elaboracion,
    plazo,
    tipo_plazo,
    id_cotizacion,
    sujeto_contrato,
    moneda,
    fk_id_contrato)
AS
SELECT con.id_usuario_reg,
    con.id_usuario_mod,
    con.fecha_reg,
    con.fecha_mod,
    con.estado_reg,
    con.id_usuario_ai,
    con.usuario_ai,
    con.id_contrato,
    con.id_estado_wf,
    con.id_proceso_wf,
    con.estado,
    con.tipo,
    con.objeto,
    con.fecha_inicio,
    con.fecha_fin,
    con.numero,
    con.id_gestion,
    con.id_persona,
    con.id_institucion,
    con.id_proveedor,
    con.observaciones,
    con.solicitud,
    con.monto,
    con.id_moneda,
    con.fecha_elaboracion,
    con.plazo,
    con.tipo_plazo,
    con.id_cotizacion,
        CASE
            WHEN con.id_persona IS NOT NULL THEN per.nombre_completo1
            WHEN con.id_institucion IS NOT NULL THEN ins.nombre::text
            WHEN con.id_proveedor IS NOT NULL THEN pro.desc_proveedor::text
            ELSE 'S/N'::text
        END AS sujeto_contrato,
    mon.moneda,
    con.fk_id_contrato
FROM leg.tcontrato con
     JOIN param.tmoneda mon ON mon.id_moneda = con.id_moneda
     LEFT JOIN segu.vpersona per ON per.id_persona = con.id_persona
     LEFT JOIN param.tinstitucion ins ON ins.id_institucion = con.id_institucion
     LEFT JOIN param.vproveedor pro ON pro.id_proveedor = con.id_proveedor;
/***********************************F-DEP-JRR-LEG-1-25/02/2015*****************************************/

/***********************************I-DEP-JRR-LEG-1-26/02/2015*****************************************/
CREATE OR REPLACE VIEW leg.vcontrato(
    id_usuario_reg,
    id_usuario_mod,
    fecha_reg,
    fecha_mod,
    estado_reg,
    id_usuario_ai,
    usuario_ai,
    id_contrato,
    id_estado_wf,
    id_proceso_wf,
    estado,
    tipo,
    objeto,
    fecha_inicio,
    fecha_fin,
    numero,
    id_gestion,
    id_persona,
    id_institucion,
    id_proveedor,
    observaciones,
    solicitud,
    monto,
    id_moneda,
    fecha_elaboracion,
    plazo,
    tipo_plazo,
    id_cotizacion,
    sujeto_contrato,
    moneda,
    fk_id_contrato,
    desc_ingas,
    desc_ot,
    desc_contrato_fk)
AS
  SELECT con.id_usuario_reg,
         con.id_usuario_mod,
         con.fecha_reg,
         con.fecha_mod,
         con.estado_reg,
         con.id_usuario_ai,
         con.usuario_ai,
         con.id_contrato,
         con.id_estado_wf,
         con.id_proceso_wf,
         con.estado,
         con.tipo,
         con.objeto,
         con.fecha_inicio,
         con.fecha_fin,
         con.numero,
         con.id_gestion,
         con.id_persona,
         con.id_institucion,
         con.id_proveedor,
         con.observaciones,
         con.solicitud,
         con.monto,
         con.id_moneda,
         con.fecha_elaboracion,
         con.plazo,
         con.tipo_plazo,
         con.id_cotizacion,
         CASE
           WHEN con.id_persona IS NOT NULL THEN per.nombre_completo1
           WHEN con.id_institucion IS NOT NULL THEN ins.nombre::text
           WHEN con.id_proveedor IS NOT NULL THEN pro.desc_proveedor::text
           ELSE 'S/N' ::text
         END AS sujeto_contrato,
         mon.moneda,
         con.fk_id_contrato,
         (
           SELECT pxp.list(ci.desc_ingas::text) AS list
           FROM param.tconcepto_ingas ci
           WHERE ci.id_concepto_ingas = ANY (con.id_concepto_ingas)
         ) AS desc_ingas,
         (
           SELECT pxp.list(ot.desc_orden::text) AS list
           FROM conta.torden_trabajo ot
           WHERE ot.id_orden_trabajo = ANY (con.id_orden_trabajo)
         ) AS desc_ot,
         CASE
           WHEN fkcon.id_persona IS NOT NULL THEN (fkper.nombre_completo1 ||
            ' - ' ::text) || fkcon.numero::text
           WHEN fkcon.id_institucion IS NOT NULL THEN (fkins.nombre::text ||
            ' - ' ::text) || fkcon.numero::text
           WHEN fkcon.id_proveedor IS NOT NULL THEN (fkpro.desc_proveedor::text
            || ' - ' ::text) || fkcon.numero::text
           ELSE 'S/N - ' ::text || fkcon.numero::text
         END AS desc_contrato_fk
  FROM leg.tcontrato con
       JOIN param.tmoneda mon ON mon.id_moneda = con.id_moneda
       LEFT JOIN segu.vpersona per ON per.id_persona = con.id_persona
       LEFT JOIN param.tinstitucion ins ON ins.id_institucion =
        con.id_institucion
       LEFT JOIN param.vproveedor pro ON pro.id_proveedor = con.id_proveedor
       LEFT JOIN leg.tcontrato fkcon ON fkcon.id_contrato = con.id_contrato_fk
       LEFT JOIN segu.vpersona fkper ON fkper.id_persona = fkcon.id_persona
       LEFT JOIN param.tinstitucion fkins ON fkins.id_institucion =
        fkcon.id_institucion
       LEFT JOIN param.vproveedor fkpro ON fkpro.id_proveedor =
        fkcon.id_proveedor;
       
/***********************************F-DEP-JRR-LEG-1-26/02/2015*****************************************/


/***********************************I-DEP-RCM-LEG-1-28/02/2015*****************************************/
CREATE OR REPLACE VIEW leg.vcontrato (
    id_usuario_reg,
    id_usuario_mod,
    fecha_reg,
    fecha_mod,
    estado_reg,
    id_usuario_ai,
    usuario_ai,
    id_contrato,
    id_estado_wf,
    id_proceso_wf,
    estado,
    tipo,
    objeto,
    fecha_inicio,
    fecha_fin,
    numero,
    id_gestion,
    id_persona,
    id_institucion,
    id_proveedor,
    observaciones,
    solicitud,
    monto,
    id_moneda,
    fecha_elaboracion,
    plazo,
    tipo_plazo,
    id_cotizacion,
    sujeto_contrato,
    moneda,
    fk_id_contrato,
    desc_ingas,
    desc_ot,
    desc_contrato_fk,
    contrato_adhesion,
    id_lugar,
    lugar)
AS
SELECT con.id_usuario_reg,
    con.id_usuario_mod,
    con.fecha_reg,
    con.fecha_mod,
    con.estado_reg,
    con.id_usuario_ai,
    con.usuario_ai,
    con.id_contrato,
    con.id_estado_wf,
    con.id_proceso_wf,
    con.estado,
    con.tipo,
    con.objeto,
    con.fecha_inicio,
    con.fecha_fin,
    con.numero,
    con.id_gestion,
    con.id_persona,
    con.id_institucion,
    con.id_proveedor,
    con.observaciones,
    con.solicitud,
    con.monto,
    con.id_moneda,
    con.fecha_elaboracion,
    con.plazo,
    con.tipo_plazo,
    con.id_cotizacion,
        CASE
            WHEN con.id_persona IS NOT NULL THEN per.nombre_completo1
            WHEN con.id_institucion IS NOT NULL THEN ins.nombre::text
            WHEN con.id_proveedor IS NOT NULL THEN pro.desc_proveedor::text
            ELSE 'S/N'::text
        END AS sujeto_contrato,
    mon.moneda,
    con.fk_id_contrato,
    (
    SELECT pxp.list(ci.desc_ingas::text) AS list
    FROM param.tconcepto_ingas ci
    WHERE ci.id_concepto_ingas = ANY (con.id_concepto_ingas)
    ) AS desc_ingas,
    (
    SELECT pxp.list(ot.desc_orden::text) AS list
    FROM conta.torden_trabajo ot
    WHERE ot.id_orden_trabajo = ANY (con.id_orden_trabajo)
    ) AS desc_ot,
        CASE
            WHEN fkcon.id_persona IS NOT NULL THEN (fkper.nombre_completo1 ||
                ' - '::text) || fkcon.numero::text
            WHEN fkcon.id_institucion IS NOT NULL THEN (fkins.nombre::text ||
                ' - '::text) || fkcon.numero::text
            WHEN fkcon.id_proveedor IS NOT NULL THEN
                (fkpro.desc_proveedor::text || ' - '::text) || fkcon.numero::text
            ELSE 'S/N - '::text || fkcon.numero::text
        END AS desc_contrato_fk,
    con.contrato_adhesion,
    con.id_lugar,
    lug.nombre AS lugar
FROM leg.tcontrato con
   JOIN param.tmoneda mon ON mon.id_moneda = con.id_moneda
   LEFT JOIN segu.vpersona per ON per.id_persona = con.id_persona
   LEFT JOIN param.tinstitucion ins ON ins.id_institucion = con.id_institucion
   LEFT JOIN param.vproveedor pro ON pro.id_proveedor = con.id_proveedor
   LEFT JOIN leg.tcontrato fkcon ON fkcon.id_contrato = con.id_contrato_fk
   LEFT JOIN segu.vpersona fkper ON fkper.id_persona = fkcon.id_persona
   LEFT JOIN param.tinstitucion fkins ON fkins.id_institucion = fkcon.id_institucion
   LEFT JOIN param.vproveedor fkpro ON fkpro.id_proveedor = fkcon.id_proveedor
   LEFT JOIN param.tlugar lug ON lug.id_lugar = con.id_lugar;
/***********************************F-DEP-RCM-LEG-1-28/02/2015*****************************************/

/***********************************I-DEP-RCM-LEG-1-03/03/2015*****************************************/
CREATE TRIGGER tcontrato_tr BEFORE UPDATE 
ON leg.tcontrato FOR EACH ROW 
EXECUTE PROCEDURE leg.f_tr_contrato();
/***********************************F-DEP-RCM-LEG-1-03/03/2015*****************************************/

/***********************************I-DEP-RCM-LEG-1-06/03/2015*****************************************/
CREATE OR REPLACE VIEW leg.vcontrato (
    id_usuario_reg,
    id_usuario_mod,
    fecha_reg,
    fecha_mod,
    estado_reg,
    id_usuario_ai,
    usuario_ai,
    id_contrato,
    id_estado_wf,
    id_proceso_wf,
    estado,
    tipo,
    objeto,
    fecha_inicio,
    fecha_fin,
    numero,
    id_gestion,
    id_persona,
    id_institucion,
    id_proveedor,
    observaciones,
    solicitud,
    monto,
    id_moneda,
    fecha_elaboracion,
    plazo,
    tipo_plazo,
    id_cotizacion,
    sujeto_contrato,
    moneda,
    fk_id_contrato,
    desc_ingas,
    desc_ot,
    desc_contrato_fk,
    contrato_adhesion,
    id_lugar,
    lugar)
AS
SELECT con.id_usuario_reg,
    con.id_usuario_mod,
    con.fecha_reg,
    con.fecha_mod,
    con.estado_reg,
    con.id_usuario_ai,
    con.usuario_ai,
    con.id_contrato,
    con.id_estado_wf,
    con.id_proceso_wf,
    con.estado,
    con.tipo,
    con.objeto,
    con.fecha_inicio,
    con.fecha_fin,
    con.numero,
    con.id_gestion,
    con.id_persona,
    con.id_institucion,
    con.id_proveedor,
    con.observaciones,
    con.solicitud,
    con.monto,
    con.id_moneda,
    con.fecha_elaboracion,
    con.plazo,
    con.tipo_plazo,
    con.id_cotizacion,
        CASE
            WHEN con.id_persona IS NOT NULL THEN per.nombre_completo1
            WHEN con.id_institucion IS NOT NULL THEN ins.nombre::text
            WHEN con.id_proveedor IS NOT NULL THEN pro.desc_proveedor::text
            ELSE 'S/N'::text
        END AS sujeto_contrato,
    mon.moneda,
    con.fk_id_contrato,
    (
    SELECT pxp.list(ci.desc_ingas::text) AS list
    FROM param.tconcepto_ingas ci
    WHERE ci.id_concepto_ingas = ANY (con.id_concepto_ingas)
    ) AS desc_ingas,
    (
    SELECT pxp.list(ot.desc_orden::text) AS list
    FROM conta.torden_trabajo ot
    WHERE ot.id_orden_trabajo = ANY (con.id_orden_trabajo)
    ) AS desc_ot,
        CASE
            WHEN fkcon.id_persona IS NOT NULL THEN (fkper.nombre_completo1 ||
                ' - '::text) || fkcon.numero::text
            WHEN fkcon.id_institucion IS NOT NULL THEN (fkins.nombre::text ||
                ' - '::text) || fkcon.numero::text
            WHEN fkcon.id_proveedor IS NOT NULL THEN
                (fkpro.desc_proveedor::text || ' - '::text) || fkcon.numero::text
            ELSE 'S/N - '::text || fkcon.numero::text
        END AS desc_contrato_fk,
    con.contrato_adhesion,
    con.id_lugar,
    lug.nombre AS lugar
FROM leg.tcontrato con
   JOIN param.tmoneda mon ON mon.id_moneda = con.id_moneda
   LEFT JOIN segu.vpersona per ON per.id_persona = con.id_persona
   LEFT JOIN param.tinstitucion ins ON ins.id_institucion = con.id_institucion
   LEFT JOIN param.vproveedor pro ON pro.id_proveedor = con.id_proveedor
   LEFT JOIN leg.tcontrato fkcon ON fkcon.id_contrato = con.id_contrato_fk
   LEFT JOIN segu.vpersona fkper ON fkper.id_persona = fkcon.id_persona
   LEFT JOIN param.tinstitucion fkins ON fkins.id_institucion = fkcon.id_institucion
   LEFT JOIN param.vproveedor fkpro ON fkpro.id_proveedor = fkcon.id_proveedor
   LEFT JOIN param.tlugar lug ON lug.id_lugar = con.id_lugar;
/***********************************F-DEP-RCM-LEG-1-06/03/2015*****************************************/


/***********************************I-DEP-JRR-LEG-1-29/05/2015*****************************************/
CREATE OR REPLACE VIEW leg.vcontrato(
    id_usuario_reg,
    id_usuario_mod,
    fecha_reg,
    fecha_mod,
    estado_reg,
    id_usuario_ai,
    usuario_ai,
    id_contrato,
    id_estado_wf,
    id_proceso_wf,
    estado,
    tipo,
    objeto,
    fecha_inicio,
    fecha_fin,
    numero,
    id_gestion,
    id_persona,
    id_institucion,
    id_proveedor,
    observaciones,
    solicitud,
    monto,
    id_moneda,
    fecha_elaboracion,
    plazo,
    tipo_plazo,
    id_cotizacion,
    sujeto_contrato,
    moneda,
    fk_id_contrato,
    desc_ingas,
    desc_ot,
    desc_contrato_fk,
    contrato_adhesion,
    id_lugar,
    lugar,
    id_funcionario,
    solicitante,
    id_abogado,
    desc_abogado)
AS
  SELECT con.id_usuario_reg,
         con.id_usuario_mod,
         con.fecha_reg,
         con.fecha_mod,
         con.estado_reg,
         con.id_usuario_ai,
         con.usuario_ai,
         con.id_contrato,
         con.id_estado_wf,
         con.id_proceso_wf,
         con.estado,
         con.tipo,
         con.objeto,
         con.fecha_inicio,
         con.fecha_fin,
         con.numero,
         con.id_gestion,
         con.id_persona,
         con.id_institucion,
         con.id_proveedor,
         con.observaciones,
         con.solicitud,
         con.monto,
         con.id_moneda,
         con.fecha_elaboracion,
         con.plazo,
         con.tipo_plazo,
         con.id_cotizacion,
         CASE
           WHEN con.id_persona IS NOT NULL THEN per.nombre_completo1
           WHEN con.id_institucion IS NOT NULL THEN ins.nombre::text
           WHEN con.id_proveedor IS NOT NULL THEN pro.desc_proveedor::text
           ELSE 'S/N' ::text
         END AS sujeto_contrato,
         mon.moneda,
         con.fk_id_contrato,
         (
           SELECT pxp.list(ci.desc_ingas::text) AS list
           FROM param.tconcepto_ingas ci
           WHERE ci.id_concepto_ingas = ANY (con.id_concepto_ingas)
         ) AS desc_ingas,
         (
           SELECT pxp.list(ot.desc_orden::text) AS list
           FROM conta.torden_trabajo ot
           WHERE ot.id_orden_trabajo = ANY (con.id_orden_trabajo)
         ) AS desc_ot,
         CASE
           WHEN fkcon.id_persona IS NOT NULL THEN (fkper.nombre_completo1 ||
             ' - ' ::text) || fkcon.numero::text
           WHEN fkcon.id_institucion IS NOT NULL THEN (fkins.nombre::text ||
             ' - ' ::text) || fkcon.numero::text
           WHEN fkcon.id_proveedor IS NOT NULL THEN (fkpro.desc_proveedor::text
             || ' - ' ::text) || fkcon.numero::text
           ELSE 'S/N - ' ::text || fkcon.numero::text
         END AS desc_contrato_fk,
         con.contrato_adhesion,
         con.id_lugar,
         lug.nombre AS lugar,
         con.id_funcionario,
         fun.desc_funcionario1 AS solicitante,
         con.id_abogado,
         abo.desc_funcionario1 AS desc_abogado
  FROM leg.tcontrato con
       JOIN param.tmoneda mon ON mon.id_moneda = con.id_moneda
       LEFT JOIN segu.vpersona per ON per.id_persona = con.id_persona
       LEFT JOIN param.tinstitucion ins ON ins.id_institucion =
         con.id_institucion
       LEFT JOIN param.vproveedor pro ON pro.id_proveedor = con.id_proveedor
       LEFT JOIN leg.tcontrato fkcon ON fkcon.id_contrato = con.id_contrato_fk
       LEFT JOIN segu.vpersona fkper ON fkper.id_persona = fkcon.id_persona
       LEFT JOIN param.tinstitucion fkins ON fkins.id_institucion =
         fkcon.id_institucion
       LEFT JOIN param.vproveedor fkpro ON fkpro.id_proveedor =
         fkcon.id_proveedor
       LEFT JOIN param.tlugar lug ON lug.id_lugar = con.id_lugar
       LEFT JOIN orga.vfuncionario fun ON fun.id_funcionario =
         con.id_funcionario
       LEFT JOIN orga.vfuncionario abo ON abo.id_funcionario = con.id_abogado;
   

/***********************************F-DEP-JRR-LEG-1-29/05/2015*****************************************/

/***********************************I-DEP-BVP-LEG-1-16/05/2018*****************************************/
CREATE OR REPLACE VIEW leg.vpoliza_boletas (
    id_anexo,
    estado_reg,
    banco,
    nro_documento,
    tipo,
    codigo,
    codigo_int,
    codigo_noiata,
    agencia,
    numero,
    tipo_agencia,
    fecha_fin_uso,
    fecha_desde,
    fecha_notif,
    fecha_corte,
    fecha_hasta,
    moneda,
    asegurado,
    estado,
    usr_reg,
    usr_mod,
    id_usuario_reg,
    id_usuario_mod)
AS
 SELECT anex.id_anexo,
    anex.estado_reg,
    anex.banco,
    anex.nro_documento,
    anex.tipo,
    lu.codigo,
    agen.codigo_int,
    agen.codigo AS codigo_noiata,
    COALESCE(agen.nombre, prov.desc_proveedor) AS agencia,
    con.numero,
    agen.tipo_agencia,
    anex.fecha_fin_uso,
    anex.fecha_desde,
    anex.fecha_hasta - 30 AS fecha_notif,
    anex.fecha_hasta - 21 AS fecha_corte,
    anex.fecha_hasta,
    anex.moneda,
    anex.monto AS asegurado,
    anex.estado,
    usu1.cuenta AS usr_reg,
    usu2.cuenta AS usr_mod,
    anex.id_usuario_reg,
    anex.id_usuario_mod
   FROM leg.tcontrato con
     JOIN leg.tanexo anex ON anex.id_contrato = con.id_contrato
     JOIN segu.tusuario usu1 ON usu1.id_usuario = anex.id_usuario_reg
     LEFT JOIN param.vproveedor prov ON prov.id_proveedor = con.id_proveedor
     LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = anex.id_usuario_mod
     LEFT JOIN obingresos.tagencia agen ON agen.id_agencia = con.id_agencia
     LEFT JOIN param.tlugar lu ON lu.id_lugar = agen.id_lugar;
     
/***********************************F-DEP-BVP-LEG-1-16/05/2018*****************************************/  
/***********************************I-DEP-BVP-LEG-1-16/05/2018*****************************************/
CREATE OR REPLACE VIEW leg.vpoliza_boletas_otras (
    id_anexo,
    banco,
    nro_documento,
    tipo,
    proveedor,
    numero,
    fecha_fin_uso,
    fecha_desde,
    fecha_notif,
    fecha_corte,
    fecha_hasta,
    moneda,
    asegurado,
    estado,
    usr_reg,
    usr_mod,
    id_usuario_reg,
    id_usuario_mod)
AS
 SELECT anex.id_anexo,
    anex.banco,
    anex.nro_documento,
    anex.tipo,
    prov.desc_proveedor AS proveedor,
    con.numero,
    anex.fecha_fin_uso,
    anex.fecha_desde,
    anex.fecha_hasta - 30 AS fecha_notif,
    anex.fecha_hasta - 21 AS fecha_corte,
    anex.fecha_hasta,
    anex.moneda,
    anex.monto AS asegurado,
    anex.estado,
    usu1.cuenta AS usr_reg,
    usu2.cuenta AS usr_mod,
    anex.id_usuario_reg,
    anex.id_usuario_mod
   FROM leg.tcontrato con
     JOIN leg.tanexo anex ON anex.id_contrato = con.id_contrato
     JOIN segu.tusuario usu1 ON usu1.id_usuario = anex.id_usuario_reg
     JOIN param.vproveedor prov ON prov.id_proveedor = con.id_proveedor
     LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = anex.id_usuario_mod
  WHERE con.tipo_agencia::text <> 'noiata'::text;
/***********************************F-DEP-BVP-LEG-1-16/05/2018*****************************************/


/***********************************I-DEP-FEA-LEG-1-07/11/2018*****************************************/
select pxp.f_insert_testructura_gui ('LEG', 'SISTEMA');
select pxp.f_insert_testructura_gui ('WF.CON', 'LEG');
select pxp.f_insert_testructura_gui ('WF.CON_finalizado', 'WF.CON');
select pxp.f_insert_testructura_gui ('WF.CON_contraparte_regional', 'WF.CON');
select pxp.f_insert_testructura_gui ('WF.CON_vobo_rpc', 'WF.CON');
select pxp.f_insert_testructura_gui ('WF.CON_anulado', 'WF.CON');
select pxp.f_insert_testructura_gui ('WF.CON_digitalizacion', 'WF.CON');
select pxp.f_insert_testructura_gui ('WF.CON_archivo_legal', 'WF.CON');
select pxp.f_insert_testructura_gui ('WF.CON_vobo_jefe_legal', 'WF.CON');
select pxp.f_insert_testructura_gui ('WF.CON_firma_gerente', 'WF.CON');
select pxp.f_insert_testructura_gui ('WF.CON_registro', 'WF.CON');
select pxp.f_insert_testructura_gui ('WF.CON_borrador', 'WF.CON');
select pxp.f_insert_testructura_gui ('WF.CON_vobo_comercial', 'WF.CON');
select pxp.f_insert_testructura_gui ('WF.CON_revision', 'WF.CON');
select pxp.f_insert_testructura_gui ('WF.CON_vobo_abogado', 'WF.CON');
select pxp.f_insert_testructura_gui ('WF.CON_pendiente_asignacion', 'WF.CON');
select pxp.f_insert_testructura_gui ('WF.CON_firma_contraparte', 'WF.CON');
select pxp.f_insert_testructura_gui ('WF.CON_vobo_gaf', 'WF.CON');
select pxp.f_insert_tgui_rol ('LUG', 'LEG-Abogado');
select pxp.f_insert_tgui_rol ('PARAM', 'LEG-Abogado');
select pxp.f_insert_tgui_rol ('SISTEMA', 'LEG-Abogado');
select pxp.f_insert_tgui_rol ('GESTIO', 'LEG-Solicitante');
select pxp.f_insert_tgui_rol ('PARAM', 'LEG-Solicitante');
select pxp.f_insert_tgui_rol ('SISTEMA', 'LEG-Solicitante');
select pxp.f_insert_tgui_rol ('ADQ.4', 'LEG-Solicitante');
select pxp.f_insert_tgui_rol ('ADQ', 'LEG-Solicitante');
select pxp.f_insert_tgui_rol ('MONPAR', 'LEG-Solicitante');
select pxp.f_insert_tgui_rol ('CONIG', 'LEG-Solicitante');
select pxp.f_insert_tgui_rol ('CCOM', 'LEG-Solicitante');
select pxp.f_insert_tgui_rol ('ODT', 'LEG-Solicitante');
select pxp.f_insert_tgui_rol ('CROT', 'LEG-Solicitante');
select pxp.f_insert_tgui_rol ('CONTA', 'LEG-Solicitante');
select pxp.f_insert_tgui_rol ('OFICI', 'LEG-Abogado');
select pxp.f_insert_tgui_rol ('PARAMRH', 'LEG-Abogado');
select pxp.f_insert_tgui_rol ('ORGA', 'LEG-Abogado');
select pxp.f_insert_tgui_rol ('PROVEE', 'LEG-Solicitante');
select pxp.f_insert_tgui_rol ('FUNCIO', 'LEG-Solicitante');
select pxp.f_insert_tgui_rol ('PROCRH', 'LEG-Solicitante');
select pxp.f_insert_tgui_rol ('ORGA', 'LEG-Solicitante');
select pxp.f_insert_tgui_rol ('WF.CON_finalizado', 'LEG- Contrato Finalizado');
select pxp.f_insert_tgui_rol ('WF.CON', 'LEG- Contrato Finalizado');
select pxp.f_insert_tgui_rol ('LEG', 'LEG- Contrato Finalizado');
select pxp.f_insert_tgui_rol ('SISTEMA', 'LEG- Contrato Finalizado');
select pxp.f_insert_tgui_rol ('WF.CON_finalizado', 'LEG-Abogado');
select pxp.f_insert_tgui_rol ('WF.CON', 'LEG-Abogado');
select pxp.f_insert_tgui_rol ('LEG', 'LEG-Abogado');
select pxp.f_insert_tgui_rol ('WF.CON_vobo_rpc', 'LEG-Firma RPC');
select pxp.f_insert_tgui_rol ('WF.CON', 'LEG-Firma RPC');
select pxp.f_insert_tgui_rol ('LEG', 'LEG-Firma RPC');
select pxp.f_insert_tgui_rol ('SISTEMA', 'LEG-Firma RPC');
select pxp.f_insert_tgui_rol ('WF.CON_digitalizacion', 'LEG-Digitalizacion');
select pxp.f_insert_tgui_rol ('WF.CON', 'LEG-Digitalizacion');
select pxp.f_insert_tgui_rol ('LEG', 'LEG-Digitalizacion');
select pxp.f_insert_tgui_rol ('SISTEMA', 'LEG-Digitalizacion');
select pxp.f_insert_tgui_rol ('WF.CON_archivo_legal', 'LEG-Digitalizacion');
select pxp.f_insert_tgui_rol ('WF.CON_vobo_jefe_legal', 'LEG-Abogado');
select pxp.f_insert_tgui_rol ('WF.CON_vobo_jefe_legal', 'LEG - Jefe Legal');
select pxp.f_insert_tgui_rol ('WF.CON', 'LEG - Jefe Legal');
select pxp.f_insert_tgui_rol ('LEG', 'LEG - Jefe Legal');
select pxp.f_insert_tgui_rol ('SISTEMA', 'LEG - Jefe Legal');
select pxp.f_insert_tgui_rol ('WF.CON_firma_gerente', 'LEG-Gerencia');
select pxp.f_insert_tgui_rol ('WF.CON', 'LEG-Gerencia');
select pxp.f_insert_tgui_rol ('LEG', 'LEG-Gerencia');
select pxp.f_insert_tgui_rol ('SISTEMA', 'LEG-Gerencia');
select pxp.f_insert_tgui_rol ('WF.CON_registro', 'LEG-Abogado');
select pxp.f_insert_tgui_rol ('WF.CON_borrador', 'LEG-Solicitante');
select pxp.f_insert_tgui_rol ('WF.CON', 'LEG-Solicitante');
select pxp.f_insert_tgui_rol ('LEG', 'LEG-Solicitante');
select pxp.f_insert_tgui_rol ('WF.CON_vobo_comercial', 'LEG-Firma comercial');
select pxp.f_insert_tgui_rol ('WF.CON', 'LEG-Firma comercial');
select pxp.f_insert_tgui_rol ('LEG', 'LEG-Firma comercial');
select pxp.f_insert_tgui_rol ('SISTEMA', 'LEG-Firma comercial');
select pxp.f_insert_tgui_rol ('WF.CON_revision', 'LEG-Revision');
select pxp.f_insert_tgui_rol ('WF.CON', 'LEG-Revision');
select pxp.f_insert_tgui_rol ('LEG', 'LEG-Revision');
select pxp.f_insert_tgui_rol ('SISTEMA', 'LEG-Revision');
select pxp.f_insert_tgui_rol ('WF.CON_vobo_abogado', 'LEG-Abogado');
select pxp.f_insert_tgui_rol ('WF.CON_pendiente_asignacion', 'LEG - Jefe Legal');
select pxp.f_insert_tgui_rol ('WF.CON_firma_contraparte', 'LEG-Firma Contraparte');
select pxp.f_insert_tgui_rol ('WF.CON', 'LEG-Firma Contraparte');
select pxp.f_insert_tgui_rol ('LEG', 'LEG-Firma Contraparte');
select pxp.f_insert_tgui_rol ('SISTEMA', 'LEG-Firma Contraparte');
select pxp.f_insert_tgui_rol ('WF.CON_firma_contraparte', 'LEG-Abogado');
select pxp.f_insert_tgui_rol ('WF.CON_firma_contraparte', 'LEG-Solicitante');
select pxp.f_insert_tgui_rol ('WF.CON_vobo_gaf', 'LEG-Firma GAF');
select pxp.f_insert_tgui_rol ('WF.CON', 'LEG-Firma GAF');
select pxp.f_insert_tgui_rol ('LEG', 'LEG-Firma GAF');
select pxp.f_insert_tgui_rol ('SISTEMA', 'LEG-Firma GAF');
select pxp.f_insert_tgui_rol ('WF.1.2.4', 'LEG- Contrato Finalizado');
select pxp.f_insert_tgui_rol ('WF.1.2', 'LEG- Contrato Finalizado');
select pxp.f_insert_tgui_rol ('WF', 'LEG- Contrato Finalizado');
select pxp.f_insert_tgui_rol ('WF.CON_finalizado', 'LEG - Jefe Legal');
select pxp.f_delete_tgui_rol ('WF.CON_digitalizacion', 'LEG-Revision');
/***********************************F-DEP-FEA-LEG-1-07/11/2018*****************************************/