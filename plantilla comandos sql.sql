--Repaso examen Gbd 2 evaluacion

--EN Primer lugar craremos las tablas con los comandos 
CREATE TABLE EJEMPLO(
Cod_Ejem	VARCHAR (10),
nom_ejem	VARCHAR (10),
fecha_ejem	DATE, 
Num_ejem	NUMBER(5),
Horas		DAtE,
CONSTRAINT PK_EJEMPLO PRIMARY KEY (Cod_Ejem)
); 

CREATE TABLE RESUMEN(
Cod_Re		VARCHAR (10),
nom_Re		VARCHAR (10),
fecha_re	DATE, 
Color		VARCHAR (7),
Num_re		NUMBER(5),
Cod_Ejem	VARCHAR (10),
CONSTRAINT PK_RESUMEN PRIMARY KEY (Cod_Re)
CONSTRAINT FK1_RESUMEN FOREIGN KEY (Cod_Ejem)
		REFERENCES EJEMPLO (Cod_Ejem)
); 

CREATE TABLE PERSONA (
Cod_Per		VARCHAR (10),
nom_Per		VARCHAR (10),
fecha_re	DATE, 
Num_re		NUMBER(5),
DNI 		VARCHAR (9),
Cod_Ejem	VARCHAR (10),
CONSTRAINT PK_PERSONA PRIMARY KEY (Cod_Per)
CONSTRAINT FK1_PERSONA FOREIGN KEY (Cod_Ejem)
		REFERENCES EJEMPLO (Cod_Ejem)
); 

CREATE TABLE RES_EJEM(
Cod_Re		VARCHAR (10),
Cod_Ejem	VARCHAR (10),	
cantidad	NUMBER(5),
CONSTRAINT PK_RES_EJEM PRIMARY KEY (Cod_Re, Cod_Ejem, cantidad),
CONSTRAINT FK1_RES_EJEM FOREIGN KEY (Cod_Ejem)
		REFERENCES EJEMPLO (Cod_Ejem),
CONSTRAINT FK1_RES_EJEM FOREIGN KEY (Cod_Ejem)
		REFERENCES EJEMPLO (Cod_Ejem)
); 

----------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------
--para modificar las tabalas atributos utilizaremos el el campo modify.
ALTER TABLE EJEMPLO MODIFY fecha_ejem VARCHAR (15);

ALTER TABLE RESUMEN MODIFY Num_re NUMBEr (4,2); --en este caso lo pongo la comapara indicar el numro de decimales. 
												--El nuero maximo seria 99 y dos decimales.

------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------
--para eliminar una tabla utilizareos el comando drop.
 DROP TABLE RESUMEN;
 
 --para borrar una columna se utilizara el drop colum.
 alter table EJEMPLO
 drop column horas;
 																							
----------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------
--Para craer una columnda e introcduir un atribuo nuevo se hara con add column
ALTER TABLE EJEMPLO
ADD COLUMN HORAS (DATE);
----------------------------------------------------------------------------------------------------------------------------------------------------------
--Para crear restricciones utilizaremso el comnado add constraint y para eliminarla el drop constraint.
ALTER TABLE RESUMEN
ADD CONSTRAINT CK1_RESUMEN check (to char (fecha_re, 'MMDD')<= 1225);

ALTER TABLE RESUMEN
 DROP CONSTRAINT CK1_RESUMEN;
 
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------
--AHORA REALIZAREMOS VARIAS RESTRICCIONES.
-------------------------------------------------------------------------------------------------------------------------------------------------------------
--El DNI de la persona tiene que tener 8 digitos y una letra. Utilizaremos el Chek(REGEXP_LIKE(atibuto,'[][]')).
ALTER TABLE PERSONA
 ADD CONSTRAINT CK1_PERSONA CHECK (REGEXP_LIKE(DNI,'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Za-z]'));
 
 --SI fuese por ejemplo una matricula seria 
 ALTER TABLE COCHE
 ADD CONSTRAINT CK1_COCHE CHECK (REGEXP_LIKE(MATRICULA,'[0-9][0-9][0-9][0-9][A-Za-z][A-Za-z][A-Za-z]'));
 
 --EL Cod_Per de la tabla persona tiene que empesar por E
