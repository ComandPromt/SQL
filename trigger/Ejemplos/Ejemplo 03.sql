--Crear un trigger que inserte una fila en la tabla empleados_baja cuando se borre una fila en la tabla empleados. 
--Los datos que se insertan son los del empleado que se da de baja en la tabla empleados, 
--salvo en las columnas usuario y fecha se grabarán las variables del sistema USER y SYSDATE 
--que almacenan el usuario y fecha actual. El comando que dispara el trigger es AFTER DELETE.

CREATE OR REPLACE TRIGGER bajas
   AFTER DELETE
   ON empleados
   FOR EACH ROW
BEGIN
   INSERT INTO empleados_baja
     VALUES   (:old.dni,
               :old.nomemp,
               :old.jefe,
               :old.departamento,
               :old.salario,
               USER,
               SYSDATE);
END;


INSERT INTO empleados (dni, nomemp, jefe, departamento, salario, usuario, fecha) values ('44444444A','Jose Maria Iñigo', null,3,900,'jmiñigo',to_date('22/02/2010','dd/mm/yyyy'));
delete from empleados where usuario = 'jmiñigo';