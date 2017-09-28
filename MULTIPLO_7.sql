create or replace PROCEDURE MULTIPLO_7 (mul NUMBER) AS
multiplo NUMBER;
BEGIN
multiplo:=MOD(mul,7);
if multiplo=0
then
DBMS_OUTPUT.PUT_LINE('El numero '|| mul ||' ES multiplo de 7');
else
DBMS_OUTPUT.PUT_LINE('El numero '|| mul ||' NO es multiplo de 7');
end if;
END MULTIPLO_7;
