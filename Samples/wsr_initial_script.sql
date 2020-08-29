# # # # # # # # # # # # # # # # # #
# WSR SCRIPTS Build
# # # # # # # # # # # # # # # # # #

DROP SCHEMA IF EXISTS pyramid_wsr;

CREATE SCHEMA pyramid_wsr;

USE pyramid_wsr;

DROP TABLE IF EXISTS users;

CREATE TABLE `users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  
  `username` VARCHAR(200) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `mobile` VARCHAR(200) NOT NULL,
  `role` INT(10) NOT NULL COMMENT '1-admin, 0-non-admin',
  `status` ENUM('0','1') NOT NULL,
  
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
   
   PRIMARY KEY (`id`) 
);

DROP TABLE IF EXISTS clients;

CREATE TABLE clients (
  `id` INT(11)  NOT NULL AUTO_INCREMENT,
  
  `client` VARCHAR(50) DEFAULT NULL,
  `client_name` VARCHAR(50) DEFAULT NULL,
  `client_type` VARCHAR(50) DEFAULT NULL, 
  `active` ENUM('0','1') NOT NULL,
  
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`id`)
) ;

DROP TABLE IF EXISTS projects;

CREATE TABLE projects (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  
  `project_id` INT(11) NOT NULL,
  `client_id` INT(11) NOT NULL,
  `project_name` VARCHAR(50) DEFAULT NULL,
  `project_desc` VARCHAR(150) DEFAULT NULL,
  
  `project_start_date` DATETIME DEFAULT NOW(),
  `project_end_date` DATETIME DEFAULT NOW(),
  `active` ENUM('0','1') NOT NULL,
  
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`id`),
  CONSTRAINT fk_client_1 FOREIGN KEY (client_id) REFERENCES clients (id) ON DELETE CASCADE ON UPDATE CASCADE
) ;


DROP TABLE IF EXISTS projects_status;

CREATE TABLE projects_status (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  
  `project_id` INT(11) NOT NULL,
  `date_id` INT(11) NOT NULL, 
  
  `timeline`  INT(11) NOT NULL, 
  `quality`  INT(11) NOT NULL, 
  `customer`  INT(11) NOT NULL, 
  `resources` INT(11) NOT NULL, 
  `achivements` VARCHAR(100),
  `update_comments` VARCHAR(500),

  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
   
  PRIMARY KEY (`id`),
  CONSTRAINT fk_project_1 FOREIGN KEY (project_id) REFERENCES projects (id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS projects_milestone;

CREATE TABLE projects_milestone (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  
  `project_status_id` INT(11) NOT NULL,
  
  `milestone` VARCHAR(150),
  `plan_date` DATETIME DEFAULT NULL,
  `actual_date` DATETIME DEFAULT NULL,
  `comments` VARCHAR(150),

  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  
   PRIMARY KEY (`id`),
   CONSTRAINT fk_project_status_1 FOREIGN KEY (project_status_id) REFERENCES projects_status (id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS projects_resources;

CREATE TABLE projects_resources (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  
  `project_id` INT(11) NOT NULL,
  `date_id` INT(11),  
  `user_id` INT(11),
  `user_billable` VARCHAR(15), 
  
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  
   PRIMARY KEY (`id`),
   CONSTRAINT fk_project_2 FOREIGN KEY (project_id) REFERENCES projects (id) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT fk_user_1 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS projects_activies;

CREATE TABLE projects_activies (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  
  `project_id` INT(11) NOT NULL,
  `date_id` INT(11),  
  
  `activity` VARCHAR(200),
  `activity_status` VARCHAR(15), 
  
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  
   PRIMARY KEY (`id`),
   CONSTRAINT fk_project_3 FOREIGN KEY (project_id) REFERENCES projects (id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS projects_risk;

CREATE TABLE projects_risk (
  `id` INT(11) NOT NULL AUTO_INCREMENT,

  `project_id` INT(11) NOT NULL,
  `date_id` INT(11),  
  
  `risk_name`  VARCHAR(50),  
  `risk_severiy` VARCHAR(50),   
  `risk_mitigation` VARCHAR(150),  
  
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
   
   PRIMARY KEY (`id`),
   CONSTRAINT fk_project_4 FOREIGN KEY (project_id) REFERENCES projects (id) ON DELETE CASCADE ON UPDATE CASCADE
);


DROP TABLE IF EXISTS date_details;

CREATE TABLE `date_details` (
  `date_id` INT(11) NOT NULL AUTO_INCREMENT,
  
  `fulldate` DATE DEFAULT NULL,
  `dayname`   VARCHAR(10) DEFAULT NULL,
  `week`      INTEGER NOT NULL,
  `monthnumber` INT(11) DEFAULT NULL,
  `monthname` VARCHAR(10) DEFAULT NULL,
  `year` INT(11) DEFAULT NULL,
  
  PRIMARY KEY (`date_id`)
);







