# Cambiar contraseña root MySQL
~~~bash
sudo mysql -u root
~~~
~~~sql
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY
'contraseña'; 
~~~

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

# Cursor Explicito
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

# Cursor implicito
~~~sql
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE INSERTAR_COCHE(
	vMarca VARCHAR2,
	vModelo VARCHAR2,
	vMOTOR CHAR,
	vCILINDRADA NUMBER,
    vPRECIO_BASE NUMBER
) AS
vIDV COCHE_NUEVO.IDV%TYPE;
BEGIN
SELECT MAX(IDV)+1 INTO vIDV FROM COCHE_NUEVO;

	IF vIDV IS NULL THEN
    vIDV:=1;
    END IF;
    INSERT INTO COCHE_NUEVO VALUES(vIDV,vMarca,vModelo,vMotor,vCilindrada,vPrecio_Base);
    
END;
/

exec INSERTAR_COCHE('SEAT','LEON','G',1600,15000);
~~~

# Borrar los 5 ultimos registros (MySQL)
- Cambia 5 por el numero que quieras
~~~sql
DELETE FROM table WHERE id=3 ORDER BY id DESC LIMIT 5;
~~~

# Consulta duplicados (MySQL)
~~~sql
SELECT name, COUNT(*) Total
FROM table
GROUP BY name
HAVING COUNT(*) > 1;
~~~

# Desbloquear al usuario SYSTEM
~~~sql
ALTER USER SYSTEM ACCOUNT UNLOCK;
~~~

