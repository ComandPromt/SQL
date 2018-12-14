--Crear un trigger sobre la tabla EMPLEADOS para que no se permita que un empleado sea jefe de más de cinco empleados

CREATE OR REPLACE TRIGGER jefes BEFORE 
	INSERT ON empleados FOR EACH ROW
DECLARE            
	supervisa INTEGER;
BEGIN
      SELECT count(*) INTO supervisa
		FROM empleados
		WHERE jefe = :new.jefe;
      
    IF (supervisa > 4) THEN           
      raise_application_error (-20600,:new.jefe|| ' no se puede supervisar más de 5'); 
    END IF;
END;


--ejemplo de uso
INSERT INTO empleados (dni, nomemp, jefe, departamento, salario, usuario, fecha) 
values ('78955421H','Gonzalo Marquez', '22222222J',2,1400,'gmarquez',to_date('06/10/2012','dd/mm/yyyy'));