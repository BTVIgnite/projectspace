-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema ignite
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ignite
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ignite` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `ignite` ;

-- -----------------------------------------------------
-- Table `ignite`.`ignite_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ignite`.`ignite_users` (
  `uid` INT NOT NULL COMMENT '',
  `username` VARCHAR(45) NOT NULL COMMENT '',
  `user_password` VARCHAR(255) NOT NULL COMMENT '',
  `email` VARCHAR(64) NOT NULL COMMENT '',
  `instant_notification` TINYINT(1) NOT NULL COMMENT '',
  `weekly_notifcation` TINYINT(1) NOT NULL COMMENT '',
  `created_at` DATE NOT NULL COMMENT '',
  `updated_at` DATE NOT NULL COMMENT '',
  `admin` INT(1) NOT NULL DEFAULT 0 COMMENT '',
  PRIMARY KEY (`uid`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ignite`.`ignite_organizations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ignite`.`ignite_organizations` (
  `oid` INT NOT NULL COMMENT '',
  `oname` VARCHAR(45) NOT NULL COMMENT '',
  `logo_url` VARCHAR(45) NOT NULL COMMENT '',
  `odescription` VARCHAR(45) NOT NULL COMMENT '',
  `owebsite` VARCHAR(45) NOT NULL COMMENT '',
  `ignite_city` VARCHAR(45) NOT NULL COMMENT '',
  `created_at` DATE NOT NULL COMMENT '',
  `updated_at` DATE NOT NULL COMMENT '',
  `org_owner` INT NOT NULL COMMENT '',
  PRIMARY KEY (`oid`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ignite`.`tbl_projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ignite`.`tbl_projects` (
  `pid` INT NOT NULL COMMENT '',
  `pname` VARCHAR(45) NOT NULL COMMENT '',
  `picture_url` VARCHAR(45) NOT NULL COMMENT '',
  `pdescription` VARCHAR(45) NOT NULL COMMENT '',
  `p_website` VARCHAR(45) NOT NULL COMMENT '',
  `is_active` TINYINT(1) NOT NULL COMMENT '',
  `created_at` DATE NOT NULL COMMENT '',
  `updated_at` DATE NOT NULL COMMENT '',
  PRIMARY KEY (`pid`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ignite`.`ignite_project_organizations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ignite`.`ignite_project_organizations` (
  `oid` INT NOT NULL COMMENT '',
  `pid` INT NOT NULL COMMENT '',
  PRIMARY KEY (`oid`, `pid`)  COMMENT '',
  INDEX `fk_tbl_project_organizations_tbl_projects1_idx` (`pid` ASC)  COMMENT '',
  CONSTRAINT `fk_tbl_project_organizations_tbl_organizations1`
    FOREIGN KEY (`oid`)
    REFERENCES `ignite`.`ignite_organizations` (`oid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_project_organizations_tbl_projects1`
    FOREIGN KEY (`pid`)
    REFERENCES `ignite`.`tbl_projects` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ignite`.`ignite_organization_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ignite`.`ignite_organization_users` (
  `uid` INT NOT NULL COMMENT '',
  `oid` INT NOT NULL COMMENT '',
  PRIMARY KEY (`uid`, `oid`)  COMMENT '',
  INDEX `fk_tbl_organization_users_tbl_organizations1_idx` (`oid` ASC)  COMMENT '',
  CONSTRAINT `fk_tbl_organization_users_tbl_users`
    FOREIGN KEY (`uid`)
    REFERENCES `ignite`.`ignite_users` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_organization_users_tbl_organizations1`
    FOREIGN KEY (`oid`)
    REFERENCES `ignite`.`ignite_organizations` (`oid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ignite`.`ignite_project_manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ignite`.`ignite_project_manager` (
  `ignite_users_uid` INT NOT NULL COMMENT '',
  `tbl_projects_pid` INT NOT NULL COMMENT '',
  PRIMARY KEY (`tbl_projects_pid`, `ignite_users_uid`)  COMMENT '',
  INDEX `fk_ignite_project_manager_has_ignite_users_ignite_users1_idx` (`ignite_users_uid` ASC)  COMMENT '',
  INDEX `fk_ignite_project_manager_has_ignite_users_tbl_projects1_idx` (`tbl_projects_pid` ASC)  COMMENT '',
  CONSTRAINT `fk_ignite_project_manager_has_ignite_users_ignite_users1`
    FOREIGN KEY (`ignite_users_uid`)
    REFERENCES `ignite`.`ignite_users` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ignite_project_manager_has_ignite_users_tbl_projects1`
    FOREIGN KEY (`tbl_projects_pid`)
    REFERENCES `ignite`.`tbl_projects` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
