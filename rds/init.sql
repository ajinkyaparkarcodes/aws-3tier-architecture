CREATE DATABASE sampledb;
USE sampledb;

CREATE TABLE messages (
  id INT AUTO_INCREMENT PRIMARY KEY,
  content VARCHAR(255)
);

INSERT INTO messages (content) VALUES ('Hello from DB!');
