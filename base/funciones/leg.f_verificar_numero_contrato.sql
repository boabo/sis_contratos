CREATE OR REPLACE FUNCTION leg.f_verificar_numero_contrato (
  p_nombre_tabla varchar,
  p_numero_contrato varchar,
  p_id_contrato integer,
  p_accion varchar
)
RETURNS void AS
$body$
/**************************************************************************
 FUNCION: 		leg.f_verificar_numero_contrato
 DESCRIPCION:   revisa si un numero de contrato es duplicado al momento de hacer la insercion del contrato o la modificacion de la misma
 AUTOR: 	    Alan Felipez
 FECHA:	        09/10/2019
 COMENTARIOS:
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCION:
 AUTOR:
 FECHA:
 ***************************************************************************/


DECLARE
  v_nombre_funcion   	text;
  v_numeros_contrato  record;
  v_resp				varchar;
  v_registros			record;
BEGIN

  v_nombre_funcion:='leg.f_verificar_numero_contrato';

  if p_nombre_tabla = 'contrato'
  then
  	if p_numero_contrato != '' and p_accion = 'modificar'
    then
    	for v_numeros_contrato in (select numero
									from leg.tcontrato
									where numero is not null and numero != 'NO APLICA'  and numero !='-' and numero !='sin numero'
                                    				and numero !='no_tiene' and numero !='NO TIENE' and numero !='NO_TIENE' and numero != 'SN'
                                                    and numero != 'S/N' and numero != 's/n' and numero !='' and id_contrato != p_id_contrato
									order by numero )loop
        	if v_numeros_contrato.numero = p_numero_contrato then

                        SELECT
                        instit.nombre,
                        pr.rotulo_comercial,
                        per.nombre as nombre_persona,
                        per.apellido_paterno,
                        per.apellido_materno
                        into v_registros
                        from leg.tcontrato con
                        inner join param.tproveedor pr on pr.id_proveedor = con.id_proveedor
                        left join param.tinstitucion instit on instit.id_institucion=pr.id_institucion
                        inner join segu.tusuario usu on usu.id_usuario = con.id_usuario_reg
                        inner join segu.tpersona per on per.id_persona = usu.id_persona
                        where con.numero=v_numeros_contrato.numero;

            		if v_registros.nombre_persona is null then
                    	raise exception 'El contrato con numero % ya fue registrado anteriormente',v_numeros_contrato.numero;
                else
  						      raise exception 'El numero de contrato % ya fue registrado por % % %, para el proveedor %',v_numeros_contrato.numero, v_registros.nombre_persona ,v_registros.apellido_paterno,v_registros.apellido_materno,v_registros.rotulo_comercial;
            		end if;
            end if;
        end loop;

    elsif p_numero_contrato != '' and p_accion = 'insertar'
    then
    	for v_numeros_contrato in (select numero
									from leg.tcontrato
									where numero is not null and numero != 'NO APLICA'  and numero !='-' and numero !='sin numero'
                                    				and numero !='no_tiene' and numero !='NO TIENE' and numero !='NO_TIENE' and numero != 'SN'
                                                    and numero != 'S/N' and numero != 's/n' and numero !=''
									order by numero )loop
        	if v_numeros_contrato.numero = p_numero_contrato then
  					raise exception 'no es posible insertar un numero de contrato duplicado %',v_numeros_contrato.numero;
            end if;
        end loop;
    end if;
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

COMMENT ON FUNCTION leg.f_verificar_numero_contrato(p_nombre_tabla varchar, p_numero_contrato varchar, p_id_contrato integer, p_accion varchar)
IS 'funcion que revisa si un numero de contrato es duplicado al momento de hacer la insercion
del contrato o la modificacion de la misma';

ALTER FUNCTION leg.f_verificar_numero_contrato (p_nombre_tabla varchar, p_numero_contrato varchar, p_id_contrato integer, p_accion varchar)
  OWNER TO postgres;