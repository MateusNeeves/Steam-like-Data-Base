-----------------------
--CRIACAO DAS TABELAS--
-----------------------

-- CRIA TABELA USUARIO
CREATE TABLE USUARIO(
    CODIGO VARCHAR2(50),
    CONSTRAINT PK_USUARIO PRIMARY KEY (CODIGO)
);

-- CRIA TABELA CONTA
CREATE TABLE CONTA(
    USERNAME VARCHAR2(50),
    SENHA VARCHAR2(50),
    SALDO NUMBER(7,2),
    LOC_PAIS VARCHAR2(50),
    LOC_ESTADO VARCHAR2(50),
    LOC_CIDADE VARCHAR2(50),
    EM_USO NUMBER(1),
    USERNAME_REDE VARCHAR2(50),
    CONSTRAINT PK_CONTA PRIMARY KEY (USERNAME),
    CONSTRAINT FK_CONTA_REDE UNIQUE (USERNAME_REDE),
    CONSTRAINT BOOLEAN CHECK (EM_USO IN (0, 1)),
    CONSTRAINT SENHA_NOT_NULL CHECK (SENHA IS NOT NULL)
);


-- CRIA TABELA TEM_ACESSO
CREATE TABLE TEM_ACESSO(
    USERNAME VARCHAR2(50),
    CODIGO VARCHAR2(50),
    CONSTRAINT PK_ACESSO PRIMARY KEY (USERNAME, CODIGO),
    CONSTRAINT FK_USUARIO_ACESSO FOREIGN KEY (CODIGO) REFERENCES USUARIO,
    CONSTRAINT FK_CONTA_ACESSO FOREIGN KEY (USERNAME) REFERENCES CONTA
);

-- CRIA TABELA AMIGO
CREATE TABLE AMIGO(
    USERNAME1 VARCHAR2(50),
    USERNAME2 VARCHAR2(50),
    DATA_AMIZADE DATE,
    CONSTRAINT PK_AMIGO PRIMARY KEY (USERNAME1, USERNAME2),
    CONSTRAINT FK_CONTA_AMIGO1 FOREIGN KEY (USERNAME1) REFERENCES CONTA,
    CONSTRAINT FK_CONTA_AMIGO2 FOREIGN KEY (USERNAME2) REFERENCES CONTA
);

-- CRIA TABELA EMPRESA
CREATE TABLE EMPRESA(
    CNPJ VARCHAR2(50),
    NOME VARCHAR2(50),
    CONSTRAINT PK_EMPRESA PRIMARY KEY (CNPJ),
    CONSTRAINT NOME_NOT_NULL_TABELA CHECK (NOME IS NOT NULL)
);

-- CRIA TABELA APLICATIVO
CREATE TABLE APLICATIVO(
    NOME VARCHAR2(50),
    PRECO_ATUAL NUMBER(7,2),
    DATA_LANCAMENTO DATE,
    CNPJ VARCHAR2(50),
    TIPO VARCHAR2(50),
    CONSTRAINT PK_APLICATIVO PRIMARY KEY (NOME),
    CONSTRAINT FK_APLICATIVO_EMPRESA FOREIGN KEY (CNPJ) REFERENCES EMPRESA,
    CONSTRAINT TIPO_HERANCA CHECK (TIPO IN ('JOGO', 'SOFTWARE')),
    CONSTRAINT PRECO_NOT_NULL CHECK (PRECO_ATUAL IS NOT NULL),
    CONSTRAINT DATA_NOT_NULL CHECK (DATA_LANCAMENTO IS NOT NULL),
    CONSTRAINT CNPJ_NOT_NULL CHECK (CNPJ IS NOT NULL)
);

-- CRIA TABELA CATEGORIA
CREATE TABLE CATEGORIA(
    NOME VARCHAR2(50),
    CATEG VARCHAR2(50),
    CONSTRAINT PK_CATEGORIA PRIMARY KEY (NOME, CATEG),
    CONSTRAINT FK_APLICATIVO_CATEGORIA FOREIGN KEY (NOME) REFERENCES APLICATIVO
);

-- CRIA TABELA CONQUISTA
CREATE TABLE CONQUISTA(
    NOME_JOGO VARCHAR2(50),
    NOME_CONQUISTA VARCHAR2(50),
    DESCRICAO VARCHAR2(200),
    RARIDADE VARCHAR2(50),
    CONSTRAINT PK_CONQUISTA PRIMARY KEY (NOME_JOGO, NOME_CONQUISTA),
    CONSTRAINT FK_CONQUISTA_APP FOREIGN KEY (NOME_JOGO) REFERENCES APLICATIVO,
    CONSTRAINT DESCRICAO_NOT_NULL CHECK (DESCRICAO IS NOT NULL),
    CONSTRAINT RARIDADE_NOT_NULL CHECK (RARIDADE IS NOT NULL)
);

-- CRIA TABELA COMPRA
CREATE TABLE COMPRA(
    USERNAME VARCHAR2(50),
    NOME VARCHAR2(50),
    PRECO_COMPRA NUMBER(7,2),
    DATA_COMPRA DATE,
    CONSTRAINT PK_COMPRA PRIMARY KEY (USERNAME, NOME),
    CONSTRAINT FK_COMPRA_CONTA FOREIGN KEY (USERNAME) REFERENCES CONTA,
    CONSTRAINT FK_COMPRA_APLICATIVO FOREIGN KEY (NOME) REFERENCES APLICATIVO,
    CONSTRAINT PRECO_COMPRA_NOT_NULL CHECK (PRECO_COMPRA IS NOT NULL),
    CONSTRAINT DATA_COMPRA_NOT_NULL CHECK (DATA_COMPRA IS NOT NULL)
);

-- CRIA TABELA GANHAR CONQUISTA
CREATE TABLE GANHAR_CONQ(
    NOME_JOGO VARCHAR2(50),
    NOME_CONQUISTA VARCHAR2(50),
    USERNAME VARCHAR2(50),
    DATA_CONQ DATE,
    CONSTRAINT PK_GANHAR PRIMARY KEY (NOME_JOGO, NOME_CONQUISTA, USERNAME),
    CONSTRAINT FK_GANHAR_COMPRA FOREIGN KEY (USERNAME, NOME_JOGO) REFERENCES COMPRA,
    CONSTRAINT FK_GANHAR_CONQUISTA FOREIGN KEY (NOME_JOGO, NOME_CONQUISTA) REFERENCES CONQUISTA,
    CONSTRAINT DATA_CONQ_NOT_NULL CHECK (DATA_CONQ IS NOT NULL)
);

-- CRIA TABELA HISTORICO_EXEC
CREATE TABLE HISTORICO_EXEC(
    CODIGO_USUARIO VARCHAR2(50),
    USERNAME VARCHAR2(50),
    NOME_APP VARCHAR2(50),
    INICIO DATE,
    FIM DATE,
    CONSTRAINT PK_HISTORICO PRIMARY KEY (CODIGO_USUARIO, USERNAME, NOME_APP, INICIO),
    CONSTRAINT FK_HISTORICO_USUARIO FOREIGN KEY (CODIGO_USUARIO) REFERENCES USUARIO,
    CONSTRAINT FK_HISTORICO_LOGADO FOREIGN KEY (USERNAME) REFERENCES CONTA,
    CONSTRAINT FK_HISTORICO_APLICATIVO FOREIGN KEY (NOME_APP) REFERENCES APLICATIVO
);
