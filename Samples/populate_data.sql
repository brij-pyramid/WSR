ALTER TABLE `projects` DROP COLUMN `project_id`;

SET FOREIGN_KEY_CHECKS = 0; 

TRUNCATE TABLE users;

INSERT INTO `users` (`username`, `password`, `name`, `mobile`, `role`, `status`) VALUES 
('admin','password','Administrator',' ',1,1),
('username1', 'password', 'User Name 1', '99999 99999', '0', '1'),
('username2', 'password', 'User Name 2', '99999 99999', '0', '1'),
('username3', 'password', 'User Name 3', '99999 99999', '0', '0'),
('username4', 'password', 'User Name 4', '99999 99999', '0', '1'),
('username5', 'password', 'User Name 5', '99999 99999', '0', '1'),
('username6', 'password', 'User Name 6', '99999 99999', '0', '1'),
('username7', 'password', 'User Name 7', '99999 99999', '0', '1'),
('username8', 'password', 'User Name 8', '99999 99999', '0', '1'),
('username9', 'password', 'User Name 9', '99999 99999', '0', '1'),
('username10', 'password', 'User Name 10', '99999 99999', '0', '1'),
('username11', 'password', 'User Name 11', '99999 99999', '0', '1'),
('username12', 'password', 'User Name 12', '99999 99999', '0', '1'),
('username13', 'password', 'User Name 13', '99999 99999', '0', '1'),
('username14', 'password', 'User Name 14', '99999 99999', '0', '1'),
('username15', 'password', 'User Name 15', '99999 99999', '0', '1'),
('username16', 'password', 'User Name 16', '99999 99999', '0', '1'),
('username17', 'password', 'User Name 17', '99999 99999', '0', '1'),
('username18', 'password', 'User Name 18', '99999 99999', '0', '1'),
('username19', 'password', 'User Name 19', '99999 99999', '0', '1'),
('username20', 'password', 'User Name 20', '99999 99999', '0', '1'),
('username21', 'password', 'User Name 21', '99999 99999', '0', '1'),
('username22', 'password', 'User Name 22', '99999 99999', '0', '1'),
('username23', 'password', 'User Name 23', '99999 99999', '0', '1'),
('username24', 'password', 'User Name 24', '99999 99999', '0', '1'),
('username25', 'password', 'User Name 25', '99999 99999', '0', '1'),
('username26', 'password', 'User Name 26', '99999 99999', '0', '1'),
('username27', 'password', 'User Name 27', '99999 99999', '0', '1'),
('username28', 'password', 'User Name 28', '99999 99999', '0', '1'),
('username29', 'password', 'User Name 29', '99999 99999', '0', '1'),
('username30', 'password', 'User Name 30', '99999 99999', '0', '1'),
('username31', 'password', 'User Name 31', '99999 99999', '0', '1'),
('username32', 'password', 'User Name 32', '99999 99999', '0', '1'),
('username33', 'password', 'User Name 33', '99999 99999', '0', '1'),
('username34', 'password', 'User Name 34', '99999 99999', '0', '1'),
('username35', 'password', 'User Name 35', '99999 99999', '0', '1'),
('username36', 'password', 'User Name 36', '99999 99999', '0', '1'),
('username37', 'password', 'User Name 37', '99999 99999', '0', '1'),
('username38', 'password', 'User Name 38', '99999 99999', '0', '1'),
('username39', 'password', 'User Name 39', '99999 99999', '0', '1'),
('username40', 'password', 'User Name 40', '99999 99999', '0', '1'),
('username41', 'password', 'User Name 41', '99999 99999', '0', '1'),
('username42', 'password', 'User Name 42', '99999 99999', '0', '1'),
('username43', 'password', 'User Name 43', '99999 99999', '0', '1'),
('username44', 'password', 'User Name 44', '99999 99999', '0', '1'),
('username45', 'password', 'User Name 45', '99999 99999', '0', '1'),
('username46', 'password', 'User Name 46', '99999 99999', '0', '1'),
('username47', 'password', 'User Name 47', '99999 99999', '0', '1'),
('username48', 'password', 'User Name 48', '99999 99999', '0', '1'),
('username49', 'password', 'User Name 49', '99999 99999', '0', '1'),
('username50', 'password', 'User Name 50', '99999 99999', '0', '1');

TRUNCATE TABLE clients;

INSERT INTO `clients` (`client`, `client_name`, `client_type`, `active`) VALUES
('client 1','client name 1','Internal','0'),
('client 2','client name 2','External','0'),
('client 3','client name 3','External','0'),
('client 4','client name 4','External','0'),
('client 5','client name 5','Internal','0');

TRUNCATE TABLE projects;

INSERT INTO `projects` (`project_id`,`client_id`,`project_name`,`project_desc`,`project_start_date`,`project_end_date`,`active`) 
select  1, id , 'project name 1', 'project desc 1', STR_TO_DATE('2020-01-01', '%Y-%m-%d') , STR_TO_DATE('2020-06-30', '%Y-%m-%d') , 1 from clients where client_name = 'client name 1';

