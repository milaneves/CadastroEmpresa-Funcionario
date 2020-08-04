Create   Database EXTRADIGITAL

go


use   EXTRADIGITAL


go
create table Endereco
(
 IdEndereco int identity NOT NULL  ,
 CPF varchar (11)  NULL,
 CNPJ varchar(14)  NULL,
 Endereco varchar(60) NOT NULL,
 bairro varchar(60) NOT NULL,
 Cidade varchar(60) NOT NULL,
 CEP varchar(8) NOT NULL,
 Numero int NOT NULL,
 Complemento varchar(60)NOT NULL,
 Data_Cadastro datetime   NULL,
 Ativo bit not null


 PRIMARY KEY (IdEndereco)

)

 
create table Empresa
(
  IdEmpresa int identity NOT NULL  ,
  IdEndereco int NOT NULl,
  Razao_Social varchar(80) NOT NULL,
  Nome_Fantasia varchar(80),
  CNPJ varchar(14) NOT NULL,
  Email varchar(60)NOT NULL,
  Telefone varchar(14) NULL,
  Data_Atualizacao datetime NULL

  PRIMARY KEY (IdEmpresa),
  FOREIGN KEY (IdEndereco) REFERENCES Endereco (IdEndereco)
 )

go

 create table Funcionario
(
  IdFuncionario int identity NOT NULL ,
  IdEmpresa int NOT NULl,
  IdEndereco int NOT NULl,
  Nome varchar(80) NOT NULL,
  CPF varchar (11) NOT NULL,
  Salario decimal NOT NULL,
  Email varchar(50),
  Telefone varchar(14),
  Data_Cadastro datetime NULL,
  Data_Atualizacao datetime NULL


 PRIMARY KEY (IdFuncionario),
 FOREIGN KEY (IdEmpresa) REFERENCES Empresa (IdEmpresa),
  FOREIGN KEY (IdEndereco) REFERENCES Endereco (IdEndereco)
 )

 go


