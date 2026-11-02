# Lista telefonica — estudos de SQL

Estou praticando JOIN na faculdade. Neste exercicio, relaciono assinantes, enderecos, telefones, municipios, tipos de assinante e ramos de atividade.

## O que pratiquei
INNER JOIN, LEFT JOIN, WHERE, AND, OR, ORDER BY, GROUP BY, COUNT e HAVING, alem de chaves primarias e estrangeiras.

## Como executar
Abra `projeto.sql` no MySQL Workbench usando uma conexao de estudos. Execute a criacao das tabelas e a carga uma vez em um banco novo. Depois, execute cada SELECT separadamente.

Se ja houver tabelas no banco lista_telefonica_estudo, escolha outro nome antes de executar. Repetir os INSERTs causa conflito de chaves.

## Organizacao dos dados
A estrutura de tabelas e uma implementacao didatica do modelo conceitual do exercicio. Cada assinante tem um endereco e um tipo; o ramo e opcional. Cada telefone pertence a um endereco. Assim, assinantes no mesmo endereco compartilham os telefones nas consultas.

Nomes, enderecos e telefones sao ficticios. Usei Cangucu sem cedilha tanto nos dados quanto no filtro.

## Consultas
1. Assinantes com enderecos e telefones, incluindo quem nao tem telefone.
2. Assinantes e ramos, ordenados por ramo e nome.
3. Assinantes residenciais de Pelotas.
4. Assinantes com mais de um telefone ligado ao endereco.
5. Assinantes comerciais com telefone em Pelotas ou Cangucu.

## Resultados esperados
| Consulta | Resultado |
|---|---|
| 1 | 7 linhas; Bruno aparece com telefone NULL |
| 2 | 5 linhas; Ana e Bruno aparecem sem ramo |
| 3 | Ana Exemplo e Bruno Exemplo |
| 4 | Ana Exemplo e Cafe Exemplo, com 2 telefones cada |
| 5 | 3 linhas: uma da Livraria Exemplo e duas do Cafe Exemplo |

## Validacao
As consultas foram conferidas em SQLite sobre uma estrutura equivalente com os mesmos dados. A execucao completa do arquivo no MySQL ainda precisa ser conferida.

## Proximos passos
Comparar os resultados de INNER JOIN e LEFT JOIN e praticar views.
