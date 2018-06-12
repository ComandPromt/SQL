-- COCHE_USADO (Matricula_Usado, Marca, Modelo, Precio_Tasacion, DNIE)
-- CLIENTE (DNIC, Nombre, Direccion, Tlf)
-- COMPRA (IDC, Matricula_Nuevo, Fecha, Precio_Compra, DNIC, IDV, DNIE)
-- INCLUYE (IDC, IDO, Precio)
-- COCHE_NUEVO (IDV, Marca, Modelo, Motor, Cilindrada, Precio_Base)
-- DISPONIBLE (IDV, IDO, Precio_Opcion)
-- OPCION (IDO, Nombre, Descripcion)
-- EMPLEADO (DNIE, Nombre, Direccion, Tlf, Tipo)
-- VENDEDOR (DNIE)
-- MECANICO (DNIE)
-- REVISA (DNIE, Matricula_Usado, Fecha)
-- ENTREGA (IDC, Matricula_Usado)

-- -----------------------------------------------------------------------------
-- AJUSTES DE SESION
-- -----------------------------------------------------------------------------
ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';


-- -----------------------------------------------------------------------------
-- BORRAR TABLAS ANTIGUAS
-- -----------------------------------------------------------------------------
DROP TABLE COCHE_USADO CASCADE CONSTRAINTS;
DROP TABLE CLIENTE CASCADE CONSTRAINTS;
DROP TABLE COMPRA CASCADE CONSTRAINTS;
DROP TABLE INCLUYE CASCADE CONSTRAINTS;
DROP TABLE COCHE_NUEVO CASCADE CONSTRAINTS;
DROP TABLE DISPONIBLE CASCADE CONSTRAINTS;
DROP TABLE OPCION CASCADE CONSTRAINTS;
DROP TABLE EMPLEADO CASCADE CONSTRAINTS;
DROP TABLE VENDEDOR CASCADE CONSTRAINTS;
DROP TABLE MECANICO CASCADE CONSTRAINTS;
DROP TABLE REVISA CASCADE CONSTRAINTS;
DROP TABLE ENTREGA CASCADE CONSTRAINTS;


-- -----------------------------------------------------------------------------
-- CREAR LAS NUEVAS TABLAS
-- -----------------------------------------------------------------------------

-- EMPLEADO (DNIE, Nombre, Direccion, Tlf, Tipo)
CREATE TABLE EMPLEADO (
	DNIE		CHAR(9) CHECK ( REGEXP_LIKE(DNIE, '^[0-9]{8}[A-Z]$') ),
	Nombre		VARCHAR2(30),
	Direccion	VARCHAR2(50),
    Tlf         NUMBER(9) CHECK ( REGEXP_LIKE(Tlf, '^[679][0-9]{8}$') ),
	Tipo		CHAR(1) CHECK (Tipo IN ('V', 'M')),
	PRIMARY KEY (DNIE)
);


-- VENDEDOR (DNIE)
CREATE TABLE VENDEDOR (
	DNIE		CHAR(9),
	PRIMARY KEY (DNIE),
	CONSTRAINT FK_DNIE FOREIGN KEY (DNIE) REFERENCES EMPLEADO (DNIE) ON DELETE CASCADE
);


-- MECANICO (DNIE)
CREATE TABLE MECANICO (
	DNIE		CHAR(9),
	PRIMARY KEY (DNIE),
	FOREIGN KEY (DNIE) REFERENCES EMPLEADO (DNIE) ON DELETE CASCADE
);


-- COCHE_USADO (Matricula_Usado, Marca, Modelo, Precio_Tasacion, DNIE)
CREATE TABLE COCHE_USADO (
	Matricula_Usado CHAR(7) CHECK ( REGEXP_LIKE(Matricula_Usado, '^[0-9]{4}[A-Z]{3}$') ),
	Marca           VARCHAR2(20),
	Modelo          VARCHAR2(20),
	Precio_Tasacion NUMBER(8,2),
	DNIE            CHAR(9),
	PRIMARY KEY (Matricula_Usado),
	FOREIGN KEY (DNIE) REFERENCES MECANICO (DNIE) ON DELETE CASCADE
);

-- REVISA (DNIE, Matricula_Usado, Fecha)
CREATE TABlE REVISA (
    DNIE                CHAR(9),
    Matricula_Usado     CHAR(7),
    Fecha               DATE,
	PRIMARY KEY (DNIE, Matricula_Usado, Fecha),
	FOREIGN KEY (DNIE) REFERENCES MECANICO (DNIE) ON DELETE CASCADE,
	FOREIGN KEY (Matricula_Usado) REFERENCES COCHE_USADO (Matricula_Usado) ON DELETE CASCADE
);

-- CLIENTE (DNIC, Nombre, Direccion, Tlf)
CREATE TABLE CLIENTE (
    DNIC        CHAR(9) CHECK ( REGEXP_LIKE(DNIC, '^[0-9]{8}[A-Z]$') ),
    Nombre      VARCHAR2(30),
    Direccion   VARCHAR2(50),
    Tlf         NUMBER(9) CHECK ( REGEXP_LIKE(Tlf, '^[679][0-9]{8}$') ),
    PRIMARY KEY (DNIC)
);

