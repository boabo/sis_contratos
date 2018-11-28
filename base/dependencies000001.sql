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
/***********************************F-DEP-FEA-LEG-1-07/11/2018*****************************************/

/***********************************I-DEP-FEA-LEG-1-27/11/2018*****************************************/
select wf.f_import_ttipo_documento_estado ('insert','CONTRATO','CON','registro','CON','crear','superior','');
select wf.f_import_ttipo_documento_estado ('delete','CONTRATO','CON','finalizado','CON',NULL,NULL,NULL);
select wf.f_import_ttipo_documento_estado ('insert','CONTRATO','CON','finalizado','CON','exigir','superior','');
select wf.f_import_ttipo_documento_estado ('insert','ADJ2','CON','registro','CON','crear','superior','');
select wf.f_import_ttipo_documento_estado ('insert','ADJ1','CON','registro','CON','crear','superior','');
select wf.f_import_ttipo_documento_estado ('delete','CONTRATO','CON','revision','CON',NULL,NULL,NULL);
select wf.f_import_ttipo_documento_estado ('delete','CONTRATO','CON','revision','CON',NULL,NULL,NULL);
select wf.f_import_ttipo_documento_estado ('insert','ADJ2','CON','revision','CON','crear','superior','');
select wf.f_import_ttipo_documento_estado ('insert','ADJ1','CON','revision','CON','crear','superior','');
select wf.f_import_ttipo_documento_estado ('insert','CONTRATO','CON','revision','CON','crear','superior','');
select wf.f_import_ttipo_documento_estado ('insert','contrato_adhesion','CON','borrador','CON','crear','superior','"{$tabla.contrato_adhesion}" = "si" and "{$tabla.tipo}" = "comercial"');
select wf.f_import_ttipo_documento_estado ('insert','contrato_adhesion','CON','vobo_comercial','CON','exigir','superior','"{$tabla.contrato_adhesion}" = "si" and "{$tabla.tipo}" = "comercial"');
select wf.f_import_ttipo_documento_estado ('delete','CONTRATO','CON','firma_contraparte','CON',NULL,NULL,NULL);
select wf.f_import_ttipo_documento_estado ('insert','CONTRATO','CON','archivo_legal','CON','exigir','superior','"{$tabla.contrato_adhesion}"="si"');
select wf.f_import_ttipo_documento_estado ('insert','ADJ1','CON','finalizado','CON','insertar','superior','');
select wf.f_import_ttipo_documento_estado ('insert','EPCONS','CON','borrador','CON','crear','superior','"{$tabla.tipo_persona}" = "juridica"');
select wf.f_import_ttipo_documento_estado ('insert','EPCONS','CON','vobo_comercial','CON','exigir','superior','"{$tabla.tipo_persona}" = "juridica"');
select wf.f_import_ttipo_documento_estado ('insert','PODRL','CON','borrador','CON','crear','superior','"{$tabla.tipo_persona}" = "juridica"');
select wf.f_import_ttipo_documento_estado ('insert','PODRL','CON','vobo_comercial','CON','exigir','superior','"{$tabla.tipo_persona}" = "juridica"');
select wf.f_import_ttipo_documento_estado ('insert','CIREP','CON','borrador','CON','crear','superior','');
select wf.f_import_ttipo_documento_estado ('insert','CIREP','CON','vobo_comercial','CON','exigir','superior','');
select wf.f_import_ttipo_documento_estado ('insert','NIT','CON','borrador','CON','crear','superior','"{$tabla.tipo_agencia}" != "institucional"');
select wf.f_import_ttipo_documento_estado ('insert','NIT','CON','vobo_comercial','CON','exigir','superior','"{$tabla.tipo_agencia}" != "institucional"');
select wf.f_import_ttipo_documento_estado ('insert','LICFUN','CON','borrador','CON','crear','superior','"{$tabla.tipo_agencia}" = "noiata"');
select wf.f_import_ttipo_documento_estado ('insert','LICFUN','CON','vobo_comercial','CON','exigir','superior','"{$tabla.tipo_agencia}" = "noiata"');
select wf.f_import_ttipo_documento_estado ('insert','REGFUN','CON','borrador','CON','crear','superior','"{$tabla.tipo_agencia}" != "institucional"');
select wf.f_import_ttipo_documento_estado ('insert','REGFUN','CON','vobo_comercial','CON','exigir','superior','"{$tabla.tipo_agencia}" != "institucional"');
select wf.f_import_ttipo_documento_estado ('insert','BOLGAR','CON','borrador','CON','crear','superior','position("postpago" in "{$tabla.formas_pago}")>0');
select wf.f_import_ttipo_documento_estado ('insert','BOLGAR','CON','vobo_comercial','CON','exigir','superior','position("postpago" in "{$tabla.formas_pago}")>0');
select wf.f_import_ttipo_documento_estado ('insert','CARCONT','CON','borrador','CON','crear','superior','');
select wf.f_import_ttipo_documento_estado ('insert','CARCONT','CON','vobo_comercial','CON','exigir','superior','');
select wf.f_import_ttipo_documento_estado ('insert','CONTRATO','CON','borrador','CON','crear','superior','"{$tabla.tipo}"="comercial"');
select wf.f_import_ttipo_documento_estado ('insert','CONTRATO','CON','vobo_comercial','CON','insertar','superior','"{$tabla.tipo}"="comercial"');
select wf.f_import_ttipo_proceso_origen ('insert','CON','LEGAL','COT','contrato_pendiente','obligatorio','adq.f_tiene_contrato');
select wf.f_import_ttipo_proceso_origen ('insert','CON','LEGAL','COTINPD','contrato_pendiente','obligatorio','adq.f_tiene_contrato');
select wf.f_import_ttipo_estado_rol ('delete','CON','finalizado','LEG- Contrato Finalizado');
select wf.f_import_ttipo_estado_rol ('insert','CON','borrador','LEG-Solicitante');
select wf.f_import_ttipo_estado_rol ('insert','CON','pendiente_asignacion','LEG - Jefe Legal');
select wf.f_import_ttipo_estado_rol ('insert','CON','registro','LEG-Abogado');
select wf.f_import_ttipo_estado_rol ('insert','CON','finalizado','LEG-Abogado');
select wf.f_import_ttipo_estado_rol ('insert','CON','finalizado','LEG- Contrato Finalizado');
select wf.f_import_ttipo_estado_rol ('insert','CON','firma_gerente','LEG-Gerencia');
select wf.f_import_ttipo_estado_rol ('delete','CON','firma_contraparte','LEG-Firma Contraparte');
select wf.f_import_ttipo_estado_rol ('delete','CON','firma_contraparte','LEG-Abogado');
select wf.f_import_ttipo_estado_rol ('insert','CON','digitalizacion','LEG-Digitalizacion');
select wf.f_import_ttipo_estado_rol ('delete','CON','vobo_abogado','LEG-Abogado');
select wf.f_import_ttipo_estado_rol ('delete','CON','vobo_jefe_legal','LEG - Jefe Legal');
select wf.f_import_ttipo_estado_rol ('insert','CON','vobo_rpc','LEG-Firma RPC');
select wf.f_import_ttipo_estado_rol ('insert','CON','vobo_gaf','LEG-Firma GAF');
select wf.f_import_ttipo_estado_rol ('insert','CON','revision','LEG-Revision');
select wf.f_import_ttipo_estado_rol ('delete','CON','firma_contraparte','LEG-Abogado');
select wf.f_import_ttipo_estado_rol ('delete','CON','firma_contraparte','LEG-Firma Contraparte');
select wf.f_import_ttipo_estado_rol ('delete','CON','firma_contraparte','LEG-Solicitante');
select wf.f_import_ttipo_estado_rol ('insert','CON','vobo_jefe_legal','LEG - Jefe Legal');
select wf.f_import_ttipo_estado_rol ('insert','CON','vobo_jefe_legal','LEG-Abogado');
select wf.f_import_ttipo_estado_rol ('delete','CON','vobo_comercial','LEG-Firma comercial');
select wf.f_import_ttipo_estado_rol ('delete','CON','firma_contraparte','LEG-Solicitante');
select wf.f_import_ttipo_estado_rol ('delete','CON','firma_contraparte','LEG-Abogado');
select wf.f_import_ttipo_estado_rol ('delete','CON','firma_contraparte','LEG-Firma Contraparte');
select wf.f_import_ttipo_estado_rol ('delete','CON','firma_contraparte','LEG-Firma Contraparte');
select wf.f_import_ttipo_estado_rol ('delete','CON','firma_contraparte','LEG-Solicitante');
select wf.f_import_ttipo_estado_rol ('delete','CON','firma_contraparte','LEG-Abogado');
select wf.f_import_ttipo_estado_rol ('delete','CON','firma_contraparte','LEG-Firma Contraparte');
select wf.f_import_ttipo_estado_rol ('delete','CON','firma_contraparte','LEG-Solicitante');
select wf.f_import_ttipo_estado_rol ('delete','CON','firma_contraparte','LEG-Abogado');
select wf.f_import_ttipo_estado_rol ('insert','CON','firma_contraparte','LEG-Solicitante');
select wf.f_import_ttipo_estado_rol ('insert','CON','firma_contraparte','LEG-Abogado');
select wf.f_import_ttipo_estado_rol ('insert','CON','firma_contraparte','LEG-Firma Contraparte');
select wf.f_import_ttipo_estado_rol ('insert','CON','firma_contraparte','ADQ - Solicitud de Compra');
select wf.f_import_ttipo_estado_rol ('insert','CON','archivo_legal','LEG-Digitalizacion');

/***********************************F-DEP-FEA-LEG-1-27/11/2018*****************************************/