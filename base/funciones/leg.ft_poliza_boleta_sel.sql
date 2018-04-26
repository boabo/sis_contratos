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
			    
BEGIN

	v_nombre_funcion = 'leg.ft_poliza_boleta_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'LG_POBO_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		breydi.vasquez	
 	#FECHA:		18-04-2018 20:02:21
	***********************************/

	if(p_transaccion='LG_POBOA_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
            			pobo.id_contrato,
            			pobo.estado_reg,
						pobo.agencia,
                        pobo.nro_documento,
						pobo.fecha_desde,
                        pobo.fecha_fin_uso,
						pobo.moneda,
						pobo.asegurado,
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
                        pobo.id_usuario_mod
						from leg.vpoliza_boletas pobo
						inner join segu.tusuario usu1 on usu1.id_usuario = pobo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = pobo.id_usuario_mod
				        where';
			--raise notice 'v_consulta%',v_consulta;
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

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
			v_consulta:='select count(id_contrato)
					    from leg.vpoliza_boletas pobo
					    inner join segu.tusuario usu1 on usu1.id_usuario = pobo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = pobo.id_usuario_mod
					    where ';
			
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
            			pobo.id_contrato,
						pobo.banco,
                        pobo.nro_documento,
						pobo.tipo,
                        pobo.proveedor,
						pobo.numero,
						pobo.fecha_fin_uso,
						pobo.fecha_desde,
						pobo.fecha_notif,
						pobo.fecha_corte,
						pobo.moneda,
                        pobo.asegurado,
                        usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        pobo.id_usuario_reg,
                        pobo.id_usuario_mod
						from leg.vpoliza_boletas_otras pobo
                        inner join segu.tusuario usu1 on usu1.id_usuario = pobo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = pobo.id_usuario_mod						
				        where';
			--raise notice 'v_consulta%',v_consulta;
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

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
			v_consulta:='select count(id_contrato)
					    from leg.vpoliza_boletas_otras pobo
                        inner join segu.tusuario usu1 on usu1.id_usuario = pobo.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = pobo.id_usuario_mod			
					    where ';
			
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