-- OPCION (IDO, Nombre, Descripcion)
CREATE TABLE OPCION (
    IDO         INTEGER,
    Nombre      VARCHAR2(20),
    Descripcion VARCHAR2(50),
    PRIMARY KEY (IDO)
);


-- COCHE_NUEVO (IDV, Marca, Modelo, Motor, Cilindrada, Precio_Base)
CREATE TABLE COCHE_NUEVO (
    IDV         INTEGER,
	Marca       VARCHAR2(20),
	Modelo      VARCHAR2(20),
    Motor       CHAR(1) CHECK (Motor IN ('G', 'D', 'E', 'H')),
    Cilindrada  NUMBER(4),
    Precio_Base NUMBER(8,2),
    PRIMARY KEY (IDV)
);

-- DISPONIBLE (IDV, IDO, Precio_Opcion)
CREATE TABLE DISPONIBLE (
    IDV             INTEGER,
    IDO             INTEGER,
    Precio_Opcion   NUMBER(7,2),
    PRIMARY KEY (IDV, IDO),
    FOREIGN KEY (IDV) REFERENCES COCHE_NUEVO (IDV) ON DELETE CASCADE,
    FOREIGN KEY (IDO) REFERENCES OPCION (IDO) ON DELETE CASCADE
);


-- COMPRA (IDC, Matricula_Nuevo, Fecha, Precio_Compra, DNIC, IDV, DNIE)
CREATE TABLE COMPRA (
    IDC             INTEGER,
    Matricula_Nuevo CHAR(7) CHECK ( REGEXP_LIKE(Matricula_Nuevo, '^[0-9]{4}[A-Z]{3}$') ),
    Fecha           DATE,
    Precio_Compra   NUMBER(8,2),
    DNIC            CHAR(9),
    IDV             INTEGER,
    DNIE            CHAR(9),
    PRIMARY KEY (IDC),
    FOREIGN KEY (DNIC) REFERENCES CLIENTE (DNIC) ON DELETE CASCADE,
    FOREIGN KEY (IDV) REFERENCES COCHE_NUEVO (IDV) ON DELETE CASCADE,
    FOREIGN KEY (DNIE) REFERENCES VENDEDOR (DNIE) ON DELETE CASCADE
);


-- ENTREGA (IDC, Matricula_Usado)
CREATE TABLE ENTREGA (
    IDC                 INTEGER, 
    Matricula_Usado     CHAR(7),
    PRIMARY KEY (IDC),
    FOREIGN KEY (IDC) REFERENCES COMPRA (IDC) ON DELETE CASCADE,
    FOREIGN KEY (Matricula_Usado) REFERENCES COCHE_USADO (Matricula_Usado) ON DELETE CASCADE
);


-- INCLUYE (IDC, IDO, Precio)
CREATE TABLE INCLUYE (
    IDC     INTEGER,
    IDO     INTEGER,
    Precio  NUMBER(7,2),
    PRIMARY KEY (IDC, IDO),
    FOREIGN KEY (IDC) REFERENCES COMPRA (IDC) ON DELETE CASCADE,
    FOREIGN KEY (IDO) REFERENCES OPCION (IDO) ON DELETE CASCADE
);


-- -----------------------------------------------------------------------------
-- MODIFICACIONES DE LA ESTRUCTURA DE LAS TABLAS
-- -----------------------------------------------------------------------------

-- Añadir las columnas Apellidos y Nacionalidad a la tabla cliente
ALTER TABLE CLIENTE ADD (
    Apellidos       VARCHAR2(30),
    Nacionalidad    VARCHAR2(15)
);

-- Borrar la columna Nacionalidad de Cliente
ALTER TABLE CLIENTE DROP COLUMN Nacionalidad;


-- Modificar apellidos para que sea no nulo
ALTER TABLE CLIENTE MODIFY (
    Apellidos       CONSTRAINT APELLIDOS_NO_NULO NOT NULL
);

-- Obligar a que nombre y apellidos estén en mayúsculas
ALTER TABLE CLIENTE MODIFY (
    Nombre      CONSTRAINT NOMBRE_MAYUS CHECK (Nombre = UPPER(Nombre)),
    Apellidos   CONSTRAINT APELLIDOS_MAYUS CHECK (Apellidos = UPPER(Apellidos))
);

-- Borrar restricciones
ALTER TABLE CLIENTE DROP CONSTRAINT APELLIDOS_NO_NULO;
ALTER TABLE CLIENTE DROP CONSTRAINT NOMBRE_MAYUS;
ALTER TABLE CLIENTE DROP CONSTRAINT APELLIDOS_MAYUS;

-- Añadir restricción a nivel de tabla
ALTER TABLE VENDEDOR DROP CONSTRAINT FK_DNIE;