alter table PERSONA
	Add CONSTRAINT CK2_PERSONA CHECK (REGEXP_LIKE (Cod_Per, 'E'));
	
--EL nombre de persona tiene que empesar por NOM un numero de tres cifras y el año actual.
ALTER TABLE PERSONA
	ADD CONSTRAINT CK3_PERSONA CHECK (REGEXP_LIKE (nom_Per, 'NOM [0-9][0-9]0-9] [2000-2030]' ));
 
-------------------------------------------------------------------------------------------------------------------------------------------------------------- 
--Para expresar que el color solo puede ser amarillo rojo o azul utilizareos elcomando atributo IN('','','') y lo que nos deja es una de las opciones.
Alter table RESUMEN
	ADD CONSTRAINT CK1_RESUMEN CHECK (Color IN('amarillo', 'rojo', 'azul'));
 
 --Si gfuese la posicion de lo sjugadores por ejemplo:
 Alter table JUGADORES
	ADD CONSTRAINT CK1_JUGADORES CHECK (Posición IN('PORTERO', 'DEFENSA', 'CENTROCAMPISTA', 'DELANTERO'));
	
---------------------------------------------------------------------------------------------------------------------------------------------------------------
--Para indica que una hora no puede ser mas de 10 por ejemplo :
--UTILIZAREMOS EL CHECK (Atributo<x)
Alter table EJEMPLO
	ADD CONSTRAINT CK1_EJEMPLO CHECK (Horas<=10 );

----------------------------------------------------------------------------------------------------------------------------------------------------------------	
--Para indicar que una fecha de fundacion de un equipo utilizareiamos to_char; 
--To char indica que cambia los valores introducidos a lo que nosotors dispongamos 
ALTER TABLE EQUIPOS 
 ADD CONSTRAINT CK1_EQUIPOS CHECK (TO_CHAR (Fech_Fun, 'yyyy')>1890);
 
 --tambien para indicar que un partido o algo puede estar indicado entre una hora o un dia o mes etc.
 ALTER TABLE PARTIDOS  
ADD CONSTRAINT CK2_PARTIDOS CHECK (TO_CHAR (Fecha,'HH24')>=12 AND TO_CHAR (Fecha,'HH24')<=22);
--EN este caso el and significa que tiene que ocurrir un to_char y el otro to_char.

--2 No hay partidos en verano (desde el 21/06 al 21/09)
ALTER TABLE PARTIDOS  
ADD CONSTRAINT CK1_PARTIDOS CHECK ( TO_CHAR (Fecha,'MMDD')<0621 OR TO_CHAR (Fecha,'MMDD')>0921);
--en este caso el or significa que o se cumple un to_char o se cumple el otro to_char.

---------------------------------------------------------------------------------------------------------------------------------------------------------------
--5 Los jugadores han de tener como mínimo 16 años en el momento en que se dan de alta en la base de datos.
ALTER TABLE JUGADORES ADD Fech_Alta DATE;

ALTER TABLE JUGADORES  
ADD CONSTRAINT CK2_JUGADORES CHECK ( (Fech_Alta - Fech_Nac) >=5844); --los años siempre van  a ser expresado en dias.
--E este caso tendriamso que cear un campo con el ALTER TABLE JUGADORES ADD Fech_Alta DATE; para poder expresar la resta 

---------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------
--Ahora modificaremos las tablas para que no tengan valores nulo o tengan un valor definido.

--Para que el campo elejido tenga por defecto un numero o una letra utilizaremos default
ALTER TABLE EJEMPLO MODIFY Num_ejem DEFAULT 0;

--Si ahora queremos poner un campo en que no pueda ser 0 o valor nulo tenemos que poner not null.
ALTER TABLE EJEMPLO MODIFY HORAS NOT NULL;

