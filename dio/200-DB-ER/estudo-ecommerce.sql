-- MySQL Script generated by MySQL Workbench
-- Mon Aug 22 12:20:07 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Ecommerce
-- -----------------------------------------------------
-- Banco de dados para sistema simples de e-commerce.

-- -----------------------------------------------------
-- Schema Ecommerce
--
-- Banco de dados para sistema simples de e-commerce.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Ecommerce` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `Ecommerce` ;

-- -----------------------------------------------------
-- Table `Ecommerce`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`Cliente` (
  `idCliente` INT UNSIGNED NOT NULL COMMENT 'Código do usuário.',
  `Ativo` TINYINT NOT NULL COMMENT 'Se pode efetuar compras e transacionar na loja como cliente.',
  PRIMARY KEY (`idCliente`))
ENGINE = MyISAM
COMMENT = 'Tabela de clientes. Indica que o usuário tem o papel de Cliente.';


-- -----------------------------------------------------
-- Table `Ecommerce`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`Endereco` (
  `idEndereco` INT NOT NULL COMMENT 'ID do Endereço.',
  `Usuario` INT UNSIGNED NOT NULL,
  `CEP` MEDIUMINT UNSIGNED NOT NULL COMMENT 'CEP vinculado.',
  `UF` CHAR(2) NOT NULL COMMENT 'UF',
  `Cidade` VARCHAR(60) NOT NULL COMMENT 'Cidade',
  `Logradouro` VARCHAR(45) NOT NULL COMMENT 'Logradouro',
  `Numero` VARCHAR(10) NOT NULL COMMENT 'Número',
  `Complemento` VARCHAR(45) NOT NULL COMMENT 'Complemento',
  PRIMARY KEY (`idEndereco`, `Usuario`))
ENGINE = MyISAM
COMMENT = 'Tabela que armazena os endereços.';

CREATE INDEX `fk_Endereco_Usuario1_idx` ON `Ecommerce`.`Endereco` (`Usuario` ASC);


-- -----------------------------------------------------
-- Table `Ecommerce`.`Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`Estoque` (
  `idEstoque` INT NOT NULL COMMENT 'ID do estoque',
  `Fornecedor` INT UNSIGNED NOT NULL COMMENT 'ID do fornecedor.',
  `Produto` INT UNSIGNED NOT NULL COMMENT 'ID do Produto',
  `Endereco` INT NOT NULL COMMENT 'ID do Endereço.',
  `QuantidadeDisponivel` INT UNSIGNED NOT NULL COMMENT 'Quantidade Disponível.',
  PRIMARY KEY (`idEstoque`))
ENGINE = MyISAM
COMMENT = 'Tabela para armazenar o Estoque.';

CREATE INDEX `fk_Estoque_Fornecedor1_idx` ON `Ecommerce`.`Estoque` (`Fornecedor` ASC);

CREATE INDEX `fk_Estoque_Produto1_idx` ON `Ecommerce`.`Estoque` (`Produto` ASC);

CREATE INDEX `fk_Estoque_Endereco1_idx` ON `Ecommerce`.`Estoque` (`Endereco` ASC);


