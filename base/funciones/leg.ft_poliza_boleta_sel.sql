CREATE OR REPLACE FUNCTION leg.ft_poliza_boleta_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Módulo de Contratos
 FUNCION: 		leg.ft_poliza_voletos_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'leg.tpoliza_voletos'
 AUTOR: 		 (breydi.vasquez)
 FECHA:	        18-04-2018 20:02:21
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				18-04-2018 20:02:21								Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'leg.tpoliza_voletos'
 #
 ***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
    v_anio1		        varchar;
    v_anio2		        varchar;
    v_filtro			varchar;
    v_f_date			date;
    v_accion		    text;
    v_estado 			text;

BEGIN

	v_nombre_funcion = 'leg.ft_poliza_boleta_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'LG_POBOA_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		breydi.vasquez
 	#FECHA:		18-04-2018 20:02:21
	***********************************/

	if(p_transaccion='LG_POBOA_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='select
            			pobo.id_anexo,
            			pobo.estado_reg,
						pobo.agencia,
                        pobo.nro_documento,
						pobo.fecha_desde,
                        pobo.fecha_fin_uso,
						pobo.moneda,
						pobo.asegurado,
                        pobo.estado,
						pobo.codigo_noiata,
						pobo.codigo,
						pobo.fecha_hasta,
						pobo.fecha_corte,
						pobo.codigo_int,
						pobo.fecha_notif,
						pobo.tipo,
						pobo.numero,
                        pobo.tipo_agencia,
						pobo.banco,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        pobo.id_usuario_reg,
                        pobo.id_usuario_mod,
                        pobo.observaciones,
                        pobo.id_agencia,
                        pobo.estado_contrato,
                        pobo.id_proceso_wf,
                        pobo.id_estado_wf,
                        pobo.nro_hoja_ruta,
                        pobo.id_contrato,
                        pobo.id_gestion,
                        ges.gestion,
                        pobo.id_proveedor
						from leg.vpoliza_boletas pobo
						inner join segu.tusuario usu1 on usu1.id_usuario = pobo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = pobo.id_usuario_mod
						inner join param.tgestion ges on ges.id_gestion = pobo.id_gestion
				        where pobo.tipo_agencia=''noiata'' and ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
			--raise notice '%',v_consulta;
			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  'LG_POBOA_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		breydi.vasquez
 	#FECHA:		18-04-2018 20:02:21
	***********************************/

	elsif(p_transaccion='LG_POBOA_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_anexo),sum(pobo.asegurado)
					    from leg.vpoliza_boletas pobo
					    inner join segu.tusuario usu1 on usu1.id_usuario = pobo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = pobo.id_usuario_mod
						inner join param.tgestion ges on ges.id_gestion = pobo.id_gestion
					    where pobo.tipo_agencia=''noiata'' and ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
	/*********************************
 	#TRANSACCION:  'LG_POBOO_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		breydi.vasquez
 	#FECHA:		18-04-2018 20:02:21
	***********************************/

	elsif(p_transaccion='LG_POBOO_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='select
            			pobo.id_anexo,
						pobo.banco,
                        pobo.nro_documento,
						pobo.tipo,
                        pobo.proveedor,
						pobo.numero,
						pobo.fecha_fin_uso,
						pobo.fecha_desde,
						pobo.fecha_notif,
						pobo.fecha_corte,
                        pobo.fecha_hasta,
						pobo.moneda,
                        pobo.asegurado,
                        pobo.estado,
                        usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        pobo.id_usuario_reg,
                        pobo.id_usuario_mod,
                        --pobo.id_usuario_mod,
                        pobo.tipo_agencia,
                        pobo.observaciones,
                        pobo.estado_contrato,
                        pobo.id_proceso_wf,
                        pobo.id_estado_wf,
                        pobo.nro_hoja_ruta,
                        pobo.id_contrato,
                        pobo.id_gestion,
                        ges.gestion,
                        pobo.id_proveedor,
                        pobo.id_institucion,
                        pobo.institucion
						from leg.vpoliza_boletas_otras pobo
                        inner join segu.tusuario usu1 on usu1.id_usuario = pobo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = pobo.id_usuario_mod
                        left join param.tgestion ges on ges.id_gestion = pobo.id_gestion
				        where ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
			--raise notice 'v_consulta%',v_consulta;
			--Devuelve la respuesta
			return v_consulta;

		end;
  /*********************************
 	#TRANSACCION:  'LG_POBOO_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		breydi.vasquez
 	#FECHA:		18-04-2018 20:02:21
	***********************************/

	elsif(p_transaccion='LG_POBOO_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_anexo),sum(pobo.asegurado)
					    from leg.vpoliza_boletas_otras pobo
                        inner join segu.tusuario usu1 on usu1.id_usuario = pobo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = pobo.id_usuario_mod
                        left join param.tgestion ges on ges.id_gestion = pobo.id_gestion
					    where ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;

  /*********************************
 	#TRANSACCION:  'LG_RBSGAR_SEL'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		breydi.vasquez
 	#FECHA:		11-01-2019
	***********************************/

	elsif(p_transaccion='LG_RBSGAR_SEL')then

		begin
			--Sentencia de la consulta de conteo de registros
        v_accion = ' 0 = 0';    
        v_estado = ' 0 = 0 and ';
        if v_parametros.boleta_filtro = 'ejecutado' then

        	v_accion = 'anex.estado = ''ejecutado''';
          	v_filtro = 'COALESCE(anex.fecha_fin_uso,anex.fecha_hasta)>=  '''||v_parametros.fecha_hasta||'''';             
        elsif v_parametros.boleta_filtro = 'devuelto' then 
        	v_accion = 'anex.estado = ''devuelto''';
            v_filtro = 'COALESCE(anex.fecha_fin_uso,anex.fecha_hasta)>=  '''||v_parametros.fecha_hasta||''''; 	        
            
		elsif v_parametros.boleta_filtro = 'vencida' then
      		v_filtro = 'anex.fecha_hasta between '''||v_parametros.fecha_desde||''' and '''||v_parametros.fecha_hasta||'''';            
            v_estado = '(anex.estado is null or anex.estado = '''') and ';
        elsif v_parametros.boleta_filtro = 'vigente' then
            v_filtro = 'COALESCE(anex.fecha_fin_uso,anex.fecha_hasta)>=  '''||v_parametros.fecha_hasta||''''; 
            v_estado = '(anex.estado is null or anex.estado = '''') and ';
        end if;

			v_consulta:='select
             anex.banco,
             anex.nro_documento,
             anex.tipo_boleta as tipo,
             COALESCE(agen.nombre, prov.desc_proveedor) AS agencia,
             leg.f_fecha_dia_mes_literal_anio(anex.fecha_desde) as fecha_desde,
             leg.f_fecha_dia_mes_literal_anio(anex.fecha_hasta) as fecha_hasta,
             anex.monto AS asegurado,
             con.tipo_agencia,
             anex.estado,
             ges.gestion,
             anex.origen
           FROM leg.tcontrato con
           RIGHT JOIN leg.tanexo anex ON anex.id_contrato = con.id_contrato
           LEFT JOIN obingresos.tagencia agen ON agen.id_agencia = con.id_agencia
           LEFT JOIN param.vproveedor prov ON prov.id_proveedor = con.id_proveedor
           LEFT join param.tgestion ges on ges.id_gestion = con.id_gestion
        where
        '||v_filtro||'
        and '||v_estado||' anex.banco not like ''%FICTICI%''
        and '||v_accion||'
        and ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by COALESCE(anex.fecha_fin_uso,anex.fecha_hasta) asc';
			raise notice '%',v_consulta;
			--Devuelve la respuesta
			return v_consulta;


		end;

  /*********************************
 	#TRANSACCION:  'LG_CONTRA_SEL'
 	#DESCRIPCION:	Consulta contratos
 	#AUTOR:		breydi.vasquez
 	#FECHA:		18-04-2018 20:02:21
	***********************************/

	elsif(p_transaccion='LG_CONTRA_SEL')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select CON.id_contrato,
                                 pw.nro_tramite,
                                 CON.numero,
                                 CON.tipo,
                                 CON.objeto,
                                 CON.estado,
                                 prov.desc_proveedor,       
                                 CON.monto,
                                 mon.moneda,
                                 CON.fecha_inicio,
                                 CON.fecha_fin 
                          from leg.tcontrato CON
                               inner join segu.tusuario usu1 on usu1.id_usuario = CON.id_usuario_reg
                               left join segu.tusuario usu2 on usu2.id_usuario = CON.id_usuario_mod
                               inner join param.tgestion ges on ges.id_gestion = con.id_gestion
                               left join param.vproveedor prov on prov.id_proveedor = con.id_proveedor
                               inner join param.tmoneda mon on mon.id_moneda = con.id_moneda
                               left join obingresos.tagencia age on age.id_agencia = con.id_agencia
                               left join param.tlugar lug on lug.id_lugar = con.id_lugar
                               inner join leg.vcontrato view on view . id_contrato = con.id_contrato
                               inner join wf.testado_wf ew on ew.id_estado_wf = CON.id_estado_wf
                               inner join wf.tproceso_wf pw on pw.id_proceso_wf = CON.id_proceso_wf
                               left join orga.vfuncionario fun on fun.id_funcionario = ew.id_funcionario
                          where CON.estado_reg != ''inactivo'' and
                                CON.estado != ''anulado'' and
                                CON.estado = ''finalizado'' 
                                and 
	  								';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;

		end;
    /*********************************
      #TRANSACCION:  'LG_CONTRA_CONT'
      #DESCRIPCION:	Conteo de registros
      #AUTOR:		breydi.vasquez
      #FECHA:		18-04-2018 20:02:21
      ***********************************/

	elsif(p_transaccion='LG_CONTRA_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='   select count(con.id_contrato)
            				from leg.tcontrato CON
                               inner join segu.tusuario usu1 on usu1.id_usuario = CON.id_usuario_reg
                               left join segu.tusuario usu2 on usu2.id_usuario = CON.id_usuario_mod
                               inner join param.tgestion ges on ges.id_gestion = con.id_gestion
                               left join param.vproveedor prov on prov.id_proveedor = con.id_proveedor
                               inner join param.tmoneda mon on mon.id_moneda = con.id_moneda
                               left join obingresos.tagencia age on age.id_agencia = con.id_agencia
                               left join param.tlugar lug on lug.id_lugar = con.id_lugar
                               inner join leg.vcontrato view on view . id_contrato = con.id_contrato
                               inner join wf.testado_wf ew on ew.id_estado_wf = CON.id_estado_wf
                               inner join wf.tproceso_wf pw on pw.id_proceso_wf = CON.id_proceso_wf
                               left join orga.vfuncionario fun on fun.id_funcionario = ew.id_funcionario
                          where CON.estado_reg != ''inactivo'' and
                                CON.estado != ''anulado'' and
                                CON.estado = ''finalizado'' 
                                and ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;

    /*********************************
      #TRANSACCION:  'LG_LISTBAN_SEL'
      #DESCRIPCION:	Consulta datos bancos
      #AUTOR:		breydi.vasquez
      #FECHA:		18-04-2018 20:02:21
      ***********************************/

	elsif(p_transaccion='LG_LISTBAN_SEL')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select  instit.id_institucion,
                                 instit.nombre
                          from param.tinstitucion instit
                          where instit.estado_reg = ''activo''
                          and instit.es_banco = ''si''
                          and ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
			--Devuelve la respuesta
			return v_consulta;

		end;                        
    /*********************************
      #TRANSACCION:  'LG_LISTBAN_CONT'
      #DESCRIPCION:	Consulta datos bancos
      #AUTOR:		breydi.vasquez
      #FECHA:		18-04-2018 20:02:21
      ***********************************/

	elsif(p_transaccion='LG_LISTBAN_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:=' select count(instit.id_institucion)
            		      from param.tinstitucion instit
                          where instit.estado_reg = ''activo''
                          and ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			--Devuelve la respuesta
			return v_consulta;

		end; 

	else

		raise exception 'Transaccion inexistente';

	end if;

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

ALTER FUNCTION leg.ft_poliza_boleta_sel (p_administrador integer, p_id_usuario integer, p_tabla varchar, p_transaccion varchar)
  OWNER TO postgres;