CREATE OR REPLACE TRIGGER "CONTROLUSUARIO" BEFORE
    UPDATE OR INSERT ON EMPLEADOS FOR EACH ROW  
BEGIN 
	:new.usuario := lower(:new.usuario);
END;

INSERT INTO empleados (dni, nomemp, jefe, departamento, salario, usuario, fecha) 
values ('56898963Y','Sofia Gutierrez', null,3,1100,'Sgutierrez',to_date('13/04/2009','dd/mm/yyyy'));