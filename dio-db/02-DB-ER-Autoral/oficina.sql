-- MySQL Script generated by MySQL Workbench
-- Mon Aug 22 13:08:16 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Oficina
-- -----------------------------------------------------
-- Base para um sistema de oficina, com mecânicos, equipes, clientes e ordens de serviço.

-- -----------------------------------------------------
-- Schema Oficina
--
-- Base para um sistema de oficina, com mecânicos, equipes, clientes e ordens de serviço.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Oficina` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `Oficina` ;

-- -----------------------------------------------------
-- Table `Oficina`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Cliente` (
  `idCliente` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `DocID` VARCHAR(45) NOT NULL,
  `Nome` VARCHAR(60) NOT NULL,
  `Endereco` VARCHAR(128) NOT NULL,
  `Telefone` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `Oficina`.`Equipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Equipe` (
  `idEquipe` SMALLINT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Area` VARCHAR(45) NOT NULL,
  `Especialidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEquipe`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `Oficina`.`Equipe_prove_Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Equipe_prove_Servico` (
  `Equipe_idEquipe` SMALLINT NOT NULL,
  `Servico_idServico` SMALLINT NOT NULL,
  PRIMARY KEY (`Equipe_idEquipe`, `Servico_idServico`))
ENGINE = MyISAM;

CREATE INDEX `fk_Equipe_has_Servico_Servico1_idx` ON `Oficina`.`Equipe_prove_Servico` (`Servico_idServico` ASC);

CREATE INDEX `fk_Equipe_has_Servico_Equipe1_idx` ON `Oficina`.`Equipe_prove_Servico` (`Equipe_idEquipe` ASC);


-- -----------------------------------------------------
-- Table `Oficina`.`Equipe_tem_Mecanico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Equipe_tem_Mecanico` (
  `Equipe_idEquipe` SMALLINT NOT NULL,
  `Mecanico_idMecanico` SMALLINT NOT NULL,
  PRIMARY KEY (`Equipe_idEquipe`, `Mecanico_idMecanico`))
ENGINE = MyISAM;

CREATE INDEX `fk_Equipe_has_Mecanico_Mecanico1_idx` ON `Oficina`.`Equipe_tem_Mecanico` (`Mecanico_idMecanico` ASC);

CREATE INDEX `fk_Equipe_has_Mecanico_Equipe_idx` ON `Oficina`.`Equipe_tem_Mecanico` (`Equipe_idEquipe` ASC);


-- -----------------------------------------------------
-- Table `Oficina`.`Fabricante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Fabricante` (
  `idFabricante` TINYINT NOT NULL AUTO_INCREMENT,
  `NomeFabricante` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idFabricante`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `Oficina`.`HistoricoOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`HistoricoOS` (
  `OS_idOS` INT NOT NULL,
  `StatusOS_idStatusOS` TINYINT NOT NULL,
  `DataHist` TIMESTAMP NOT NULL,
  `Titulo` VARCHAR(45) NOT NULL,
  `Comentario` VARCHAR(45) NOT NULL)
ENGINE = MyISAM;

CREATE INDEX `fk_HsitoricoOS_OS1_idx` ON `Oficina`.`HistoricoOS` (`OS_idOS` ASC);

CREATE INDEX `fk_HsitoricoOS_StatusOS1_idx` ON `Oficina`.`HistoricoOS` (`StatusOS_idStatusOS` ASC);


-- -----------------------------------------------------
-- Table `Oficina`.`Material`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Material` (
  `idMaterial` SMALLINT NOT NULL AUTO_INCREMENT,
  `Titulo` VARCHAR(45) NOT NULL,
  `Especificacoes` VARCHAR(45) NOT NULL,
  `Valor` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idMaterial`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `Oficina`.`Mecanico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Mecanico` (
  `idMecanico` SMALLINT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Endereco` VARCHAR(45) NOT NULL,
  `Especialidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idMecanico`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `Oficina`.`Modelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Modelo` (
  `idModelo` SMALLINT NOT NULL AUTO_INCREMENT,
  `Fabricante` TINYINT NOT NULL,
  `NomeModelo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idModelo`, `Fabricante`))
ENGINE = MyISAM;

CREATE INDEX `fk_Modelo_Fabricante1_idx` ON `Oficina`.`Modelo` (`Fabricante` ASC);


-- -----------------------------------------------------
-- Table `Oficina`.`OS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`OS` (
  `idOS` INT NOT NULL AUTO_INCREMENT,
  `Veiculo` INT NOT NULL,
  `Cliente` INT UNSIGNED NOT NULL,
  `Equipe` SMALLINT NOT NULL,
  `Status` TINYINT NOT NULL,
  `Valor` INT UNSIGNED NOT NULL,
  `DataEntrada` TIMESTAMP NOT NULL,
  `DataSaida` DATE NOT NULL,
  PRIMARY KEY (`idOS`))
ENGINE = MyISAM;

CREATE INDEX `fk_OS_Veiculo1_idx` ON `Oficina`.`OS` (`Veiculo` ASC, `Cliente` ASC);

CREATE INDEX `fk_OS_Cliente1_idx` ON `Oficina`.`OS` (`Cliente` ASC);

CREATE INDEX `fk_OS_Equipe1_idx` ON `Oficina`.`OS` (`Equipe` ASC);

CREATE INDEX `fk_OS_StatusOS1_idx` ON `Oficina`.`OS` (`Status` ASC);


-- -----------------------------------------------------
-- Table `Oficina`.`OS_has_Material`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`OS_has_Material` (
  `OS_idOS` INT NOT NULL,
  `Material_idMaterial` SMALLINT NOT NULL,
  `ValorCobrado` INT NULL,
  PRIMARY KEY (`OS_idOS`, `Material_idMaterial`))
ENGINE = MyISAM;

CREATE INDEX `fk_OS_has_Material_Material1_idx` ON `Oficina`.`OS_has_Material` (`Material_idMaterial` ASC);

CREATE INDEX `fk_OS_has_Material_OS1_idx` ON `Oficina`.`OS_has_Material` (`OS_idOS` ASC);


-- -----------------------------------------------------
-- Table `Oficina`.`OS_has_Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`OS_has_Servico` (
  `OS_idOS` INT NOT NULL,
  `Servico_idServico` SMALLINT NOT NULL,
  `ValorCobrado` INT NULL,
  PRIMARY KEY (`OS_idOS`, `Servico_idServico`))
ENGINE = MyISAM;

CREATE INDEX `fk_OS_has_Servico_Servico1_idx` ON `Oficina`.`OS_has_Servico` (`Servico_idServico` ASC);

CREATE INDEX `fk_OS_has_Servico_OS1_idx` ON `Oficina`.`OS_has_Servico` (`OS_idOS` ASC);


-- -----------------------------------------------------
-- Table `Oficina`.`Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Servico` (
  `idServico` SMALLINT NOT NULL AUTO_INCREMENT,
  `Titulo` VARCHAR(45) NOT NULL,
  `Descricao` VARCHAR(45) NOT NULL,
  `Valor` INT NOT NULL,
  PRIMARY KEY (`idServico`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `Oficina`.`StatusOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`StatusOS` (
  `idStatusOS` TINYINT NOT NULL AUTO_INCREMENT,
  `Titulo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idStatusOS`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `Oficina`.`Veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Veiculo` (
  `idVeiculo` INT NOT NULL AUTO_INCREMENT,
  `Cliente` INT UNSIGNED NOT NULL,
  `Placa` VARCHAR(45) NOT NULL,
  `Ano` VARCHAR(45) NOT NULL,
  `Modelo` SMALLINT NOT NULL,
  `Fabricante` TINYINT NOT NULL,
  PRIMARY KEY (`idVeiculo`))
ENGINE = MyISAM;

CREATE INDEX `fk_Veiculo_Cliente1_idx` ON `Oficina`.`Veiculo` (`Cliente` ASC);

CREATE INDEX `fk_Veiculo_Modelo1_idx` ON `Oficina`.`Veiculo` (`Modelo` ASC, `Fabricante` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Oficina`.`StatusOS`
-- -----------------------------------------------------
START TRANSACTION;
USE `Oficina`;
INSERT INTO `Oficina`.`StatusOS` (`idStatusOS`, `Titulo`) VALUES (0, 'Aberta.');
INSERT INTO `Oficina`.`StatusOS` (`idStatusOS`, `Titulo`) VALUES (1, 'Em avaliação pela Equipe.');
INSERT INTO `Oficina`.`StatusOS` (`idStatusOS`, `Titulo`) VALUES (2, 'Orçamento realizado.');
INSERT INTO `Oficina`.`StatusOS` (`idStatusOS`, `Titulo`) VALUES (3, 'Cliente contatado, aguardando resposta.');
INSERT INTO `Oficina`.`StatusOS` (`idStatusOS`, `Titulo`) VALUES (4, 'Orçamento aceito pelo cliente.');
INSERT INTO `Oficina`.`StatusOS` (`idStatusOS`, `Titulo`) VALUES (5, 'Orçamento recusado pelo cliente.');
INSERT INTO `Oficina`.`StatusOS` (`idStatusOS`, `Titulo`) VALUES (6, 'Em execução pela Equipe.');
INSERT INTO `Oficina`.`StatusOS` (`idStatusOS`, `Titulo`) VALUES (7, 'Concluída, aguardando retirada pelo cliente.');
INSERT INTO `Oficina`.`StatusOS` (`idStatusOS`, `Titulo`) VALUES (8, 'Finalizada.');

COMMIT;

