--Crear un trigger para impedir que, al insertar un empleado, el empleado y su jefe puedan pertenecer 
--a departamentos distintos

CREATE OR REPLACE TRIGGER MISMO_DEP
   BEFORE INSERT
   ON EMPLEADOS
   FOR EACH ROW
DECLARE
   dept_jefe   INTEGER;
BEGIN
   IF (:NEW.jefe IS NOT NULL)
   THEN
      SELECT   departamento
        INTO   dept_jefe
        FROM   empleados
       WHERE   dni = :NEW.jefe;

      IF (dept_jefe <> :NEW.departamento)
      THEN
         raise_application_error (-20600,:NEW.departamento|| ' Un empleado y su jefe no pueden pertenecer a departamentos diferentes');
      END IF;
   END IF;
END;

INSERT INTO empleados (dni, nomemp, jefe, departamento, salario, usuario, fecha) values ('45214983P','Irene Colmenar', '22222222J',1,750,'icolmenar',to_date('31/03/2002','dd/mm/yyyy'));