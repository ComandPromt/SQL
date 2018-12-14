--Hacer un TRIGGER que llame a la función validaciones y si dicha función devuelve error lanzar la excepción

CREATE OR REPLACE FUNCTION validaciones (nombre VARCHAR2,salario NUMBER) RETURN VARCHAR2 AS 
  texto VARCHAR2(50):='';
BEGIN
  IF nombre IS NULL THEN
	  texto := 'nombre no puede ser NULL';
  END IF;
  IF salario IS NULL THEN
	  texto := nombre || ' no puede tener un salario NULL';
  END IF;
  IF salario < 0 THEN
	  texto := nombre || ' no puede tener un salario negativo';
  END IF;
  RETURN texto;
END;

CREATE OR REPLACE TRIGGER "TRIGGER_VALIDACIONES" BEFORE
    INSERT OR UPDATE ON EMPLEADOS FOR EACH ROW  
DECLARE
	mensaje VARCHAR2(50):='';
BEGIN 
    
	mensaje := validaciones (:new.nomemp,:new.salario);
	if mensaje = '' then
		dbms_output.put_line ('validación correcta');
	else
		raise_application_error(-20600,mensaje);
	end if;
END;

INSERT INTO empleados (dni, nomemp, jefe, departamento, salario, usuario, fecha) values ('46666911Y',null, null,3,900,'mmoreno',to_date('14/03/2001','dd/mm/yyyy'));

INSERT INTO empleados (dni, nomemp, jefe, departamento, salario, usuario, fecha) values ('46666911Y','prueba', null,3,null,'mmoreno',to_date('14/03/2001','dd/mm/yyyy'));

INSERT INTO empleados (dni, nomemp, jefe, departamento, salario, usuario, fecha) values ('46666911Y','prueba', null,3,-900,'mmoreno',to_date('14/03/2001','dd/mm/yyyy'));