------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
--Ahora introduciremos datos en las tablas con los siguentes comandos INSER INTO y VALUES.
BEGIN
	INSERT INTO PRESIDENTES (DNI_P,Nom_P,Apellidos,Fech_Elec,Fech_Nac)
		VALUES ('12345678L','Florentino','PEREZ AGUILAR','19/08/1999','30/12/1952');
	INSERT INTO PRESIDENTES (DNI_P,Nom_P,Apellidos,Fech_Elec,Fech_Nac)
		VALUES ('47896523P','Juse','MARIA BARTOMEU','14/06/1996','05/06/1960');
	INSERT INTO PRESIDENTES (DNI_P,Nom_P,Apellidos,Fech_Elec,Fech_Nac)
		VALUES ('72681349T','Nasser','Al-Khelaïfi','12/02/1990','12/02/1974');
END;

BEGIN
	INSERT INTO EQUIPOS (Cod_E,Nom_E, Estadio, Aforo,DNI_P, NumTitulos, Fech_Fun )
		VALUES ('E1', 'MADRID', 'SANTIAGO BERNABEU', 80000, '12345678L', 68, '01/01/1902');
	INSERT INTO EQUIPOS (Cod_E,Nom_E, Estadio, Aforo,DNI_P, NumTitulos, Fech_Fun )
		VALUES ('E2', 'BARCELONA', 'CAMP NOU', 920000,'47896523P',45,'02/02/1904');
	INSERT INTO EQUIPOS (Cod_E,Nom_E, Estadio, Aforo,DNI_P, NumTitulos, Fech_Fun )
		VALUES ('E3', 'PSG', 'PARQUE DE LOS PRINCIPES', 64000,'72681349T', 30, '05/05/1945');
	
END;
--Hay que tener en cuanta que los valores introducidos deben cumplir con las restricciones. Si falla alguno de los campos
--podemos meternlos uno a uno sin el begin ni el end.

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- de la siguiente forma se podra modificar datos insertados con el update , set y where. UPDATE TABLA SET ATRIBUTONUEVO='' WHERE ARIBUTOVIEJEO='';
--e) Modifica, al menos, dos filas de las insertadas en la/s tabla/s que elijas.
UPDATE PRESIDENTES 
SET Nom_P='PEPE' WHERE Nom_P='Florentino';

UPDATE EQUIPOS 
SET Aforo='85000' WHERE Aforo='80000';

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------
--para borrar datos utilizaremos los sigueintes comandos sabiendo que al borrar un dato se borrara toda la fila. DELETE FROM  WHERE Atributo='';
--los datos que esten relacionados en tora tabla no podran ser borrados.
--f) Borra dos filas de las insertadas en la/s tabla/s que elijas.

DELETE FROM MARCA_GOLES 
	WHERE Descrip='Gol de penalti';
	
DELETE FROM PARTIDOS 
	WHERE Cod_P='P1';
	

------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
--La utilizacion del TO_DATE que nos permite introducir fecha y hora. a continuacion se mostrara un ejemplo.
BEGIN
	INSERT INTO PARTIDOS (Cod_P ,Fecha,Cod_E_Local ,Cod_E_Visit)
		VALUES ('P1',TO_DATE('09/02/2016 12:30:00', 'DD/MM/YYYY HH24:MI:SS'),'E1','E2' );
	INSERT INTO PARTIDOS (Cod_P ,Fecha,Cod_E_Local ,Cod_E_Visit)
		VALUES ('P2',TO_DATE('10/02/2016 14:30:00', 'DD/MM/YYYY HH24:MI:SS'),'E1','E3');
	INSERT INTO partidos (Cod_P ,Fecha,Cod_E_Local ,Cod_E_Visit)
		VALUES ('P3',TO_DATE('11/02/2016 20:30:00', 'DD/MM/YYYY HH24:MI:SS'),'E2','E3');
END;