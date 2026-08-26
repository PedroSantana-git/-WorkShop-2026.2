CREATE SCHEMA IF NOT EXISTS desafio;

USE desafio;

CREATE TABLE regioes (
    id_regiao INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    estado VARCHAR(30) NOT NULL,
    potencial DECIMAL(5,2) NOT NULL
);

CREATE TABLE usinas (
    id_usina INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    capacidade DECIMAL(10,2) NOT NULL,
    id_regiao INT NOT NULL,
    FOREIGN KEY (id_regiao) REFERENCES regioes(id_regiao)
);

CREATE TABLE geracao (
    id_geracao INT PRIMARY KEY,
    quantidade DECIMAL(10,2) NOT NULL,
    data_geracao DATE NOT NULL,
    id_usina INT NOT NULL,
    FOREIGN KEY (id_usina) REFERENCES usinas(id_usina)
);

INSERT INTO regioes (id_regiao, nome, estado, potencial)
VALUES
(1, 'Litoral Norte', 'Ceara', 91.40),
(2, 'Planalto', 'Minas Gerais', 74.80),
(3, 'Vale do Sol', 'Bahia', 87.60),
(4, 'Amazonia', 'Para', 93.20),
(5, 'Campos Gerais', 'Parana', 69.50),
(6, 'Sertao Central', 'Pernambuco', 84.30),
(7, 'Chapada', 'Goias', 77.90),
(8, 'Zona Sul', 'Rio Grande do Sul', 71.20),
(9, 'Agreste Norte', 'Rio Grande do Norte', 89.70),
(10, 'Vale Verde', 'Mato Grosso', 80.50);

INSERT INTO usinas (id_usina, nome, tipo, capacidade, id_regiao)
VALUES
(1, 'Parque Solar Aurora', 'Solar', 450.00, 1),
(2, 'Usina Eolica Horizonte', 'Eolica', 620.00, 2),
(3, 'Hidreletrica Rio Azul', 'Hidreletrica', 850.00, 3),
(4, 'Parque Solar Amazonia', 'Solar', 530.00, 4),
(5, 'Complexo Eolico Campos', 'Eolica', 710.00, 5),
(6, 'Usina Solar Sertaneja', 'Solar', 480.00, 6),
(7, 'Parque Eolico Chapada', 'Eolica', 680.00, 7),
(8, 'Usina Hidreletrica Sul', 'Hidreletrica', 920.00, 8),
(9, 'Parque Solar Agreste', 'Solar', 560.00, 9),
(10, 'Usina Eolica Verde', 'Eolica', 750.00, 10);

INSERT INTO geracao (id_geracao, quantidade, data_geracao, id_usina)
VALUES
(1, 325.80, '2026-01-05', 1),
(2, 412.60, '2026-01-18', 2),
(3, 587.40, '2026-02-10', 3),
(4, 368.90, '2026-02-25', 4),
(5, 455.70, '2026-03-12', 5),
(6, 398.30, '2026-03-28', 6),
(7, 521.90, '2026-04-14', 7),
(8, 634.20, '2026-05-03', 8),
(9, 476.50, '2026-05-21', 9),
(10, 549.80, '2026-06-15', 10);

UPDATE usinas
SET nome = 'Parque Solar Aurora Nordeste'
WHERE id_usina = 1;

SELECT *
FROM regioes;

SELECT *
FROM usinas;

SELECT *
FROM geracao;

SELECT COUNT(*) AS total_registros
FROM geracao;

SELECT SUM(quantidade) AS total_geracao
FROM geracao;

SELECT AVG(quantidade) AS media_geracao
FROM geracao;

SELECT
    tipo,
    COUNT(*) AS quantidade
FROM usinas
GROUP BY tipo
HAVING COUNT(*) >= 3;

SELECT
    u.nome AS usina,
    r.nome AS regiao,
    r.estado
FROM usinas AS u
INNER JOIN regioes AS r
    ON u.id_regiao = r.id_regiao;

SELECT
    r.nome AS regiao,
    SUM(g.quantidade) AS total_geracao
FROM regioes AS r
INNER JOIN usinas AS u
    ON r.id_regiao = u.id_regiao
INNER JOIN geracao AS g
    ON u.id_usina = g.id_usina
GROUP BY r.id_regiao, r.nome
ORDER BY total_geracao DESC
LIMIT 1;
