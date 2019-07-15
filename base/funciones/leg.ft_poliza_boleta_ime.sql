CREATE OR REPLACE FUNCTION leg.ft_poliza_boleta_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		contratos
 FUNCION: 		leg.ft_poliza_boleta_ime
 DESCRIPCION:   
 AUTOR: 		 
 FECHA:	        
 COMENTARIOS:
***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_anexo		     	integer;
	v_resp		            varchar;
    v_bol_vencidas			varchar;
	v_nombre_funcion		varchar;
    v_banco 				varchar;
    v_moneda				varchar;
    v_codigo_tipo_proceso   varchar;
    v_id_proceso_macro		integer;
    v_gestion				integer;
    v_nro_tramite			varchar;
    v_id_proceso_wf			integer;
    v_id_estado_wf			integer;
    v_codigo_estado			varchar;
	v_id_tipo_estado        integer;
	v_codigo_estado_siguiente    varchar;
    v_id_depto 				integer;
    v_obs 					text;
    v_acceso_directo 		varchar;
    v_clase 				varchar;
    v_parametros_ad 		varchar;
    v_tipo_noti 			varchar;
    v_titulo  				varchar;
    v_id_estado_actual 		integer;
    v_result 				varchar;
    v_pedir_obs				varchar;
    v_id_contrato 			integer;
    v_id_gestion			integer;

