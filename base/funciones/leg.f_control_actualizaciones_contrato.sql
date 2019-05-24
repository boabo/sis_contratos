CREATE OR REPLACE FUNCTION leg.f_control_actualizaciones_contrato (
)
RETURNS trigger AS
$body$
DECLARE

v_nombre 		varchar;
v_nombre_base 	varchar;
v_pago			varchar;

BEGIN

IF TG_OP = 'UPDATE' THEN

 /*ACTUALIZACION PARA QUE EL TIPO DE PAGO EN CONTRATO SE ACTUALIZE EN AGENCIA*/
   IF NEW.formas_pago is not null then
 	v_pago = NEW.formas_pago ;
    select replace(v_pago, '{', '') into v_pago;
    select replace(v_pago, '}', '') into v_pago;
 	UPDATE obingresos.tagencia
    set tipo_pago = v_pago
    where id_agencia = OLD.id_agencia;

   end if;
   /****************************************************************************/

	select per.nombre_completo1
	into v_nombre_base
	from segu.tusuario usu
	inner join segu.vpersona per on per.id_persona = usu.id_persona
	where usu.cuenta = CURRENT_USER;

	select per.nombre_completo1
	into v_nombre
	from segu.tusuario usu
	inner join segu.vpersona per on per.id_persona = usu.id_persona
	where usu.id_usuario = NEW.id_usuario_mod;

     INSERT INTO leg.tdato_anterior_contrato(
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
                    marri,
                    periodicidad_pago,
                    tiene_retencion,
                    fk_id_contrato,
                    modo,
                    id_lugar,
                    id_contrato_fk,
                    id_concepto_ingas,
                    id_orden_trabajo,
                    cargo,
                    forma_contratacion,
                    modalidad,
                    representante_legal,
                    rpc,
                    mae,
                    contrato_adhesion,
                    id_abogado,
                    id_funcionario,
                    rpc_regional,
                    bancarizacion,
                    tipo_monto,
                    resolucion_bancarizacion,
                    id_agencia,
                    tipo_agencia,
                    moneda_restrictiva,
                    cuenta_bancaria1,
                    entidad_bancaria1,
                    nombre_cuenta_bancaria1,
                    cuenta_bancaria2,
                    entidad_bancaria2,
                    nombre_cuenta_bancaria2,
                    formas_pago,
                    accion,
                    responsable
                    )
     VALUES(
     			   OLD.id_usuario_reg,
                   NEW.id_usuario_mod,
                   OLD.fecha_reg,
                   now(),
                   OLD.estado_reg,
                   OLD.id_usuario_ai,
                   OLD.usuario_ai,
                   OLD.id_contrato,
                   OLD.id_estado_wf,
                   OLD.id_proceso_wf,
                   OLD.estado,
                   OLD.tipo,
                   OLD.objeto,
                   OLD.fecha_inicio,
                   OLD.fecha_fin,
                   OLD.numero,
                   OLD.id_gestion,
                   OLD.id_persona,
                   OLD.id_institucion,
                   OLD.id_proveedor,
                   OLD.observaciones,
                   OLD.solicitud,
                   OLD.monto,
                   OLD.id_moneda,
                   OLD.fecha_elaboracion,
                   OLD.plazo,
                   OLD.tipo_plazo,
                   OLD.id_cotizacion,
                   OLD.marri,
                   OLD.periodicidad_pago,
                   OLD.tiene_retencion,
                   OLD.fk_id_contrato,
                   OLD.modo,
                   OLD.id_lugar,
                   OLD.id_contrato_fk,
                   OLD.id_concepto_ingas,
                   OLD.id_orden_trabajo,
                   OLD.cargo,
                   OLD.forma_contratacion,
                   OLD.modalidad,
                   OLD.representante_legal,
                   OLD.rpc,
                   OLD.mae,
                   OLD.contrato_adhesion,
                   OLD.id_abogado,
                   OLD.id_funcionario,
                   OLD.rpc_regional,
                   OLD.bancarizacion,
                   OLD.tipo_monto,
                   OLD.resolucion_bancarizacion,
                   OLD.id_agencia,
                   OLD.tipo_agencia,
                   OLD.moneda_restrictiva,
                   OLD.cuenta_bancaria1,
                   OLD.entidad_bancaria1,
                   OLD.nombre_cuenta_bancaria1,
                   OLD.cuenta_bancaria2,
                   OLD.entidad_bancaria2,
                   OLD.nombre_cuenta_bancaria2,
                   OLD.formas_pago,
                   'Modificado',
                   CASE WHEN v_nombre is null
                   THEN v_nombre_base
                         ELSE v_nombre
                    END

     );

