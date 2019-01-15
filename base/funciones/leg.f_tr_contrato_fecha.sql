CREATE OR REPLACE FUNCTION leg.f_tr_contrato_fecha (
)
RETURNS trigger AS
$body$
DECLARE
  v_record	record;  
  fecha_uno date;
  fecha_dos	date;
BEGIN
  IF TG_OP = 'INSERT' THEN
  	IF NEW.id_agencia is not null then
  
            select max(con.fecha_fin)
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
           end if;
   END IF;
   
   ELSIF TG_OP = 'UPDATE' THEN
  
   IF NEW.id_agencia is not null then
  
            select max(con.fecha_fin)
            into 
            fecha_dos
            from leg.tcontrato con
            where con.id_agencia = NEW.id_agencia and con.estado = 'concluido';
            
          
            select 	co.id_agencia,
                    co.fecha_fin
                    into 
                    v_record
                    from leg.tcontrato co
                    where co.id_agencia = NEW.id_agencia
                    and co.fecha_fin =fecha_dos;
                    
           if (v_record.fecha_fin = NEW.fecha_inicio)then
           NEW.fecha_inicio = NEW.fecha_inicio + interval '1 day';
           else
           NEW.fecha_inicio = NEW.fecha_inicio;
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