--Crear un TRIGGER que no permita actualizar datos (UPDATE) sobre la tabla empleados_baja. Si lo que intenta es 
--hacer un DELETE se hará un insert sobre empleados, simulando que eliminamos la baja y vuelve a estar de alta.

CREATE OR REPLACE TRIGGER "ACTUALIZA_BAJAEMPLEADOS" BEFORE
    UPDATE OR DELETE ON EMPLEADOS_BAJA FOR EACH ROW  
BEGIN 
    IF UPDATING THEN
		raise_application_error(-20600,:old.dni || ' No se permite actualizar un empleado de baja');
	END IF;
	
	IF DELETING THEN
		INSERT INTO empleados
			VALUES (:old.dni,
                    :old.nomemp,
                    :old.jefe,
                    :old.departamento,
                    :old.salario,
                    :old.usuario,
                    :old.fecha);
	END IF;
END;


update empleados_baja set salario = 1000;
delete from empleados_baja;