ELSIF TG_OP = 'DELETE' THEN

	select per.nombre_completo1
	into v_nombre_base
	from segu.tusuario usu
	inner join segu.vpersona per on per.id_persona = usu.id_persona
	where usu.cuenta = CURRENT_USER;

IF(current_user is null) then
	select per.nombre_completo1
	into v_nombre
	from segu.tusuario usu
	inner join segu.vpersona per on per.id_persona = usu.id_persona
	where usu.id_usuario = NEW.id_usuario_mod;
end if;

 INSERT INTO leg.tdato_anterior_contrato(
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
                    marri,
                    periodicidad_pago,
                    tiene_retencion,
                    fk_id_contrato,
                    modo,
                    id_lugar,
                    id_contrato_fk,
                    id_concepto_ingas,
                    id_orden_trabajo,
                    cargo,
                    forma_contratacion,
                    modalidad,
                    representante_legal,
                    rpc,
                    mae,
                    contrato_adhesion,
                    id_abogado,
                    id_funcionario,
                    rpc_regional,
                    bancarizacion,
                    tipo_monto,
                    resolucion_bancarizacion,
                    id_agencia,
                    tipo_agencia,
                    moneda_restrictiva,
                    cuenta_bancaria1,
                    entidad_bancaria1,
                    nombre_cuenta_bancaria1,
                    cuenta_bancaria2,
                    entidad_bancaria2,
                    nombre_cuenta_bancaria2,
                    formas_pago,
                    accion,
                    responsable
                    )
     VALUES(
                   OLD.id_usuario_reg,
                   OLD.id_usuario_mod,
                   OLD.fecha_reg,
                   now(),
                   OLD.estado_reg,
                   OLD.id_usuario_ai,
                   OLD.usuario_ai,
                   OLD.id_contrato,
                   OLD.id_estado_wf,
                   OLD.id_proceso_wf,
                   OLD.estado,
                   OLD.tipo,
                   OLD.objeto,
                   OLD.fecha_inicio,
                   OLD.fecha_fin,
                   OLD.numero,
                   OLD.id_gestion,
                   OLD.id_persona,
                   OLD.id_institucion,
                   OLD.id_proveedor,
                   OLD.observaciones,
                   OLD.solicitud,
                   OLD.monto,
                   OLD.id_moneda,
                   OLD.fecha_elaboracion,
                   OLD.plazo,
                   OLD.tipo_plazo,
                   OLD.id_cotizacion,
                   OLD.marri,
                   OLD.periodicidad_pago,
                   OLD.tiene_retencion,
                   OLD.fk_id_contrato,
                   OLD.modo,
                   OLD.id_lugar,
                   OLD.id_contrato_fk,
                   OLD.id_concepto_ingas,
                   OLD.id_orden_trabajo,
                   OLD.cargo,
                   OLD.forma_contratacion,
                   OLD.modalidad,
                   OLD.representante_legal,
                   OLD.rpc,
                   OLD.mae,
                   OLD.contrato_adhesion,
                   OLD.id_abogado,
                   OLD.id_funcionario,
                   OLD.rpc_regional,
                   OLD.bancarizacion,
                   OLD.tipo_monto,
                   OLD.resolucion_bancarizacion,
                   OLD.id_agencia,
                   OLD.tipo_agencia,
                   OLD.moneda_restrictiva,
                   OLD.cuenta_bancaria1,
                   OLD.entidad_bancaria1,
                   OLD.nombre_cuenta_bancaria1,
                   OLD.cuenta_bancaria2,
                   OLD.entidad_bancaria2,
                   OLD.nombre_cuenta_bancaria2,
                   OLD.formas_pago,
                   'Eliminado',
                   CASE WHEN v_nombre is null THEN v_nombre_base
                         ELSE v_nombre
                    END
     );
END IF;



RETURN NEW;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
