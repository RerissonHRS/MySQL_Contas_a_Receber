-- =============================================
-- BANCO DE DADOS: Loja - Contas a Receber
-- Autor: Rerisson Henrique Rodrigues da Silva
-- Ambiente: db<>fiddle (MySQL 8.0)
-- =============================================

-- Criação do banco
CREATE DATABASE IF NOT EXISTS Loja;
USE Loja;

-- =============================================
-- TABELAS
-- =============================================

CREATE TABLE Estado (
  ID INT AUTO_INCREMENT PRIMARY KEY,
  Nome VARCHAR(100) NOT NULL,
  UF CHAR(2) NOT NULL
);

CREATE TABLE Municipio (
  ID INT AUTO_INCREMENT PRIMARY KEY,
  Estado_ID INT NOT NULL,
  Nome VARCHAR(100) NOT NULL,
  CodIBGE INT NOT NULL,
  FOREIGN KEY (Estado_ID) REFERENCES Estado(ID)
);

CREATE TABLE Cliente (
  ID INT AUTO_INCREMENT PRIMARY KEY,
  Nome VARCHAR(100) NOT NULL,
  CPF CHAR(11) NOT NULL,
  Celular VARCHAR(15),
  EndLogradouro VARCHAR(100),
  EndNumero VARCHAR(10),
  EndMunicipio INT,
  EndCEP CHAR(8),
  DataNascimento DATE,
  FOREIGN KEY (EndMunicipio) REFERENCES Municipio(ID)
);

CREATE TABLE ContaReceber (
  ID INT AUTO_INCREMENT PRIMARY KEY,
  Cliente_ID INT NOT NULL,
  FaturaVendaID INT NOT NULL,
  DataConta DATE NOT NULL,
  DataVencimento DATE NOT NULL,
  Valor DECIMAL(18,2) NOT NULL,
  Situacao ENUM('1', '2', '3') NOT NULL COMMENT '1=Registrada, 2=Cancelada, 3=Paga',
  FOREIGN KEY (Cliente_ID) REFERENCES Cliente(ID)
);

-- =============================================
-- INSERÇÃO DE DADOS
-- =============================================

INSERT INTO Estado (Nome, UF) VALUES
('São Paulo', 'SP'),
('Rio de Janeiro', 'RJ'),
('Minas Gerais', 'MG');

INSERT INTO Municipio (Estado_ID, Nome, CodIBGE) VALUES
(1, 'Campinas', 3509502),
(1, 'São Paulo', 3550308),
(2, 'Niterói', 3303302);

INSERT INTO Cliente (Nome, CPF, Celular, EndLogradouro, EndNumero, EndMunicipio, EndCEP, DataNascimento) VALUES
('João Silva', '12345678901', '11999999999', 'Rua das Flores', '10', 1, '13000000', '1985-04-10'),
('Maria Souza', '98765432100', '21988888888', 'Av. Brasil', '200', 2, '20000000', '1990-08-21'),
('Carlos Lima', '55566677788', '31977777777', 'Rua Central', '300', 3, '24000000', '1988-12-05');

INSERT INTO ContaReceber (Cliente_ID, FaturaVendaID, DataConta, DataVencimento, Valor, Situacao) VALUES
(1, 1001, '2025-10-05', '2025-10-20', 500.00, '1'),
(2, 1002, '2025-09-15', '2025-09-30', 1000.50, '3'),
(3, 1003, '2025-10-05', '2025-10-25', 800.00, '1');

-- =============================================
-- VIEW: Contas Não Pagas
-- =============================================

DROP VIEW IF EXISTS vw_contas_nao_pagas;
CREATE VIEW vw_contas_nao_pagas AS
SELECT
  cr.ID AS ID_Conta,
  c.Nome AS Nome_Cliente,
  c.CPF AS CPF_Cliente,
  cr.DataVencimento,
  cr.Valor
FROM ContaReceber cr
JOIN Cliente c ON cr.Cliente_ID = c.ID
WHERE cr.Situacao = '1';

-- Teste da View
SELECT * FROM vw_contas_nao_pagas;
