# 💰 Projeto MySQL – Contas a Receber

Este projeto demonstra a criação de um **banco de dados relacional** em **MySQL**, simulando o controle de **contas a receber de uma loja**.

## 🧱 Estrutura do Projeto

- **Tabelas:** Estado, Município, Cliente e ContaReceber  
- **Relacionamentos:**  
  - Cada Município pertence a um Estado  
  - Cada Cliente pertence a um Município  
  - Cada ContaReceber pertence a um Cliente

## ⚙️ Tecnologias Utilizadas

- MySQL 8.0 (via [dbfiddle.uk](https://dbfiddle.uk))
- Linguagem SQL (DDL, DML, DQL)

## 📂 Arquivos

| Arquivo | Descrição |
|----------|------------|
| `loja.sql` | Script completo com criação do banco, inserção de dados e consultas |
| `README.md` | Documentação do projeto |

## 🧠 Regras Importantes

- Todas as **chaves primárias são AUTO_INCREMENT**  
- O campo **Situação** da tabela `ContaReceber` é do tipo **ENUM('1','2','3')**, sendo:  
  - `1` – Conta registrada  
  - `2` – Conta cancelada  
  - `3` – Conta paga  

## 🧾 View Criada

```sql
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
🧩 Resultado Esperado
| ID_Conta | Nome_Cliente | CPF_Cliente | DataVencimento | Valor  |
| -------- | ------------ | ----------- | -------------- | ------ |
| 1        | João Silva   | 12345678901 | 2025-10-20     | 500.00 |
| 3        | Carlos Lima  | 55566677788 | 2025-10-25     | 800.00 |

🌐 Execução Online

Você pode rodar o projeto completo sem instalar nada:
👉 Clique aqui para executar no DB Fiddle

Autor: Rerisson Henrique Rodrigues da Silva
Curso: CST em Análise e Desenvolvimento de Sistemas - Faculdade Anhaguera - Programação e Desenvolvimento de Banco de Dados