INSERT INTO `projects` (`project_id`,`client_id`,`project_name`,`project_desc`,`project_start_date`,`project_end_date`,`active`) 
select  2, id , 'project name 2', 'project desc 2', STR_TO_DATE('2020-06-01', '%Y-%m-%d') , STR_TO_DATE( '2020-07-31', '%Y-%m-%d'), 1 from clients where client_name = 'client name 1';

INSERT INTO `projects` (`project_id`,`client_id`,`project_name`,`project_desc`,`project_start_date`,`project_end_date`,`active`) 
select  3, id , 'project name 3', 'project desc 3', STR_TO_DATE('2020-02-01', '%Y-%m-%d') , STR_TO_DATE( '2020-12-31', '%Y-%m-%d'), 1 from clients where client_name = 'client name 1';

INSERT INTO `projects` (`project_id`,`client_id`,`project_name`,`project_desc`,`project_start_date`,`project_end_date`,`active`) 
select  4, id , 'project name 4', 'project desc 3', STR_TO_DATE('2020-05-01', '%Y-%m-%d') , STR_TO_DATE( '2021-01-31', '%Y-%m-%d'), 1 from clients where client_name = 'client name 1';


INSERT INTO `projects` (`project_id`,`client_id`,`project_name`,`project_desc`,`project_start_date`,`project_end_date`,`active`) 
select  5, id , 'project name aa', 'project desc aa', STR_TO_DATE('2020-02-01', '%Y-%m-%d') , STR_TO_DATE('2020-06-30', '%Y-%m-%d') , 1 from clients where client_name = 'client name 2';

INSERT INTO `projects` (`project_id`,`client_id`,`project_name`,`project_desc`,`project_start_date`,`project_end_date`,`active`) 
select  6, id , 'project name bb', 'project desc bb', STR_TO_DATE('2020-07-01', '%Y-%m-%d') , STR_TO_DATE( '2020-07-31', '%Y-%m-%d'), 1 from clients where client_name = 'client name 2';

INSERT INTO `projects` (`project_id`,`client_id`,`project_name`,`project_desc`,`project_start_date`,`project_end_date`,`active`) 
select  7, id , 'project name cc', 'project desc cc', STR_TO_DATE('2020-04-01', '%Y-%m-%d') , STR_TO_DATE( '2020-12-31', '%Y-%m-%d'), 1 from clients where client_name = 'client name 2';

INSERT INTO `projects` (`project_id`,`client_id`,`project_name`,`project_desc`,`project_start_date`,`project_end_date`,`active`) 
select  8, id , 'project name dd', 'project desc dd', STR_TO_DATE('2020-03-01', '%Y-%m-%d') , STR_TO_DATE( '2021-01-31', '%Y-%m-%d'), 1 from clients where client_name = 'client name 2';

INSERT INTO `projects` (`project_id`,`client_id`,`project_name`,`project_desc`,`project_start_date`,`project_end_date`,`active`) 
select  9, id , 'project name ee', 'project desc ee', STR_TO_DATE('2020-03-01', '%Y-%m-%d') , STR_TO_DATE( '2021-01-31', '%Y-%m-%d'), 1 from clients where client_name = 'client name 2';

INSERT INTO `projects` (`project_id`,`client_id`,`project_name`,`project_desc`,`project_start_date`,`project_end_date`,`active`) 
select  10, id , 'project name ff', 'project desc ff', STR_TO_DATE('2020-02-01', '%Y-%m-%d') , STR_TO_DATE( '2021-01-31', '%Y-%m-%d'), 1 from clients where client_name = 'client name 2';


TRUNCATE TABLE projects_status;

INSERT INTO `projects_status` (`project_id`, `date_id`, `timeline`, `quality`, `customer`, `resources`, `achivements`, `update_comments`)
select projects.id, date_details.date_id, '1', '1', '2','3', 'achivements', 'updates' from projects join date_details where projects.id = 1 and date_details.date_id = 1 ;

INSERT INTO `projects_status` (`project_id`, `date_id`, `timeline`, `quality`, `customer`, `resources`, `achivements`, `update_comments`)
select projects.id, date_details.date_id, '2', '3', '2','3', 'achivements', 'updates' from projects join date_details where projects.id = 1 and date_details.date_id = 2 ;

INSERT INTO `projects_status` (`project_id`, `date_id`, `timeline`, `quality`, `customer`, `resources`, `achivements`, `update_comments`)
select projects.id, date_details.date_id, '3', '5', '2','3', 'achivements', 'updates' from projects join date_details where projects.id = 1 and date_details.date_id = 3 ;

INSERT INTO `projects_status` (`project_id`, `date_id`, `timeline`, `quality`, `customer`, `resources`, `achivements`, `update_comments`)
select projects.id, date_details.date_id, '1', '3', '2','3', 'achivements', 'updates' from projects join date_details where projects.id = 1 and date_details.date_id = 4 ;

INSERT INTO `projects_status` (`project_id`, `date_id`, `timeline`, `quality`, `customer`, `resources`, `achivements`, `update_comments`)
select projects.id, date_details.date_id, '1', '2', '2','3', 'achivements', 'updates' from projects join date_details where projects.id = 1 and date_details.date_id = 5 ;

SET FOREIGN_KEY_CHECKS = 1;