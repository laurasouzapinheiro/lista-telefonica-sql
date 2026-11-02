-- Criei esse banco para praticar JOIN com uma lista telefonica.
-- Vou relacionar assinantes, enderecos e telefones.
CREATE DATABASE IF NOT EXISTS lista_telefonica_estudo CHARACTER SET utf8mb4;
USE lista_telefonica_estudo;
-- Primeiro, crio as tabelas e seus relacionamentos.
CREATE TABLE municipio (
 cd_municipio INT PRIMARY KEY, ds_municipio VARCHAR(100) NOT NULL
);
CREATE TABLE tipo_assinante (
 cd_tipo INT PRIMARY KEY, ds_tipo VARCHAR(50) NOT NULL
);
CREATE TABLE ramo_atividade (
 cd_ramo INT PRIMARY KEY, ds_ramo VARCHAR(100) NOT NULL
);
CREATE TABLE endereco (
 cd_endereco INT PRIMARY KEY, ds_endereco VARCHAR(150) NOT NULL,
 complemento VARCHAR(100), bairro VARCHAR(80), cep VARCHAR(8),
 cd_municipio INT NOT NULL,
 FOREIGN KEY (cd_municipio) REFERENCES municipio(cd_municipio)
);
CREATE TABLE assinante (
 cd_assinante INT PRIMARY KEY, nm_assinante VARCHAR(100) NOT NULL,
 cd_endereco INT NOT NULL, cd_tipo INT NOT NULL, cd_ramo INT NULL,
 FOREIGN KEY (cd_endereco) REFERENCES endereco(cd_endereco),
 FOREIGN KEY (cd_tipo) REFERENCES tipo_assinante(cd_tipo),
 FOREIGN KEY (cd_ramo) REFERENCES ramo_atividade(cd_ramo)
);
CREATE TABLE telefone (
 cd_fone INT PRIMARY KEY, ddd VARCHAR(2) NOT NULL, n_fone VARCHAR(9) NOT NULL,
 cd_endereco INT NOT NULL,
 FOREIGN KEY (cd_endereco) REFERENCES endereco(cd_endereco)
);
-- Usei dados ficticios para testar as consultas.
INSERT INTO municipio VALUES (1,'Pelotas'),(2,'Cangucu'),(3,'Salvador');
INSERT INTO tipo_assinante VALUES (1,'Residencial'),(2,'Comercial');
INSERT INTO ramo_atividade VALUES (1,'Livraria'),(2,'Alimentacao');
INSERT INTO endereco VALUES
 (1,'Rua Exemplo A, 10',NULL,'Centro','00000001',1),
 (2,'Rua Exemplo B, 20','Loja 1','Centro','00000002',1),
 (3,'Rua Exemplo C, 30',NULL,'Centro','00000003',2),
 (4,'Rua Exemplo D, 40',NULL,'Centro','00000004',1),
 (5,'Rua Exemplo E, 50',NULL,'Centro','00000005',3);
INSERT INTO assinante VALUES
 (1,'Ana Exemplo',1,1,NULL),
 (2,'Livraria Exemplo',2,2,1),
 (3,'Cafe Exemplo',3,2,2),
 (4,'Bruno Exemplo',4,1,NULL),
 (5,'Loja Distante',5,2,1);
INSERT INTO telefone VALUES
 (1,'00','000000001',1),(2,'00','000000002',1),
 (3,'00','000000003',2),(4,'00','000000004',3),
 (5,'00','000000005',3),(6,'00','000000006',5);

-- 1. Quero listar os assinantes com seus enderecos e telefones.
-- Usei LEFT JOIN para mostrar tambem quem nao tem telefone.
SELECT a.nm_assinante, e.ds_endereco, e.complemento, e.bairro, e.cep,
       t.ddd, t.n_fone
FROM assinante AS a
INNER JOIN endereco AS e ON a.cd_endereco = e.cd_endereco
LEFT JOIN telefone AS t ON e.cd_endereco = t.cd_endereco
ORDER BY a.cd_assinante, t.cd_fone;

-- 2. Aqui listo o ramo de cada assinante e ordeno por ramo e nome.
-- O LEFT JOIN mantem na lista quem nao tem ramo cadastrado.
SELECT a.nm_assinante, r.ds_ramo
FROM assinante AS a
LEFT JOIN ramo_atividade AS r ON a.cd_ramo = r.cd_ramo
ORDER BY r.ds_ramo, a.nm_assinante;

-- 3. Quero apenas os assinantes residenciais que moram em Pelotas.
SELECT a.nm_assinante, ta.ds_tipo, e.ds_endereco, m.ds_municipio
FROM assinante AS a
INNER JOIN endereco AS e ON a.cd_endereco = e.cd_endereco
INNER JOIN municipio AS m ON e.cd_municipio = m.cd_municipio
INNER JOIN tipo_assinante AS ta ON a.cd_tipo = ta.cd_tipo
WHERE m.ds_municipio = 'Pelotas' AND ta.ds_tipo = 'Residencial'
ORDER BY a.nm_assinante;

-- 4. Agrupei por codigo e nome para contar os telefones de cada assinante.
-- O HAVING deixa no resultado apenas quem tem mais de um.
-- Neste modelo, os telefones estao ligados ao endereco do assinante.
SELECT a.nm_assinante, COUNT(t.cd_fone) AS quantidade_telefones
FROM assinante AS a
INNER JOIN endereco AS e ON a.cd_endereco = e.cd_endereco
INNER JOIN telefone AS t ON e.cd_endereco = t.cd_endereco
GROUP BY a.cd_assinante, a.nm_assinante
HAVING COUNT(t.cd_fone) > 1
ORDER BY a.nm_assinante;

-- 5. Aqui busco os comerciais de Pelotas ou Cangucu.
-- Usei parenteses para aplicar o filtro comercial nas duas cidades.
SELECT a.nm_assinante, t.ddd, t.n_fone, ta.ds_tipo,
       e.ds_endereco, m.ds_municipio
FROM assinante AS a
INNER JOIN endereco AS e ON a.cd_endereco = e.cd_endereco
INNER JOIN telefone AS t ON e.cd_endereco = t.cd_endereco
INNER JOIN municipio AS m ON e.cd_municipio = m.cd_municipio
INNER JOIN tipo_assinante AS ta ON a.cd_tipo = ta.cd_tipo
WHERE ta.ds_tipo = 'Comercial'
  AND (m.ds_municipio = 'Pelotas' OR m.ds_municipio = 'Cangucu')
ORDER BY a.nm_assinante, t.n_fone;
