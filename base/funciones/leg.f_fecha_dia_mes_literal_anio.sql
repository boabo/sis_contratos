CREATE OR REPLACE FUNCTION leg.f_fecha_dia_mes_literal_anio (
  p_fecha date
)
RETURNS text AS
$body$
/**************************************************************************
 SISTEMA:       PXP
 FUNCION:       pxp.f_fecha_dia_mes_literal_anio
 DESCRIPCION:   devuelve la fecha en forato dia-mes literal abreviado-anio dos digitos
 AUTOR:          BVP
 FECHA:         13-01-2019 05:17:a.m
***************************************************************************/
DECLARE
dia varchar;                  
mes varchar;
anno varchar;  
fecha_literal text;       
literal_dia varchar;
fecha   date;   
hora varchar;                        
BEGIN
              dia=to_char(p_fecha,'dd'); 
              mes=to_char(p_fecha,'mm');
              anno= substr(to_char(p_fecha,'yyyy'),3,4);
              fecha =to_char(p_fecha,'dd/mm/yyyy');
              hora = to_char(p_fecha,'HH24:MI');
              literal_dia= rec.f_dia_literal(fecha);


  IF(mes='01') THEN 
      RETURN  dia||'-ene-'||anno;
  ELSIF(mes='02') THEN 
      RETURN  dia||'-feb-'||anno;
  ELSIF(mes='03') THEN 
      RETURN  dia||'-mar'||anno;         
  ELSIF(mes='04') THEN 
      RETURN  dia||'-abr'||anno;
  ELSIF(mes='05') THEN 
      RETURN  dia||'-may'||anno;
  ELSIF(mes='06') THEN 
      RETURN  dia||'-jun'||anno;
  ELSIF(mes='07') THEN 
      RETURN  dia||'-jul'||anno;
  ELSIF(mes='08') THEN 
      RETURN  dia||'-ago '||anno;
  ELSIF(mes='09') THEN 
      RETURN  dia||'-sep-'||anno;
  ELSIF(mes='10') THEN 
      RETURN  dia||'-oct-'||anno;
  ELSIF(mes='11') THEN 
      RETURN  dia||'-nov-'||anno;
  ELSE 
      RETURN  dia||'-dic-'||anno;
  END if;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;