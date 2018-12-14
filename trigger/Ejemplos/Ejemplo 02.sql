--Crear un trigger para impedir que se aumente el salario de un empleado en más de un 20%. 
--Es necesario comparar los valores :old.salario y :new.salario cada vez que se modifica 
--el atributo salario (BEFORE UPDATE).
--IF :NEW.salario > :OLD.salario*1.20 THEN raise… 

CREATE OR REPLACE TRIGGER aumentoSalario
   BEFORE UPDATE OF salario ON empleados FOR EACH ROW
BEGIN
   IF :NEW.salario > :OLD.salario * 1.20 THEN
      raise_application_error (-20600,:new.Salario || ' no se puede aumentar el salario más de un 20%');
   END IF;
END;

--ejemplo de uso
update empleados set salario = 1500 where usuario = 'vmurillo';