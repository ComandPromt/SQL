create or replace PROCEDURE ORDEN_DESCENDENTE (maximo NUMBER, minimo number, paso number) AS
  num NUMBER := maximo ;
BEGIN
   WHILE num >= minimo LOOP
    DBMS_OUTPUT.PUT_LINE (num);
    num := num - paso;
  END LOOP;
END ORDEN_DESCENDENTE;
