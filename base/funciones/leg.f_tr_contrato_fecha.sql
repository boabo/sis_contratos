CREATE OR REPLACE FUNCTION leg.f_tr_contrato_fecha (
)
RETURNS trigger AS
$body$
DECLARE
  v_record	record;
  fecha_uno date;
  fecha_dos	date;
  control_fecha		record;
  nombre_agencia	varchar;
  v_nombre			varchar;
  v_nombre2			varchar;
  datos_contrato	record;
  v_id_usuario 		integer;
  g_new_login		varchar;
  numero_contrato	varchar;
  v_id_contrato		integer;
  v_pago			varchar;
BEGIN
  IF TG_OP = 'INSERT' THEN

  	IF NEW.id_agencia is not null then

           select 1 as resultado ,
            con.numero,
            con.fecha_inicio,
			con.fecha_fin,
            con.id_usuario_reg
            into
            control_fecha
            from leg.tcontrato con
            where con.id_agencia = NEW.id_agencia and
   		    (New.fecha_inicio between con.fecha_inicio and con.fecha_fin
            or NEW.fecha_fin between con.fecha_inicio and con.fecha_fin)
            and con.id_contrato <> NEW.id_contrato;

            select ag.nombre
            into nombre_agencia
            from obingresos.tagencia ag
            where ag.id_agencia = NEW.id_agencia
            group by ag.nombre;

            select per.nombre_completo1
            into v_nombre
            from segu.tusuario usu
            inner join segu.vpersona per on per.id_persona = usu.id_persona
            where usu.id_usuario = control_fecha.id_usuario_reg;

      if(NEW.fecha_inicio >= NEW.fecha_fin)then
      raise exception 'La fecha inicio no puede ser mayor o igual a la fecha fin revise!';
      end if;


      if(control_fecha.resultado = 1 ) then
      raise exception 'Las fechas ingresadas para la Agencia: %, se encuentra dentro del rango de Fecha Inicio: % hasta la Fecha Fin: %,
            				 del contrato N°%, registradas por el Usuario: %, revise por favor.',nombre_agencia, to_char(control_fecha.fecha_inicio,'DD/MM/YYYY'), to_char(control_fecha.fecha_fin,'DD/MM/YYYY'), control_fecha.numero, v_nombre;
      end if;

      /*ACTUALIZACION PARA QUE EL TIPO DE PAGO EN CONTRATO SE ACTUALIZE EN AGENCIA*/
        v_pago = NEW.formas_pago ;
        select replace(v_pago, '{', '') into v_pago;
        select replace(v_pago, '}', '') into v_pago;
        UPDATE obingresos.tagencia
        set tipo_pago = v_pago
        where id_agencia = NEW.id_agencia;
      /****************************************************************************/


           /* select
            max(con.fecha_fin)
            into
            fecha_dos
            from leg.tcontrato con
            where con.id_agencia = NEW.id_agencia;

            select 	co.id_agencia,
                    co.fecha_fin
                    into
                    v_record
                    from leg.tcontrato co
                    where co.id_agencia = NEW.id_agencia
                    and co.estado = 'finalizado'
                    and co.fecha_fin =fecha_dos;

           if (v_record.fecha_fin = NEW.fecha_inicio)then
           NEW.fecha_inicio = NEW.fecha_inicio + interval '1 day';
           update leg.tcontrato  set
           	fecha_fin = now()::date,
             estado = 'concluido'
             where id_agencia = NEW.id_agencia and fecha_fin = fecha_dos;
           else
           NEW.fecha_inicio = NEW.fecha_inicio;
           update leg.tcontrato  set
           fecha_fin = now()::date,
             estado = 'concluido'
             where id_agencia = NEW.id_agencia and fecha_fin = fecha_dos;
           end if;*/
   END IF;

   ELSIF TG_OP = 'UPDATE' THEN
   IF NEW.id_agencia is not null then
   			select 1 as resultado ,
            con.numero,
            con.fecha_inicio,
			con.fecha_fin,
            con.id_usuario_reg
            into
            control_fecha
            from leg.tcontrato con
            where con.id_agencia = OLD.id_agencia and
   		    (New.fecha_inicio between con.fecha_inicio and con.fecha_fin
            or NEW.fecha_fin between con.fecha_inicio and con.fecha_fin)
            and con.id_contrato <> OLD.id_contrato;


            select ag.nombre
            into nombre_agencia
            from obingresos.tagencia ag
            where ag.id_agencia = OLD.id_agencia
            group by ag.nombre;


            select per.nombre_completo1
            into v_nombre
            from segu.tusuario usu
            inner join segu.vpersona per on per.id_persona = usu.id_persona
            where usu.id_usuario = control_fecha.id_usuario_reg;

      if(NEW.fecha_inicio >= NEW.fecha_fin)then
      raise exception 'La fecha inicio no puede ser mayor o igual a la fecha fin por favor verifique!';
      end if;

       if(control_fecha.resultado = 1 ) then
       		raise exception 'Las fechas ingresadas para la Agencia: %, se encuentra dentro del rango de Fecha Inicio: % hasta la Fecha Fin: %,
            				 del contrato N°%, registradas por el Usuario: %, revise por favor.',nombre_agencia, to_char(control_fecha.fecha_inicio,'DD/MM/YYYY'), to_char(control_fecha.fecha_fin,'DD/MM/YYYY'), control_fecha.numero, v_nombre;
      end if;


   END IF;


  END IF;
  return NEW;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