-- -----------------------------------------------------
-- Table `Ecommerce`.`FormaDePagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`FormaDePagamento` (
  `idFormaCliente` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID da forma de pagamento.',
  `FP` TINYINT UNSIGNED NOT NULL,
  `Cliente` INT UNSIGNED NOT NULL,
  `Metadados` VARCHAR(512) NOT NULL,
  PRIMARY KEY (`idFormaCliente`))
ENGINE = MyISAM
COMMENT = 'Armazenamento das formas de pagamento.';

CREATE INDEX `fk_FormaDePagamento_FormasDePagamento1_idx` ON `Ecommerce`.`FormaDePagamento` (`FP` ASC);

CREATE INDEX `fk_FormaDePagamento_Cliente1_idx` ON `Ecommerce`.`FormaDePagamento` (`Cliente` ASC);


-- -----------------------------------------------------
-- Table `Ecommerce`.`FormasDePagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`FormasDePagamento` (
  `idFP` TINYINT UNSIGNED NOT NULL COMMENT 'ID da forma de pagamento',
  `Nome` VARCHAR(30) NOT NULL COMMENT 'Nome da forma de pagamento',
  `Ativo` TINYINT UNSIGNED NOT NULL COMMENT 'Se a forma de pagamento está ativa ou descontinuada.',
  PRIMARY KEY (`idFP`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `Ecommerce`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`Fornecedor` (
  `idFornecedor` INT UNSIGNED NOT NULL COMMENT 'ID do fornecedor.',
  `NomeFantasia` VARCHAR(60) NOT NULL COMMENT 'Nome a ser exibito na loja.',
  `DescricaoCurta` VARCHAR(256) NOT NULL COMMENT 'Descrição curta do fornecedor.',
  `DescricaoLonga` TEXT NOT NULL COMMENT 'Descrição longa do fornecedor.',
  `Endereco` INT NOT NULL COMMENT 'Endereço do Fornecedor.',
  PRIMARY KEY (`idFornecedor`))
ENGINE = MyISAM
COMMENT = 'Tabela para cadastro de fornecedores.';

CREATE INDEX `fk_Fornecedor_Endereco1_idx` ON `Ecommerce`.`Fornecedor` (`Endereco` ASC);


-- -----------------------------------------------------
-- Table `Ecommerce`.`HistoricoPedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`HistoricoPedido` (
  `Pedido` BIGINT UNSIGNED NOT NULL COMMENT 'ID do pedido.',
  `DataStatus` TIMESTAMP NOT NULL COMMENT 'Data da alteração de status.',
  `StatusAnterior` TINYINT UNSIGNED NOT NULL COMMENT 'Status anterior do pedido.',
  `StatusNovo` TINYINT UNSIGNED NOT NULL COMMENT 'Status Novo do pedido.',
  `Descricao` VARCHAR(128) NOT NULL COMMENT 'Descrição curta do status.',
  `Comentario` VARCHAR(512) NOT NULL COMMENT 'Comentário sobre o status / mais detalhes.')
ENGINE = MyISAM
COMMENT = 'Tabela que armazena o histórico de um pedido. Serve para inserir informações como foi pago, foi enviado, foi recebido ou foi cancelado.';

CREATE INDEX `fk_HistoricoPedido_Pedido1_idx` ON `Ecommerce`.`HistoricoPedido` (`Pedido` ASC);

CREATE INDEX `fk_HistoricoPedido_StatusPedidos1_idx` ON `Ecommerce`.`HistoricoPedido` (`StatusAnterior` ASC);

CREATE INDEX `fk_HistoricoPedido_StatusPedidos2_idx` ON `Ecommerce`.`HistoricoPedido` (`StatusNovo` ASC);


-- -----------------------------------------------------
-- Table `Ecommerce`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`Pedido` (
  `idPedido` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Número do pedido.',
  `Cliente` INT UNSIGNED NOT NULL COMMENT 'Código do cliente.',
  `DataPedido` TIMESTAMP NOT NULL COMMENT 'Data em que foi realizado o pedido.',
  `ValorPedido` INT UNSIGNED NOT NULL COMMENT 'Valor total do pedido em centavos.',
  `StatusPedido` TINYINT UNSIGNED NOT NULL COMMENT 'Último status do pedido.',
  `Endereco` INT NOT NULL COMMENT 'Endereço de entrega.',
  `idFormaCliente` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idPedido`))
ENGINE = MyISAM
COMMENT = 'Tabela de pedidos.';

CREATE INDEX `fk_Pedido_Cliente1_idx` ON `Ecommerce`.`Pedido` (`Cliente` ASC);

CREATE INDEX `fk_Pedido_StatusPedidos1_idx` ON `Ecommerce`.`Pedido` (`StatusPedido` ASC);