BEGIN

    v_nombre_funcion = 'leg.ft_poliza_boleta_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'LEG_POB_ALARM'
 	#DESCRIPCION:	
 	#AUTOR:		
 	#FECHA:		
	***********************************/

	if(p_transaccion='LEG_POB_ALARM')then
		begin
			v_bol_vencidas = leg.f_send_correo_boletas_vencidas();

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Correo enviado');
            v_resp = pxp.f_agrega_clave(v_resp,'id_alarma',v_bol_vencidas::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;
	/*********************************
 	#TRANSACCION:  'LG_RBSGAR_INS'
 	#DESCRIPCION:	
 	#AUTOR:		
 	#FECHA:		
	***********************************/

	elsif(p_transaccion='LG_RBSGAR_INS')then
		begin 
          
        --    raise exception 'VALUES %',v_parametros.origen; 	

           select tp.codigo, pm.id_proceso_macro
           into   v_codigo_tipo_proceso, v_id_proceso_macro
           from  wf.tproceso_macro pm, wf.ttipo_proceso tp
           where pm.codigo='BOLGAR' and tp.tabla='leg.tanexo' 
           and tp.estado_reg = 'activo' and tp.inicio = 'si';
           
           select g.id_gestion
           into v_gestion
           from param.tgestion g
           where g.gestion = EXTRACT(YEAR FROM current_date);           

           SELECT
                 ps_num_tramite,
                 ps_id_proceso_wf ,
                 ps_id_estado_wf ,
                 ps_codigo_estado
              into
                 v_nro_tramite,
                 v_id_proceso_wf,
                 v_id_estado_wf,
                 v_codigo_estado

            FROM wf.f_inicia_tramite(
                 p_id_usuario,
                 v_parametros._id_usuario_ai,
                 v_parametros._nombre_usuario_ai,
                 v_gestion,
                 v_codigo_tipo_proceso,
                 p_id_usuario,
                 null,
                 'BOLGAR',
                 'S/N'
            );
                        
           select into v_banco			
           instit.nombre
           from param.tinstitucion instit
           where  (instit.estado_reg='activo'
           and  instit.id_institucion = v_parametros.id_institucion);
              
           select into v_moneda
           mon.codigo_internacional
           from leg.tcontrato con
           inner join param.tmoneda mon on mon.id_moneda = con.id_moneda
           where con.id_contrato = v_parametros.id_contrato;
           
           select ges.id_gestion 
           into v_id_gestion 
           from param.tgestion ges
           where  ges.gestion = date_part('YEAR', now()); 
                                                                       
		insert into leg.tanexo(
			estado_reg,
            fecha_reg,
            id_usuario_reg,
            id_usuario_mod,
            fecha_mod,
            id_contrato,
            id_institucion,
            id_proveedor,
            tipo,
            tipo_boleta,
            banco,
            moneda,
            nro_documento,            
            fecha_desde,
            fecha_hasta,
            monto,
            nro_hoja_ruta,
            origen,            
            id_proceso_wf,
            id_estado_wf           
            )VALUES(
            'activo',
            now(),
            p_id_usuario,
            null,
            null,
            v_parametros.id_contrato,
            v_parametros.id_institucion,
            v_parametros.id_proveedor,
            'boleta_garantia',
            v_parametros.tipo,
			v_banco,
            v_moneda,
            v_parametros.nro_documento,
            v_parametros.fecha_desde,
            v_parametros.fecha_hasta,
            v_parametros.asegurado,
            v_parametros.nro_hoja_ruta,          
            v_parametros.origen,            
		    v_id_proceso_wf,
            v_id_estado_wf
            )RETURNING id_anexo into v_id_anexo;
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Anexo insertado(a) con exito');
            v_resp = pxp.f_agrega_clave(v_resp,'id_anexo',v_id_anexo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;
	/*********************************
 	#TRANSACCION:  'LG_UPBSGAR_MOD'
 	#DESCRIPCION:	
 	#AUTOR:		
 	#FECHA:		
	***********************************/

	elsif(p_transaccion='LG_UPBSGAR_MOD')then
		begin

       if v_parametros.origen not in ('carga','servicio') then               
		update leg.tanexo set
            fecha_fin_uso = v_parametros.fecha_fin_uso,
            nro_hoja_ruta = v_parametros.nro_hoja_ruta,
            nro_documento = v_parametros.nro_documento,
            estado = v_parametros.estado,
            fecha_hasta = v_parametros.fecha_hasta
		 where id_anexo = v_parametros.id_anexo;
         
        update leg.tcontrato set 
			observaciones = v_parametros.observaciones
            where id_contrato =v_parametros.id_contrato;
		else
        --raise exception 'VALUES %',v_parametros.origen;
             select	into v_banco			
              instit.nombre
              from param.tinstitucion instit
              where  (instit.estado_reg='activo'
              and  instit.id_institucion = v_parametros.id_institucion);
                      
		update leg.tanexo set
            id_proveedor = v_parametros.id_proveedor,
        	id_contrato = v_parametros.id_contrato,
            banco = v_banco,
            tipo = v_parametros.tipo,
            nro_documento = v_parametros.nro_documento,
            fecha_desde = v_parametros.fecha_desde,            
            fecha_fin_uso = v_parametros.fecha_fin_uso,
            fecha_hasta = v_parametros.fecha_hasta,
            nro_hoja_ruta = v_parametros.nro_hoja_ruta,
            monto = v_parametros.asegurado
		 where id_anexo = v_parametros.id_anexo;
        end if;         
        
         
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Boleta Garantia  modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_anexo',v_parametros.id_anexo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;  
          
	/*********************************
 	#TRANSACCION:  'LG_DEBSGAR_ELI'
 	#DESCRIPCION:	
 	#AUTOR:		
 	#FECHA:		
	***********************************/

	elsif(p_transaccion='LG_DEBSGAR_ELI')then
		begin         
			--Sentencia de la eliminacion
			delete from leg.tanexo
            where id_anexo = v_parametros.id_anexo;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Boleta Garantia eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_anexo',v_parametros.id_anexo::varchar);

            --Devuelve la respuesta
            return v_resp;   
	  end;
      

    /*********************************
    #TRANSACCION:  'LEG_SIGESBOL_IME'
    #DESCRIPCION:   funcion que controla el cambio al Siguiente estado la boleta garantia
    #AUTOR:         
    #FECHA:         
    ***********************************/   
	elseif(p_transaccion='LEG_SIGESBOL_IME') then

        begin                       
            --Obtención de datos del Estado Actual
            select
                ew.id_tipo_estado,
                te.pedir_obs,
                ew.id_estado_wf
            into
                v_id_tipo_estado,
                v_pedir_obs,
                v_id_estado_wf
            from wf.testado_wf ew
            inner join wf.ttipo_estado te
            on te.id_tipo_estado = ew.id_tipo_estado
            where ew.id_estado_wf = v_parametros.id_estado_wf_act;  
            raise notice '%---%----%',v_id_tipo_estado,v_pedir_obs,v_id_estado_wf;
        end;

	else

    	raise exception 'Transaccion inexistente: %',p_transaccion;

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

ALTER FUNCTION leg.ft_poliza_boleta_ime (p_administrador integer, p_id_usuario integer, p_tabla varchar, p_transaccion varchar)
  OWNER TO postgres;