ALTER TABLE VENDEDOR ADD CONSTRAINT FK_DNIE
	FOREIGN KEY (DNIE) REFERENCES EMPLEADO (DNIE);

-- Borrar la columna apellidos
ALTER TABLE CLIENTE DROP COLUMN Apellidos;


-- -----------------------------------------------------------------------------
-- INSERCIÓN DE DATOS
-- -----------------------------------------------------------------------------

-- EMPLEADO (DNIE, Nombre, Direccion, Tlf, Tipo)
INSERT INTO EMPLEADO VALUES ('11111111A', 'Pepito Grillo', 'C/ Hoyo', 611000000, 'M');
INSERT INTO EMPLEADO VALUES ('22222222B', 'Manolito Gafotas', 'C/ Charca', 622000000, 'M');
INSERT INTO EMPLEADO VALUES ('33333333C', 'Mauricio Colmenero', 'C/ Ancha', 633000000, 'V');

-- VENDEDOR (DNIE)
INSERT INTO VENDEDOR VALUES ('33333333C');

-- MECANICO (DNIE)
INSERT INTO MECANICO VALUES ('11111111A');
INSERT INTO MECANICO VALUES ('22222222B');


-- COCHE_USADO (Matricula_Usado, Marca, Modelo, Precio_Tasacion, DNIE)
INSERT INTO COCHE_USADO VALUES ('1000AAA', 'SEAT', 'PANDA', 1000, '11111111A');
INSERT INTO COCHE_USADO VALUES ('2000BBB', 'RENAULT', 'R5 COPA TURBO', 2000, '22222222B');
INSERT INTO COCHE_USADO VALUES ('3000CCC', 'LAMBORGHINI', 'GALLARDO', 30000, '11111111A');


-- REVISA (DNIE, Matricula_Usado, Fecha)
INSERT INTO REVISA VALUES ('11111111A', '3000CCC', '01/02/2018');
INSERT INTO REVISA VALUES ('22222222B', '1000AAA', '01/02/2018');


-- CLIENTE (DNIC, Nombre, Direccion, Tlf)
INSERT INTO CLIENTE VALUES ('44444444D', 'Cristiano Romualdo', 'C/ Penalty', '744000000');
INSERT INTO CLIENTE VALUES ('55555555E', 'Mister Handsome', 'C/ Moncloa', '755000000');
INSERT INTO CLIENTE VALUES ('66666666F', 'Antonio Negro', 'C/ Tomas Bevia', '766000000');


-- COCHE_NUEVO (IDV, Marca, Modelo, Motor, Cilindrada, Precio_Base)
INSERT INTO COCHE_NUEVO VALUES (1, 'TOYOTA', 'COROLLA', 'D', 1800, 15999.99);
INSERT INTO COCHE_NUEVO VALUES (2, 'FERRARI', 'TESTARROSA', 'G', 4800, 150000);

-- OPCION (IDO, Nombre, Descripcion)
INSERT INTO OPCION VALUES (1, 'Elevalunas', 'Elevalunas eléctrico en las 4 ventanillas');
INSERT INTO OPCION VALUES (2, 'LED', 'Faros y luces indicadoras de LED');

-- DISPONIBLE (IDV, IDO, Precio_Opcion)
INSERT INTO DISPONIBLE VALUES (1, 1, 300);
INSERT INTO DISPONIBLE VALUES (2, 1, 1300);
INSERT INTO DISPONIBLE VALUES (2, 2, 2400);

-- COMPRA (IDC, Matricula_Nuevo, Fecha, Precio_Compra, DNIC, IDV, DNIE)
INSERT INTO COMPRA VALUES (1000, '5000AAA', '10/01/2018', 153700, '44444444D', 2, '33333333C');
INSERT INTO COMPRA VALUES (2000, '6000BBB', '20/02/2018', 16299.99, '66666666F', 1, '33333333C');


-- INCLUYE (IDC, IDO, Precio)
INSERT INTO INCLUYE VALUES (1000, 1, 1200);
INSERT INTO INCLUYE VALUES (1000, 2, 2400);


-- ENTREGA (IDC, Matricula_Usado)
INSERT INTO ENTREGA VALUES (1000, '3000CCC');
INSERT INTO ENTREGA VALUES (2000, '1000AAA');


-- -----------------------------------------------------------------------------
-- MODIFICACIÓN DE DATOS
-- -----------------------------------------------------------------------------

-- Corregir el nombre Cristiano
UPDATE CLIENTE SET Nombre = 'Cristiano Ronaldo', Direccion = 'C/ Portugal'
WHERE DNIC = '44444444D';

-- Subir un 21 porciento el precio base de todos TOYOTA
UPDATE COCHE_NUEVO SET Precio_Base = Precio_Base*1.21
WHERE MARCA='TOYOTA';

-- Borrar a Manolito Gafotas
DELETE FROM EMPLEADO
WHERE DNIE = '22222222B';
