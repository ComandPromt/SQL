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
