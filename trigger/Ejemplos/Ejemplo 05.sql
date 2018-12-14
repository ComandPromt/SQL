--Crear un trigger para impedir que, al insertar un empleado, la suma de los salarios de los empleados 
--pertenecientes al departamento del empleado insertado supere los 10.000 euros.

CREATE OR REPLACE TRIGGER sumaDept
   BEFORE INSERT
   ON empleados
   FOR EACH ROW
DECLARE
   suma   INTEGER;
BEGIN
   SELECT   SUM (salario)
     INTO   suma
     FROM   empleados
    WHERE   departamento = :NEW.departamento;

   suma := suma + :NEW.salario;

   IF (suma > 10000)
   THEN
      raise_application_error (-20600,:NEW.departamento || ' La suma de salarios no puede ser superior a 10000');
   END IF;
END;

INSERT INTO empleados (dni, nomemp, jefe, departamento, salario, usuario, fecha) values ('65410020H','Jorge Delgado', '22222222J',2,5900,'jdelgado',to_date('25/05/1998','dd/mm/yyyy'));