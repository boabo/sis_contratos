CREATE OR REPLACE FUNCTION leg.f_control_eliminacion_datos_modificados (
)
RETURNS trigger AS
$body$
DECLARE
v_nombre 	varchar;

BEGIN

select per.nombre_completo1
into v_nombre
from segu.tusuario usu
inner join segu.vpersona per on per.id_persona = usu.id_persona
where usu.cuenta = current_user;

IF TG_OP = 'DELETE' THEN
     RAISE EXCEPTION 'No se puede eliminar el registro de la tabla tdato_anterior_contrato';
ELSIF TG_OP = 'UPDATE' THEN
	 RAISE EXCEPTION 'No se puede modificar el registro en la tabla tdato_anterior_contrato';
END IF;

RETURN NEW;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;
