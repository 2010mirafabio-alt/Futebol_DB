-- =========================================
-- BASE DE DADOS: FUTEBOL PORTUGUÊS
-- Tema: Jogadores de destaque que passaram
-- pela Liga Portuguesa
-- =========================================

DROP DATABASE IF EXISTS futebol_portugal;

CREATE DATABASE futebol_portugal;

USE futebol_portugal;


-- =========================================
-- TABELA JOGADOR
-- =========================================

CREATE TABLE Jogador (
    id_jogador INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE,
    nacionalidade VARCHAR(50),
    posicao VARCHAR(30)
);


-- =========================================
-- TABELA CLUBE
-- =========================================

CREATE TABLE Clube (
    id_clube INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(50),
    ano_fundacao INT
);


-- =========================================
-- TABELA EPOCA
-- =========================================

CREATE TABLE Epoca (
    id_epoca INT PRIMARY KEY AUTO_INCREMENT,
    ano_inicio INT NOT NULL,
    ano_fim INT NOT NULL
);


-- =========================================
-- TABELA PASSAGEM
-- =========================================

CREATE TABLE Passagem (
    id_passagem INT PRIMARY KEY AUTO_INCREMENT,
    id_jogador INT NOT NULL,
    id_clube INT NOT NULL,
    id_epoca INT NOT NULL,
    jogos INT,
    golos INT,
    assistencias INT,

    FOREIGN KEY (id_jogador)
        REFERENCES Jogador(id_jogador),

    FOREIGN KEY (id_clube)
        REFERENCES Clube(id_clube),

    FOREIGN KEY (id_epoca)
        REFERENCES Epoca(id_epoca)
);


-- =========================================
-- TABELA AVALIACAO
-- =========================================

CREATE TABLE Avaliacao (
    id_avaliacao INT PRIMARY KEY AUTO_INCREMENT,
    id_jogador INT NOT NULL,
    nota DECIMAL(4,2),
    premios VARCHAR(255),
    observacoes TEXT,

    FOREIGN KEY (id_jogador)
        REFERENCES Jogador(id_jogador)
);


-- =========================================
-- INSERIR JOGADORES
-- =========================================

INSERT INTO Jogador
(nome, data_nascimento, nacionalidade, posicao)
VALUES
('Eusébio', '1942-01-25', 'Moçambicana/Portuguesa', 'Avançado'),
('Luís Figo', '1972-11-04', 'Portuguesa', 'Médio'),
('Cristiano Ronaldo', '1985-02-05', 'Portuguesa', 'Avançado'),
('Deco', '1977-08-27', 'Brasileira/Portuguesa', 'Médio'),
('Ricardo Carvalho', '1978-05-18', 'Portuguesa', 'Defesa'),
('João Moutinho', '1986-09-08', 'Portuguesa', 'Médio'),
('Hulk', '1986-07-25', 'Brasileira', 'Avançado');


-- =========================================
-- INSERIR CLUBES
-- =========================================

INSERT INTO Clube
(nome, cidade, ano_fundacao)
VALUES
('Sporting CP', 'Lisboa', 1906),
('SL Benfica', 'Lisboa', 1904),
('FC Porto', 'Porto', 1893);


-- =========================================
-- INSERIR EPOCAS
-- =========================================

INSERT INTO Epoca
(ano_inicio, ano_fim)
VALUES
(1967, 1968),
(1993, 1994),
(2002, 2003),
(2003, 2004),
(2006, 2007),
(2008, 2009);


-- =========================================
-- INSERIR PASSAGENS
-- Estatísticas da Liga Portuguesa
-- =========================================

INSERT INTO Passagem
(id_jogador, id_clube, id_epoca, jogos, golos, assistencias)
VALUES

-- Eusébio - Benfica - 1967/68
(1, 2, 1, 24, 42, NULL),

-- Luís Figo - Sporting - 1993/94
(2, 1, 2, 31, 8, 2),

-- Cristiano Ronaldo - Sporting - 2002/03
(3, 1, 3, 25, 3, 3),

-- Deco - FC Porto - 2003/04
(4, 3, 4, 28, 2, 15),

-- Ricardo Carvalho - FC Porto - 2003/04
(5, 3, 4, 29, 2, NULL),

-- João Moutinho - Sporting - 2006/07
(6, 1, 5, 29, 4, 3),

-- Hulk - FC Porto - 2008/09
(7, 3, 6, 25, 8, 6);


-- =========================================
-- INSERIR AVALIACOES
-- =========================================

INSERT INTO Avaliacao
(id_jogador, nota, premios, observacoes)
VALUES

(1, NULL,
 'Bota de Ouro Europeia 1967/68',
 'Eusébio marcou 42 golos no Campeonato Nacional em 1967/68.'),

(2, NULL,
 'Bola de Ouro 2000',
 'Luís Figo representou o Sporting e marcou 8 golos na Liga Portuguesa em 1993/94.'),

(3, NULL,
 'Vários prémios individuais',
 'Cristiano Ronaldo fez 25 jogos e marcou 3 golos na Liga Portuguesa em 2002/03.'),

(4, NULL,
 'UEFA Club Footballer of the Year 2003/04',
 'Deco fez 28 jogos e marcou 2 golos na Liga Portuguesa em 2003/04.'),

(5, NULL,
 'Vários títulos nacionais e internacionais',
 'Ricardo Carvalho fez 29 jogos e marcou 2 golos na Liga Portuguesa em 2003/04.'),

(6, NULL,
 'Vários títulos nacionais',
 'João Moutinho fez 29 jogos e marcou 4 golos na Liga Portuguesa em 2006/07.'),

(7, NULL,
 'Vários títulos nacionais',
 'Hulk fez 25 jogos e marcou 8 golos na Liga Portuguesa em 2008/09.');


-- =========================================
-- CONSULTAS DE TESTE
-- =========================================

-- Ver todos os jogadores
SELECT * FROM Jogador;


-- Ver todos os clubes
SELECT * FROM Clube;


-- Ver todas as épocas
SELECT * FROM Epoca;


-- Ver jogadores, clubes e estatísticas
SELECT
    j.nome AS jogador,
    c.nome AS clube,
    CONCAT(e.ano_inicio, '/', RIGHT(e.ano_fim, 2)) AS epoca,
    p.jogos,
    p.golos,
    p.assistencias
FROM Passagem p
JOIN Jogador j
    ON p.id_jogador = j.id_jogador
JOIN Clube c
    ON p.id_clube = c.id_clube
JOIN Epoca e
    ON p.id_epoca = e.id_epoca;


-- Jogadores ordenados pelo número de golos
SELECT
    j.nome AS jogador,
    SUM(p.golos) AS total_golos
FROM Jogador j
JOIN Passagem p
    ON j.id_jogador = p.id_jogador
GROUP BY j.id_jogador, j.nome
ORDER BY total_golos DESC;
