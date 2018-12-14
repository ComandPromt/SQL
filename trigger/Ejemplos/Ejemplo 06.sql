--Visualizar los trigger definidos sobre una tabla consultando la vista ALL_TRIGGERS. 
DESC ALL_TRIGGERS;
SELECT trigger_name, status FROM ALL_TRIGGERS WHERE table_name = 'EMPLEADOS'; 

--Desactivar (DISABLE) y activar (ENABLE) los trigger definidos sobre una tabla: 
ALTER TABLE empleados DISABLE ALL TRIGGERS; 

--Activar y desactivar un trigger especifico: 
ALTER TRIGGER jefes ENABLE; 

--Ver la descripción de un trigger: 
SELECT description FROM USER_TRIGGERS WHERE trigger_name = 'JEFES'; 

--Ver el cuerpo de un trigger: 
SELECT trigger_body FROM USER_TRIGGERS WHERE trigger_name = 'JEFES';