# Instala o pacote para conexão com o MySQL
install.packages("RMySQL");

# Carrega o pacote para uso
library(RMySQL);

# Cria e abre a conexao com o banco de dados
ucscDb <- dbConnect(MySQL(),user="genome",host="genome-mysql.cse.ucsc.edu")

# Executa comando SQL
result <- dbGetQuery(ucscDb,"show databases;");

# Fecha conexão com o banco de dados.
dbDisconnect(ucscDb);

# Conecta com o servidor, especificando o banco de dados;
hg19 <- dbConnect(MySQL(),user="genome",db="hg19",host="genome-mysql.cse.ucsc.edu");

# Lista as tabelas do banco de dados;
allTables <- dbListTables(hg19);

# Obtém a quantidade de tabelas do banco de dados
length(allTables);

# Mostra as primeiras 5 tabelas
allTables[1:5]

# Lista colunas de uma tabela;
dbListFields(hg19,"affyU133Plus2")

# Obtém a quantidade de linhas da tabela executando uma consulta SQL;
dbGetQuery(hg19,"select COUNT(*) from affyU133Plus2;")

# Lê a tabela e carrega em um dataframe
affyData <- dbReadTable(hg19,"affyU133Plus2")

# Obtém as primeiras observaçoes do dataframe
head(affyData)

# As vezes, se a tabela for muito grande, 
# ler a tabela com dbReadTable não será a melhor opçao.
# A melhor opçao sera executar um comando SQL para obter um conjunto de dados menor.
# query ficará armazenado no banco de dados
query <- dbSendQuery(hg19,"select * from affyU133Plus2 where misMatches between 1 and 3;");

# para obter o resultado, é preciso executar um fetch 
affyMis <- fetch(query);

# Mostra a distribuiçao do que foi selecionado.
# Na clausula where do SELECT, misMatches está entre 1 e 3, quantile mostrará a distribuiçao do conteudo obtido.
quantile(affyMis$misMatches)

# Obtém apenas os primeiros 10 registros da query executada no servidor
affyMisSmall <- fetch(query,n=10);

# Limpa a query, e libera recursos do servidor;
dbClearResult(query);

# Mostra a quantidade de linhas e colunas : 10 , 22
dim(affyMisSmall)

# Fecha conexão com o servidor de banco de dados
dbDisconnect(hg19);
