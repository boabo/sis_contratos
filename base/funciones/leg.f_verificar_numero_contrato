CREATE OR REPLACE FUNCTION leg.f_verificar_numero_contrato (
  p_nombre_tabla varchar,
  p_numero_contrato varchar
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
BEGIN

  v_nombre_funcion:='leg.f_verificar_numero_contrato';
  if p_nombre_tabla = 'contrato'
  then
  	if p_numero_contrato != ''
    then
    	for v_numeros_contrato in (select numero
									from leg.tcontrato
									where numero is not null and numero != 'NO APLICA'  and numero !='-' and numero !='sin numero' and numero !='no_tiene' and numero !='NO TIENE' and numero !='NO_TIENE' and numero != 'SN' and numero != 'S/N' and numero != 's/n' and numero !=''
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

ALTER FUNCTION leg.f_verificar_numero_contrato (p_nombre_tabla varchar, p_numero_contrato varchar)
  OWNER TO postgres;