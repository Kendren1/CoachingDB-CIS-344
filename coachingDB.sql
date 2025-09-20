-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema CoachingDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema CoachingDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CoachingDB` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `CoachingDB` ;

-- -----------------------------------------------------
-- Table `CoachingDB`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CoachingDB`.`Client` (
  `ClientID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  `Email` VARCHAR(150) NOT NULL,
  `Phone` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`ClientID`),
  UNIQUE INDEX `Email` (`Email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CoachingDB`.`Coach`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CoachingDB`.`Coach` (
  `CoachID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  `Email` VARCHAR(150) NOT NULL,
  `Expertise` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`CoachID`),
  UNIQUE INDEX `Email` (`Email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CoachingDB`.`Session`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CoachingDB`.`Session` (
  `SessionID` INT NOT NULL AUTO_INCREMENT,
  `CoachID` INT NOT NULL,
  `ClientID` INT NOT NULL,
  `SessionDate` DATETIME NOT NULL,
  `Duration` INT NULL DEFAULT NULL,
  `Status` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`SessionID`),
  INDEX `CoachID` (`CoachID` ASC) VISIBLE,
  INDEX `ClientID` (`ClientID` ASC) VISIBLE,
  CONSTRAINT `session_ibfk_1`
    FOREIGN KEY (`CoachID`)
    REFERENCES `CoachingDB`.`Coach` (`CoachID`),
  CONSTRAINT `session_ibfk_2`
    FOREIGN KEY (`ClientID`)
    REFERENCES `CoachingDB`.`Client` (`ClientID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CoachingDB`.`Feedback`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CoachingDB`.`Feedback` (
  `FeedbackID` INT NOT NULL AUTO_INCREMENT,
  `SessionID` INT NOT NULL,
  `ClientID` INT NOT NULL,
  `Rating` INT NULL DEFAULT NULL,
  `Comments` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`FeedbackID`),
  INDEX `SessionID` (`SessionID` ASC) VISIBLE,
  INDEX `ClientID` (`ClientID` ASC) VISIBLE,
  CONSTRAINT `feedback_ibfk_1`
    FOREIGN KEY (`SessionID`)
    REFERENCES `CoachingDB`.`Session` (`SessionID`),
  CONSTRAINT `feedback_ibfk_2`
    FOREIGN KEY (`ClientID`)
    REFERENCES `CoachingDB`.`Client` (`ClientID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CoachingDB`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CoachingDB`.`Payment` (
  `PaymentID` INT NOT NULL AUTO_INCREMENT,
  `SessionID` INT NOT NULL,
  `PaymentDate` DATE NOT NULL,
  `Amount` DECIMAL(10,2) NOT NULL,
  `PaymentMethod` VARCHAR(50) NULL DEFAULT NULL,
  `PaymentStatus` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`PaymentID`),
  INDEX `SessionID` (`SessionID` ASC) VISIBLE,
  CONSTRAINT `payment_ibfk_1`
    FOREIGN KEY (`SessionID`)
    REFERENCES `CoachingDB`.`Session` (`SessionID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
