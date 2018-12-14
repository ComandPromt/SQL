create or replace function compruebaDNI(numDni VARCHAR2) RETURN VARCHAR2 IS
  numero NUMBER:=23;
  resultado VARCHAR2(50);
BEGIN
   resultado := numDni||SUBSTR('TRWAGMYFPDXBNJZSQVHLCKET',MOD(numDni,numero)+1,1);
   RETURN resultado;
END;

--Crear un TRIGGER que compruebe antes de insertar o actualizar que el dni tiene la letra correcta

CREATE OR REPLACE TRIGGER "LETRADNI" BEFORE
    UPDATE OR INSERT ON EMPLEADOS FOR EACH ROW  
BEGIN 
	if :new.dni <> compruebaDNI(to_number(SUBSTR(:new.dni,1,8))) THEN
		raise_application_error(-20600,:new.dni || ' La letra del DNI no es correcta');
	END IF;
END;

INSERT INTO empleados (dni, nomemp, jefe, departamento, salario, usuario, fecha) 
values ('14320095P','Germán Delgado', null,3,1100,'gdelgado',to_date('25/11/2000','dd/mm/yyyy'));