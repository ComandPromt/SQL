# Precidimiento para recorrer una tabla

~~~sql
SET SERVEROUTPUT ON;

DECLARE

    CURSOR MI_CURSOR IS
        SELECT C.NOMBRE,N.MARCA,N.MODELO,O.FECHA 
        FROM CLIENTE C, COMPRA O, Coche_Nuevo N
        WHERE C.DNIC=O.DNIC AND O.IDV=N.IDV;

BEGIN
    DBMS_OUTPUT.PUT_LINE('<table border="3">');
    FOR vReg IN MI_CURSOR LOOP
    DBMS_OUTPUT.PUT_LINE('<tr>');
         DBMS_OUTPUT.PUT_LINE('<td>'||vReg.Nombre|| '</td><td>' || vReg.Marca||'</td><td>'||vReg.Modelo||'</td><td>'||vReg.Fecha||'</td>');
    DBMS_OUTPUT.PUT_LINE('</tr>');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('</table>');
END;
/
~~~

# CURSOR EXPLICITO
~~~SQL
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE NUEVO_CLIENTE(
	vDNIC VARCHAR2,
	vNombre VARCHAR2,
	vDireccion VARCHAR2,
	vTLF NUMBER
) AS
BEGIN
DBMS_OUTPUT.PUT_LINE('Insertando cliente...');
DBMS_OUTPUT.PUT_LINE('');
	INSERT INTO CLIENTE VALUES(vDNIC,vNombre,vDireccion,vTLF);

EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
DBMS_OUTPUT.PUT_LINE('El cliente '|| vNombre||' ya a sido insertado');

END;
/

exec NUEVO_CLIENTE('12564778A','Andres Blanco','C\Cuervo','958741254');
~~~