CREATE INDEX `fk_Pedido_Endereco1_idx` ON `Ecommerce`.`Pedido` (`Endereco` ASC);

CREATE INDEX `fk_Pedido_FormaDePagamento1_idx` ON `Ecommerce`.`Pedido` (`idFormaCliente` ASC);


-- -----------------------------------------------------
-- Table `Ecommerce`.`PrecoVendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`PrecoVendedor` (
  `Produto` INT UNSIGNED NOT NULL COMMENT 'ID do produto',
  `Vendedor` INT UNSIGNED NOT NULL COMMENT 'ID do vendedor.',
  `Estoque` INT NOT NULL,
  `PrecoVenda` INT UNSIGNED NOT NULL COMMENT 'Preço de venda, em centavos.',
  PRIMARY KEY (`Produto`, `Vendedor`))
ENGINE = MyISAM
COMMENT = 'Tabela para vincular os preços aos produtos quando vendido por determinado vendedor.';

CREATE INDEX `fk_PrecoVendedor_Produto1_idx` ON `Ecommerce`.`PrecoVendedor` (`Produto` ASC);

CREATE INDEX `fk_PrecoVendedor_Vendedor1_idx` ON `Ecommerce`.`PrecoVendedor` (`Vendedor` ASC);

CREATE INDEX `fk_PrecoVendedor_Estoque1_idx` ON `Ecommerce`.`PrecoVendedor` (`Estoque` ASC);


-- -----------------------------------------------------
-- Table `Ecommerce`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`Produto` (
  `idProduto` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID do produto.',
  `Nome` VARCHAR(60) NOT NULL COMMENT 'Nome do produto.',
  `Anuncio` TEXT NOT NULL COMMENT 'Anúncio (pode ser texto ou HTML).',
  `PrecoDeCusto` INT UNSIGNED NOT NULL COMMENT 'Preço de custo em centavos.',
  `PrecoRecomendado` INT UNSIGNED NOT NULL COMMENT 'Preço recomendado para venda em centavos.',
  PRIMARY KEY (`idProduto`))
ENGINE = MyISAM
COMMENT = 'Tabela para cadastro de produtos.';


-- -----------------------------------------------------
-- Table `Ecommerce`.`ProdutosPedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`ProdutosPedido` (
  `Pedido` BIGINT UNSIGNED NOT NULL COMMENT 'Número do pedido.',
  `Produto` INT UNSIGNED NOT NULL COMMENT 'Produto inserido no pedido.',
  `Vendedor` INT UNSIGNED NOT NULL COMMENT 'Se possuir vendedor, será armazenado aqui.',
  `Quantidade` SMALLINT UNSIGNED NOT NULL COMMENT 'Quantidade do produto.',
  `ValorUnitario` INT UNSIGNED NOT NULL COMMENT 'Valor unitário no momento do pedido.')
ENGINE = MyISAM
COMMENT = 'Vincula os produtos a um pedido, com quantidade e valor unitário. Aqui fiz uma cópia do valor unitário pois com o tempo o preço dos produtos poderá ser alterado.';

CREATE INDEX `fk_ProdutosPedido_Pedido1_idx` ON `Ecommerce`.`ProdutosPedido` (`Pedido` ASC);

CREATE INDEX `fk_ProdutosPedido_Produto1_idx` ON `Ecommerce`.`ProdutosPedido` (`Produto` ASC);

CREATE INDEX `fk_ProdutosPedido_Vendedor1_idx` ON `Ecommerce`.`ProdutosPedido` (`Vendedor` ASC);


