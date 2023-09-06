-- QUANTIDADE DE CONQUISTAS PLATINA POR CONTA QUE TENHAM MAIS QUE A MEDIA (GROUP BY HAVING)--
SELECT G.USERNAME_LOGADO, COUNT(*) AS QTD
FROM GANHAR G
WHERE (G.NOME_APP, G.NOME_CONQUISTA) IN (SELECT C.NOME_APP, C.NOME_CONQUISTA FROM CONQUISTA C WHERE C.RARIDADE = 'PLATINA')
GROUP BY G.USERNAME_LOGADO
HAVING QTD > AVG(QTD);

-- USERNAMES E JOGOS JOGADOS A PARTIR DE 05/09/2023 EM RECIFE (INNER JOIN) --
SELECT USERNAME_LOGADO, NOME_APP
FROM CONTA INNER JOIN HISTORICO_EXEC ON (USERNAME = USERNAME_LOGADO)
WHERE FIM > TO_DATE('05/09/2023', 'DD/MM/YYYY HH24:MI:SS') AND CIDADE = 'RECIFE';

-- USERNAMES E JOGOS COMPRADOS (NULL SE NÃO HOUVER JOGOS) (OUTER JOIN)--
SELECT CO.USERNAME AS USERNAME, A.NOME AS JOGO
FROM CONTA CON LEFT OUTER JOIN COMPRAR C ON (CON.USERNAME = C.USERNAME) INNER JOIN APLICATIVO A ON (C.CÓDIGO = A.CÓDIGO)
WHERE A.CÓDIGO = (SELECT CÓDIGO
                FROM JOGO
                WHERE A.CÓDIGO = J.CÓDIGO)
ORDER BY CO.USERNAME ASC, A.NOME ASC;

-- SOFTWARES QUE FORAM COMPRADOS (SEMI JOIN) --
SELECT C.NOME
FROM COMPRA C
WHERE C.NOME EXISTS (SELECT DISTINCT A.NOME FROM APLICATIVO A WHERE A.TIPO = 'SOFTWARE');

-- JOGOS QUE NAO POSSUEM JOGADORES (ANTI JOIN) --
SELECT A.NOME
FROM APLICATIVO A
WHERE A.NOME NOT EXISTS (SELECT DISTINCT C.NOME FROM COMPRA C) AND A.TIPO = 'JOGO';

-- CONTAS QUE POSSUEM MENOS JOGOS QUE A CONTA 'caiorochac' (SUBCONSULTA ESCALAR)--
SELECT C.USERNAME
FROM CONTA C
WHERE (SELECT COUNT(*) FROM COMPRA WHERE C.USERNAME = USERNAME) < (SELECT COUNT(*) FROM COMPRA WHERE USERNAME = 'caiorochac');

-- CONTA QUE TEM O MAIOR SALDO DE RECIFE (SUBCONSULTA LINHA) --
SELECT USERNAME
FROM CONTA
WHERE (SALDO, LOC_CIDADE) = (SELECT MAX(C2.SALDO), C2.LOC_CIDADE FROM CONTA C2 WHERE C2.LOC_CIDADE = 'RECIFE');

-- NOMES DOS APLICATVOS DA CATEGORIA 'SINGLEPLAYER' (SUBCONSULTA TABELA) --
SELECT NOME
FROM APLICATIVO
WHERE NOME IN (SELECT NOME
            FROM CATEGORIA
            WHERE CATEG = “SINGLEPLAYER”);

-- AMIGOS EM COMUM ENTRE 'caio' E 'mateus' (OPERACAO DE CONJUNTO) --
SELECT *
FROM ((SELECT USERNAME1 AS AMIGOS FROM AMIGO WHERE USERNAME2 = 'caio' AND USERNAME1 <> 'mateus') UNION (SELECT USERNAME2 AS AMIGOS FROM AMIGO WHERE USERNAME1 = 'caio' AND USERNAME2 <> 'mateus'))
INTERSECT
((SELECT USERNAME1 AS AMIGOS FROM AMIGO WHERE USERNAME2 = 'mateus' AND USERNAME1 <> 'caio') UNION (SELECT USERNAME2 AS AMIGOS FROM AMIGO WHERE USERNAME1 = 'mateus' AND USERNAME2 <> 'caio'));
