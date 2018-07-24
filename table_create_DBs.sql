GRANT USAGE ON *.* TO 'amg_server'@'localhost';
DROP USER 'amg_server'@'localhost';
DROP DATABASE IF EXISTS amg;
CREATE DATABASE amg;
CREATE USER 'amg_server'@'localhost' IDENTIFIED BY 'amg_server';
GRANT ALL ON amg.* TO 'amg_server'@'localhost';
