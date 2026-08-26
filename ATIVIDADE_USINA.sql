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
(1, 'Nordeste', 'Paraiba', 85.50),
(2, 'Sudeste', 'Sao Paulo', 72.30),
(3, 'Sul', 'Parana', 68.00),
(4, 'Norte', 'Amazonas', 90.20),
(5, 'Centro-Oeste', 'Goias', 76.40),
(6, 'Litoral', 'Pernambuco', 88.10),
(7, 'Sertao', 'Ceara', 81.70),
(8, 'Zona da Mata', 'Alagoas', 70.50),
(9, 'Agreste', 'Rio Grande do Norte', 79.00),
(10, 'Vale', 'Bahia', 83.60);

INSERT INTO usinas (id_usina, nome, tipo, id_regiao)
VALUES
(1, 'Usina Sol', 'Solar', 1),
(2, 'Usina Ventos', 'Eolica', 2),
(3, 'Usina Verde', 'Hidreletrica', 3),
(4, 'Usina Norte', 'Solar', 4),
(5, 'Usina Central', 'Eolica', 5),
(6, 'Usina Mar', 'Eolica', 6),
(7, 'Usina Sertao', 'Solar', 7),
(8, 'Usina Mata', 'Solar', 8),
(9, 'Usina Agreste', 'Eolica', 9),
(10, 'Usina Vale', 'Hidreletrica', 10);

INSERT INTO geracao (id_geracao, quantidade, data_geracao, id_usina)
VALUES
(1, 150.50, '2026-01-10', 1),
(2, 180.00, '2026-02-12', 2),
(3, 210.50, '2026-03-15', 3),
(4, 175.00, '2026-04-18', 4),
(5, 230.50, '2026-05-20', 5),
(6, 195.00, '2026-06-22', 6),
(7, 250.00, '2026-07-25', 7),
(8, 160.50, '2026-08-10', 8),
(9, 220.00, '2026-09-12', 9),
(10, 275.50, '2026-10-15', 10);

UPDATE usinas
SET nome = 'Usina Solar Nordeste'
WHERE id_usina = 1;

SELECT *
FROM usinas;

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
HAVING COUNT(*) > 2;

SELECT
    u.nome AS usina,
    r.nome AS regiao
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