-- -----------------------------------------------------
-- Table `Ecommerce`.`StatusPedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`StatusPedido` (
  `idStatus` TINYINT UNSIGNED NOT NULL COMMENT 'ID do estado',
  `NomeStatus` VARCHAR(60) NOT NULL COMMENT 'Nome do estado',
  PRIMARY KEY (`idStatus`))
ENGINE = MyISAM
COMMENT = 'Possui os estados possíveis de um pedido.';


-- -----------------------------------------------------
-- Table `Ecommerce`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`Usuario` (
  `idUsuario` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID único de usuário.',
  `DocID` BIGINT UNSIGNED NOT NULL COMMENT 'Número do documento, pode ser CPF ou CNPJ.',
  `Nome` VARCHAR(60) NOT NULL COMMENT 'Nome completo da pessoa/empresa.',
  `Email` VARCHAR(60) NOT NULL COMMENT 'Endereço de e-mail cadastrado.',
  `Telefone` BIGINT NOT NULL COMMENT 'Número do telefone.',
  `Endereco` INT NOT NULL COMMENT 'Referência ao Endereço do Usuário.',
  PRIMARY KEY (`idUsuario`))
ENGINE = MyISAM
COMMENT = 'Tabela para cadastro de usuários no sistema.';

CREATE UNIQUE INDEX `DocID_UNIQUE` ON `Ecommerce`.`Usuario` (`DocID` ASC);

CREATE INDEX `fk_Usuario_Endereco1_idx` ON `Ecommerce`.`Usuario` (`Endereco` ASC);


-- -----------------------------------------------------
-- Table `Ecommerce`.`Vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`Vendedor` (
  `idVendedor` INT UNSIGNED NOT NULL COMMENT 'ID do vendedor.',
  `NomeFantasia` VARCHAR(60) NOT NULL COMMENT 'Nome Fantasia do vendedor.',
  `DescricaoCurta` VARCHAR(256) NOT NULL COMMENT 'Descrição curta do vendedor.',
  `DescricaoLonga` TEXT NOT NULL COMMENT 'Descrição Longa do vendedor.',
  PRIMARY KEY (`idVendedor`))
ENGINE = MyISAM
COMMENT = 'Tabela de vendedores.';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Ecommerce`.`FormasDePagamento`
-- -----------------------------------------------------
START TRANSACTION;
USE `Ecommerce`;
INSERT INTO `Ecommerce`.`FormasDePagamento` (`idFP`, `Nome`, `Ativo`) VALUES (0, 'PIX', 1);
INSERT INTO `Ecommerce`.`FormasDePagamento` (`idFP`, `Nome`, `Ativo`) VALUES (1, 'Boleto', 1);
INSERT INTO `Ecommerce`.`FormasDePagamento` (`idFP`, `Nome`, `Ativo`) VALUES (2, 'Cartão Débito', 1);
INSERT INTO `Ecommerce`.`FormasDePagamento` (`idFP`, `Nome`, `Ativo`) VALUES (3, 'Cartão Crédito', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Ecommerce`.`StatusPedido`
-- -----------------------------------------------------
START TRANSACTION;
USE `Ecommerce`;
INSERT INTO `Ecommerce`.`StatusPedido` (`idStatus`, `NomeStatus`) VALUES (0, 'Pedido Criado');
INSERT INTO `Ecommerce`.`StatusPedido` (`idStatus`, `NomeStatus`) VALUES (1, 'Aguardando Pagamento');
INSERT INTO `Ecommerce`.`StatusPedido` (`idStatus`, `NomeStatus`) VALUES (2, 'Pedido Pago. Aguardando fornecedores.');
INSERT INTO `Ecommerce`.`StatusPedido` (`idStatus`, `NomeStatus`) VALUES (3, 'Pedido Enviado');
INSERT INTO `Ecommerce`.`StatusPedido` (`idStatus`, `NomeStatus`) VALUES (4, 'Pedido recebido e finalizado');
INSERT INTO `Ecommerce`.`StatusPedido` (`idStatus`, `NomeStatus`) VALUES (5, 'Pedido cancelado pelo cliente.');
INSERT INTO `Ecommerce`.`StatusPedido` (`idStatus`, `NomeStatus`) VALUES (6, 'Pedido devolvido.');

COMMIT;

