CREATE DATABASE `final_db`;

CREATE TABLE `bill` (
  `ID` int(11) NOT NULL,
  `guest_ID` int(11) DEFAULT NULL,
  `name_of_the_feature` varchar(45) DEFAULT NULL,
  `additional_expenditures` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  KEY `guest_ID_idx` (`guest_ID`),
  KEY `bill_fk_2_idx` (`name_of_the_feature`),
  CONSTRAINT `bill_fk_1` FOREIGN KEY (`guest_ID`) REFERENCES `guests` (`guest_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_fk_2` FOREIGN KEY (`name_of_the_feature`) REFERENCES `features` (`Name_of_the_feature`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `billing_history` (
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  `price` int(11) NOT NULL,
  `Name_of_the_feature` varchar(40) NOT NULL,
  `Hotel_ID` int(11) NOT NULL,
  `guest_ID` int(11) NOT NULL,
  PRIMARY KEY (`Hotel_ID`,`guest_ID`),
  KEY `guest_ID` (`guest_ID`),
  CONSTRAINT `billing_history_ibfk_1` FOREIGN KEY (`Hotel_ID`) REFERENCES `hotel` (`Hotel_ID`),
  CONSTRAINT `billing_history_ibfk_2` FOREIGN KEY (`guest_ID`) REFERENCES `guests` (`guest_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `category` (
  `Discount` int(11) NOT NULL,
  `Name_of_Category` varchar(40) NOT NULL,
  PRIMARY KEY (`Name_of_Category`,`Discount`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `day_discount` (
  `season_name` varchar(40) NOT NULL,
  `weekday` varchar(45) NOT NULL,
  `d_discount` int(11) NOT NULL,
  PRIMARY KEY (`weekday`,`d_discount`),
  KEY `for_key_1_idx` (`season_name`),
  CONSTRAINT `for_key_1` FOREIGN KEY (`season_name`) REFERENCES `seasons` (`season_name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `employer` (
  `employerID` int(11) NOT NULL,
  `Name` varchar(40) NOT NULL,
  `Phone_number` varchar(40) NOT NULL,
  `identification_type` int(11) NOT NULL,
  `IT_number` int(11) NOT NULL,
  `adress` varchar(40) NOT NULL,
  `Day_of_the_week` varchar(40) NOT NULL,
  `Start_Time` date NOT NULL,
  `End_time` date NOT NULL,
  `type` int(11) NOT NULL,
  `Hotel_ID` int(11) NOT NULL,
  `supervisor__employerID` int(11) DEFAULT NULL,
  PRIMARY KEY (`employerID`),
  KEY `Hotel_ID` (`Hotel_ID`),
  KEY `supervisor__employerID` (`supervisor__employerID`),
  CONSTRAINT `employer_ibfk_1` FOREIGN KEY (`Hotel_ID`) REFERENCES `hotel` (`Hotel_ID`),
  CONSTRAINT `employer_ibfk_2` FOREIGN KEY (`supervisor__employerID`) REFERENCES `employer` (`employerID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `features` (
  `Price_of_the_feature` int(11) NOT NULL,
  `Name_of_the_feature` varchar(40) NOT NULL,
  `Hotel_ID` int(11) NOT NULL,
  PRIMARY KEY (`Name_of_the_feature`),
  KEY `Hotel_ID` (`Hotel_ID`),
  CONSTRAINT `features_ibfk_1` FOREIGN KEY (`Hotel_ID`) REFERENCES `hotel` (`Hotel_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `guests` (
  `guest_ID` int(11) NOT NULL,
  `ID_type` int(11) NOT NULL,
  `Adress` varchar(40) NOT NULL,
  `home_phone_number` int(11) NOT NULL,
  `ID_number` int(11) NOT NULL,
  `mobile_phone_number` int(11) NOT NULL,
  `name_guest` varchar(40) NOT NULL,
  `Name_of_Category` varchar(40) NOT NULL,
  PRIMARY KEY (`guest_ID`,`mobile_phone_number`),
  UNIQUE KEY `guest_ID_UNIQUE` (`guest_ID`),
  KEY `Name_of_Category` (`Name_of_Category`),
  CONSTRAINT `guests_ibfk_1` FOREIGN KEY (`Name_of_Category`) REFERENCES `category` (`Name_of_Category`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `hotel` (
  `Hotel_ID` int(11) NOT NULL,
  `hotel_Name` varchar(40) NOT NULL,
  `Address` varchar(40) NOT NULL,
  `season_name` varchar(40) NOT NULL,
  PRIMARY KEY (`Hotel_ID`),
  KEY `season_name` (`season_name`),
  CONSTRAINT `hotel_ibfk_1` FOREIGN KEY (`season_name`) REFERENCES `seasons` (`season_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `hotel_phone_numbers` (
  `Phone_numbers` int(11) NOT NULL,
  `Hotel_ID` int(11) NOT NULL,
  PRIMARY KEY (`Phone_numbers`,`Hotel_ID`),
  KEY `Hotel_ID` (`Hotel_ID`),
  CONSTRAINT `hotel_phone_numbers_ibfk_1` FOREIGN KEY (`Hotel_ID`) REFERENCES `hotel` (`Hotel_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `occupying_currently` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Room_number` int(11) NOT NULL,
  `guest_ID` int(11) NOT NULL,
  `hotel_ID` int(11) NOT NULL,
  `number_people` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `Room_number_idx` (`Room_number`),
  KEY `guest_Id_idx` (`guest_ID`),
  KEY `hotel_Id_idx` (`hotel_ID`),
  CONSTRAINT `Room_number` FOREIGN KEY (`Room_number`) REFERENCES `room` (`Room_number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `guest_Id` FOREIGN KEY (`guest_ID`) REFERENCES `guests` (`guest_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `hotel_Id` FOREIGN KEY (`hotel_ID`) REFERENCES `hotel` (`Hotel_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

CREATE TABLE `price` (
  `Id` int(11) NOT NULL,
  `price` int(11) DEFAULT NULL,
  `typename` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `reservations` (
  `check_in` date NOT NULL,
  `check_out` date NOT NULL,
  `Hotel_ID` int(11) NOT NULL,
  `guest_ID` int(11) NOT NULL,
  `res_room_type` varchar(45) NOT NULL,
  `ID` int(11) NOT NULL,
  PRIMARY KEY (`Hotel_ID`,`res_room_type`,`guest_ID`,`ID`),
  KEY `guest_ID` (`guest_ID`),
  KEY `reservations_ibfk_3_idx` (`res_room_type`),
  CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`Hotel_ID`) REFERENCES `hotel` (`Hotel_ID`),
  CONSTRAINT `reservations_ibfk_2` FOREIGN KEY (`guest_ID`) REFERENCES `guests` (`guest_ID`),
  CONSTRAINT `reservations_ibfk_3` FOREIGN KEY (`res_room_type`) REFERENCES `room_types` (`Name_of_the_type`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `room` (
  `Room_number` int(11) NOT NULL,
  `floor` int(11) NOT NULL,
  `is_it_clean` int(11) NOT NULL,
  `Name_of_the_type` varchar(25) NOT NULL,
  `Hotel_ID` int(11) NOT NULL,
  PRIMARY KEY (`Room_number`,`Name_of_the_type`,`Hotel_ID`),
  KEY `Name_of_the_type` (`Name_of_the_type`,`Hotel_ID`),
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`Name_of_the_type`, `Hotel_ID`) REFERENCES `room_types` (`Name_of_the_type`, `Hotel_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `room_types` (
  `Name_of_the_type` varchar(25) NOT NULL,
  `size` int(11) NOT NULL,
  `capacity` int(11) NOT NULL,
  `Is_it_clean` int(11) NOT NULL,
  `is_Empty` int(11) NOT NULL,
  `Hotel_ID` int(11) NOT NULL,
  `price` int(11) DEFAULT NULL,
  PRIMARY KEY (`Name_of_the_type`,`Hotel_ID`),
  KEY `Hotel_ID` (`Hotel_ID`),
  CONSTRAINT `room_types_ibfk_1` FOREIGN KEY (`Hotel_ID`) REFERENCES `hotel` (`Hotel_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `room_types_features_of_room` (
  `features_of_room` int(11) NOT NULL,
  `Name_of_the_type` varchar(40) NOT NULL,
  `Hotel_ID` int(11) NOT NULL,
  PRIMARY KEY (`features_of_room`,`Name_of_the_type`,`Hotel_ID`),
  KEY `Name_of_the_type` (`Name_of_the_type`,`Hotel_ID`),
  CONSTRAINT `room_types_features_of_room_ibfk_1` FOREIGN KEY (`Name_of_the_type`, `Hotel_ID`) REFERENCES `room_types` (`Name_of_the_type`, `Hotel_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `seasons` (
  `season_name` varchar(40) NOT NULL,
  `Start_Date` date NOT NULL,
  `End_Date` date NOT NULL,
  `dicount` int(11) DEFAULT NULL,
  PRIMARY KEY (`season_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `who_else_occupying` (
  `who_else_occup` varchar(50) NOT NULL,
  `id` int(11) NOT NULL,
  KEY `id` (`id`),
  CONSTRAINT `who_else_occupying_ibfk_1` FOREIGN KEY (`id`) REFERENCES `occupying_currently` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `who_has_occupied_before` (
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  `Room_number` int(11) NOT NULL,
  `Name_of_the_type` varchar(40) NOT NULL,
  `Hotel_ID` int(11) NOT NULL,
  `guest_ID` int(11) NOT NULL,
  PRIMARY KEY (`Room_number`,`Name_of_the_type`,`Hotel_ID`,`guest_ID`),
  KEY `guest_ID` (`guest_ID`),
  CONSTRAINT `who_has_occupied_before_ibfk_1` FOREIGN KEY (`Room_number`, `Name_of_the_type`, `Hotel_ID`) REFERENCES `room` (`Room_number`, `Name_of_the_type`, `Hotel_ID`),
  CONSTRAINT `who_has_occupied_before_ibfk_2` FOREIGN KEY (`guest_ID`) REFERENCES `guests` (`guest_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

