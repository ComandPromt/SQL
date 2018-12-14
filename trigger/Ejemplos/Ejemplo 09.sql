--El jefe del Departamento 1 decide premiar a sus trabajadores con subida de salario de 3% por año a aquellos 
--que lleven más de 5 años en la empresa. Crear TRIGGER para actualizar salario al insertar el empleado 
--en la base de datos.

CREATE OR REPLACE TRIGGER "ACTUALIZA3%" BEFORE
    INSERT ON EMPLEADOS FOR EACH ROW  
DECLARE
    AnioActual NUMBER(4);
    AnioEmp NUMBER(4);
    Porcentaje NUMBER(3);
BEGIN 
    AnioActual:=EXTRACT(YEAR FROM SYSDATE);
    AnioEmp:= EXTRACT(YEAR FROM :new.fecha);
    if (AnioActual - AnioEmp) >5 THEN
        Porcentaje:= (AnioActual - AnioEmp) * 3;
        :new.salario := :new.salario * (1 + Porcentaje/100);
    END IF;
END;


INSERT INTO empleados (dni, nomemp, jefe, departamento, salario, usuario, fecha) values ('69887847T','Ramón Fuentes', null,3,1000,'rfuentes',to_date('14/03/2008','dd/mm/yyyy'));