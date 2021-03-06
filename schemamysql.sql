DROP DATABASE IF EXISTS hackXchange;

CREATE DATABASE hackXchange;

USE hackXchange;


DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS userscomments;
DROP TABLE IF EXISTS usersposts;

CREATE TABLE users
(
  user_id INT NOT NULL AUTO_INCREMENT,
  username VARCHAR(25) NOT NULL,
  password varchar(60) NOT NULL,
  hackcoin int NOT NULL DEFAULT 100,
  location VARCHAR(60) NULL,
  languages VARCHAR(60) NULL,
  github_handle VARCHAR(100) NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY (user_id)
);

-- ---
-- Table 'post'
--
-- ---

CREATE TABLE posts
(
  post_id INT NOT NULL AUTO_INCREMENT,
  user_id INT NOT NULL,
  title VARCHAR(50) NOT NULL,
  code VARCHAR(8000) DEFAULT NULL,
  votes INT DEFAULT 0,
  summary VARCHAR(8000) DEFAULT NULL,
  anon BOOLEAN DEFAULT FALSE,
  closed BOOLEAN DEFAULT FALSE,
  language VARCHAR(120) DEFAULT 'Other',
  solution_id INT DEFAULT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY (post_id),
  FOREIGN KEY (user_id) REFERENCES users (user_id)
  -- FOREIGN KEY (solution_id) REFERENCES comments (comment_id) THIS NEEDS TO BE ADDED IN AFTERWARDS
);

-- ---
-- Table 'comment'
--
-- ---

CREATE TABLE comments
(
  comment_id INT NOT NULL AUTO_INCREMENT,
  user_id INT NOT NULL,
  post_id INT NOT NULL,
  message VARCHAR(8000),
  votes INTEGER DEFAULT 0,
  solution boolean DEFAULT FALSE,
  active boolean DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY (comment_id),
  FOREIGN KEY (user_id) REFERENCES users (user_id),
  FOREIGN KEY (post_id) REFERENCES posts (post_id)
);

-- ---
-- Table 'userscomments'
--
-- ---

CREATE TABLE userscomments
( id INT NOT NULL AUTO_INCREMENT,
  user_id INT NOT NULL,
  comment_id INT NOT NULL,
  votes INTEGER DEFAULT 0,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users (user_id),
  FOREIGN KEY (comment_id) REFERENCES comments (comment_id)
);

-- ---
-- Table 'usersposts'
--
-- ---

CREATE TABLE usersposts
( id INT NOT NULL AUTO_INCREMENT,
  user_id INT NOT NULL,
  post_id INT NOT NULL,
  vote boolean DEFAULT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users (user_id),
  FOREIGN KEY (post_id) REFERENCES posts (post_id)
);

-- ---
-- Test Data
--
-- ---


insert into users
  (username, password, location, languages)
VALUES
  ('yaboi', '$2a$10$MCRlmB8bUswMTqKG.kURCu2pu8ipopli2LLaO5OODNokt44cpLZ56', 'Austin, Texas', 'Ruby, R, Python'),
  ('Gepeto', '$2a$10$pKgnmkFU5W7D70ekyEurruql72IonF7c5MiPlfnHrc9ywjrAF89Ou', 'Dallas, Texas', 'JavaScript, Python'),
  ('Zanbato', '$2a$10$pKgnmkFU5W7D70ekyEurruql72IonF7c5MiPlfnHrc9ywjrAF89Ou', 'San Antonio, Texas', 'JavaScript, R, Python'),
  ('Colonel', '$2a$10$pKgnmkFU5W7D70ekyEurruql72IonF7c5MiPlfnHrc9ywjrAF89Ou', 'Denver, Colorado', 'JavaScript, Ruby'),
  ('Hipster', '$2a$10$pKgnmkFU5W7D70ekyEurruql72IonF7c5MiPlfnHrc9ywjrAF89Ou', 'Boulder, Colorado', 'C++, Ruby, R, Python');
insert into posts
  (user_id, title, code, summary, language, solution_id)
VALUES
  (1, 'Get to the Choppa', 'aslkdjfleaf', 'Get to the choppa or die', 'JavaScript', 123456),
  (2, 'He is a real boy', 'hello world', 'Turn puppet into real boy', 'HTML', null),
  (3, 'A really big sword', 'chop chop its all in the mind', 'the ultimate onion chopper', 'Python', null),
  (4, 'How do you pronounce my name?', 'some military guy', 'Did not know how to say this till I was 25', 'JavaScript', null),
  (5, 'I hate everything', 'Your music sucks', 'Going to drink some IPAs', 'JavaScript', 234567);

insert into comments
  (user_id, post_id, message, votes)
VALUES
  (1, 1, 'Guns Blazing', 5),
  (2, 1, 'Think of the children!', 2),
  (3, 1, 'sword = shield', 525),
  (4, 1, 'Pulls out rocket launcher', 15),
  (5, 1, 'I used those before they were cool', 0);

-- mysql -u root < schemamysql.sql
