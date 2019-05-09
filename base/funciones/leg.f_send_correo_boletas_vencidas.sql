CREATE OR REPLACE FUNCTION leg.f_send_correo_boletas_vencidas (
  p_id_uo_funcionario integer,
  p_id_uo integer
)
RETURNS varchar AS
$body$
DECLARE
    v_nombre_funcion   	text;
    v_resp    			varchar;
    v_mensaje 			varchar;
	v_record			record;
	v_correos			varchar;
    v_plantilla			varchar;
    v_hora_saludo		varchar;
    v_asunto			varchar;
    v_id_alarma			integer;
BEGIN
	v_nombre_funcion  = 'leg.f_send_correo_boletas_vencidas';
	v_asunto = 'Boletas de Garantia Proximas a Vencer';


    v_hora_saludo = case when current_time between '08:00:00'::time and '12:00:00'::time then '<b>Buenos dias' ::varchar
                           when current_time between '12:00:00'::time and '19:00:00'::time then '<b>Buenas tardes'::varchar end;

    v_plantilla = v_hora_saludo||' estimado Administrador:</b><br>
        <p>En fecha '||current_date||'.<br> se reportan las siguientes boletas vencidas.
        </p> <table>';

      -- v_week  = (date_trunc('day', current_date) + INTERVAL '1 MONTH - 7 day')::DATE;
       ---v_three = (date_trunc('day', current_date) + INTERVAL '1 MONTH + 3 day')::DATE;
       --v_two   = (date_trunc('day', current_date) + INTERVAL '1 MONTH + 2 day')::DATE;
      -- v_one   = (date_trunc('day', current_date) + INTERVAL '1 MONTH + 1 day')::DATE;
    for v_record in  
			select
             anex.banco,
             anex.nro_documento,
             anex.tipo_boleta as tipo,
             COALESCE(agen.nombre, prov.desc_proveedor) AS agencia,
             leg.f_fecha_dia_mes_literal_anio(anex.fecha_hasta) as fecha_hasta,
             anex.fecha_fin_uso,
             anex.monto AS asegurado
           FROM leg.tcontrato con
           JOIN leg.tanexo anex ON anex.id_contrato = con.id_contrato
           LEFT JOIN obingresos.tagencia agen ON agen.id_agencia = con.id_agencia
           LEFT JOIN param.vproveedor prov ON prov.id_proveedor = con.id_proveedor
           LEFT join param.tgestion ges on ges.id_gestion = con.id_gestion
        where coalesce(anex.fecha_fin_uso, anex.fecha_hasta) between current_date and 
        (date_trunc('MONTH', current_date) + INTERVAL '2 MONTH -1 day')::DATE
        and (anex.estado is null or anex.estado = '' or anex.estado in ('devuelto','ejecutado'))    
     loop

    	v_plantilla =  v_plantilla || '<tr> <td> '||v_record.agencia||' </td> <td>vence en fecha '|| v_record.fecha_hasta||'</td></tr>';
        v_correos = 'lista_de_correos';
	end loop;
    v_id_alarma =  param.f_inserta_alarma(
                                              2134,
                                              v_plantilla,
                                              v_asunto,
                                              current_date,
                                              'notificacion',
                                              'Ninguna',
                                              612,
                                              '',
                                              v_asunto,--titulo
                                              '{filtro_directo:{campo:"id_funcionario",valor:"'||2134||'"}}',
                                              NULL::integer,
                                              'Boletas Vencidas '||current_date,
                                              v_correos,
                                              null,
                                              null
                                              );
    return v_id_alarma::varchar;
EXCEPTION
	WHEN OTHERS THEN
			v_resp='';
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
			v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
			v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
			raise exception '%',v_resp;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;