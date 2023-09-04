-- COMPRAR APLICATIVO --

CREATE OR REPLACE PROCEDURE COMPRAR_APP (NOME_APP VARCHAR2, USERNAME VARCHAR2) IS
PRECO_APP NUMBER;
SALDO NUMBER;
DATA DATE;

BEGIN
    SELECT CURRENT_DATE INTO DATA FROM DUAL;
    SELECT PRECO_ATUAL INTO PRECO_APP FROM APLICATIVO A WHERE A.NOME = NOME_APP;
    SELECT C.SALDO INTO SALDO FROM CONTA C WHERE C.USERNAME = USERNAME;

    IF SALDO >= PRECO_APP THEN
        INSERT INTO COMPRA VALUES (USERNAME, NOME_APP, PRECO_APP, DATA); --ADICIONA NA BIBLIOTECA
        UPDATE CONTA C SET SALDO = (SALDO - PRECO_APP) WHERE C.USERNAME = USERNAME; --ATUALIZA O SALDO
        DBMS_OUTPUT.PUT_LINE('APLICATIVO COMPRADO! ABRE LOGO AÍ!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('SALDO INSUFICIENTE! FAZ O PIX!');
    END IF;
END;

-- EXECUTAR APLICATIVO--

CREATE OR REPLACE PROCEDURE EXECUTAR_APP (COD_USER VARCHAR, USERNAME_LOG VARCHAR, NOME_APP VARCHAR) IS 
    DATA_INICIO DATE;
	A CHAR;
	B CHAR;
BEGIN
    SELECT 
	IF ()
    
   SELECT CASE WHEN COUNT(*) = 0 THEN '0' ELSE '1' END INTO A FROM (SELECT CODIGO FROM COMPRA WHERE CODIGO = NOME_APP AND USERNAME IN 
																	(SELECT USERNAME FROM CONTA WHERE USERNAME IN
																	(SELECT USERNAME FROM TEM_ACESSO WHERE CODIGO = COD_USER)));
	IF (A = '1') THEN
    	SELECT CURRENT_DATE INTO DATA_INICIO
 		FROM DUAL;

		INSERT INTO HISTORICO_EXEC VALUES(COD_USER, USERNAME_LOG, USERNAME_LOG, NOME_APP, DATA_INICIO, NULL);

		UPDATE CONTA
		SET EM_USO = 1
		WHERE USERNAME = USERNAME_LOG;

    	DBMS_OUTPUT.PUT_LINE('Aplicativo está executando.');

	ELSE
    	DBMS_OUTPUT.PUT_LINE('Você não tem acesso à esse aplicativo.');
	END IF;
END;
