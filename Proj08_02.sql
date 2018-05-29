DROP DATABASE IF EXISTS mcu;
CREATE DATABASE mcu;
USE mcu;
SHOW TABLES;

DROP TABLE IF EXISTS mcu.Actor;
CREATE TABLE mcu.Actor
(
	ActorId		INT	UNSIGNED PRIMARY KEY	AUTO_INCREMENT,
    Name	VARCHAR(45)	NOT NULL,
    BirthDate	DATE		NULL,
    OscarWinner	ENUM('Winner','Nominee','Not Yet')
);

DROP TABLE IF EXISTS mcu.Director;
CREATE TABLE mcu.Director
(
	DirectorId	INT UNSIGNED PRIMARY KEY	AUTO_INCREMENT,
    FirstName	VARCHAR(45)	NOT NULL,
    LastName 	VARCHAR(45)	NOT NULL,
    BirthDate	DATE		NULL
);

DROP TABLE IF EXISTS mcu.Movie;
CREATE TABLE mcu.Movie
(
	MovieId			INT UNSIGNED PRIMARY KEY	AUTO_INCREMENT,
    Title			VARCHAR(45),
    Rating			DECIMAL(2,1),
    BoxOffice		DECIMAL(12,2),
    DirectorId		INT UNSIGNED,
    USReleaseDate	DATE,
    Budget			DECIMAL(10,2),
    Phase			TINYINT(1),
	CONSTRAINT	fk_movi_director_id
		FOREIGN KEY (DirectorId)
			REFERENCES Director(DirectorId)
			ON DELETE RESTRICT
);

DROP TABLE IF EXISTS mcu.Series;
CREATE TABLE mcu.Series
(
	SeriesId	INT UNSIGNED PRIMARY KEY	AUTO_INCREMENT,
    SeriesName	VARCHAR(45)	NOT NULL,
    NumEpisodes	TINYINT(3)	NOT NULL,
    Platform	ENUM('Netflix','Hulu','ABC'),
    FirstAired	DATE		NOT NULL
);

DROP TABLE IF EXISTS mcu.User;
CREATE TABLE mcu.User
(
	UserId		INT UNSIGNED PRIMARY KEY	AUTO_INCREMENT,
    UserName	VARCHAR(45)	NOT NULL,
    MemberSince	DATE		NOT NULL
);

DROP TABLE IF EXISTS mcu.Character;
CREATE TABLE mcu.Character
(
	CharacterId		INT	UNSIGNED	AUTO_INCREMENT,
    CharacterName	VARCHAR(45),
    Alias			VARCHAR(45)													NULL,
    Superpower		SET('Flight','Speed','Intelligence','Wealth','Strength')	NULL,
    CharacterRole	ENUM('Hero','Villain','Anti Hero')				NULL,
    ActorId			INT UNSIGNED,
    CONSTRAINT 	pk_char_acto_id
		PRIMARY KEY (CharacterId, ActorId),
	CONSTRAINT	fk_char_acto_id
		FOREIGN KEY (ActorId)
			REFERENCES Actor(ActorId)
            		ON DELETE RESTRICT		
);

DROP TABLE IF EXISTS mcu.MovieComments;
CREATE TABLE mcu.MovieComments
(
	MovieCommentId	INT PRIMARY KEY	AUTO_INCREMENT,
	CommentText	VARCHAR(45),
	CommentTime	DATETIME(6),
	UserId		INT UNSIGNED,
	MovieId		INT	UNSIGNED,
	CONSTRAINT	fk_comment_user_movie_id
		FOREIGN KEY (UserId)
			REFERENCES User (UserId)
			ON DELETE RESTRICT,
	CONSTRAINT	fk_comment_movie_id
		FOREIGN KEY (MovieId)
			REFERENCES Movie (MovieId)
			ON DELETE RESTRICT
);

DROP TABLE IF EXISTS mcu.SeriesComments;
CREATE TABLE mcu.SeriesComments
(
	SeriesCommentId	INT PRIMARY KEY	AUTO_INCREMENT,
	CommentText	VARCHAR(45),
	CommentTime	DATETIME(6),
	UserId		INT UNSIGNED,
	SeriesId	INT	UNSIGNED,
	CONSTRAINT	fk_comment_user_series_id
		FOREIGN KEY (UserId)
			REFERENCES User (UserId)
			ON DELETE RESTRICT,
	CONSTRAINT	fk_comment_series_id
		FOREIGN KEY (SeriesId)
			REFERENCES Series (SeriesId)
			ON DELETE RESTRICT
);

#LINKING TABLE FOR CHARATERS AND MOVIE
DROP TABLE IF EXISTS mcu.MovieCharacter;
CREATE TABLE mcu.MovieCharacter
(
	CharacterId	INT	UNSIGNED,
	ActorId		INT	UNSIGNED,
	MovieId		INT	UNSIGNED,
	CONSTRAINT	pk_character_actor_movie_id
		PRIMARY KEY (CharacterId, ActorId, MovieId),
	CONSTRAINT	fk_link_character_id
		FOREIGN KEY (CharacterId)
			REFERENCES mcu.Character (CharacterId)
			ON DELETE RESTRICT,
	CONSTRAINT	fk_link_movie_id
		FOREIGN KEY (MovieId)
			REFERENCES Movie (MovieId)
			ON DELETE RESTRICT,
	CONSTRAINT	fk_link_actor_id
		FOREIGN KEY (ActorId)
			REFERENCES mcu.Character (ActorId)
			ON DELETE RESTRICT
);

DROP TABLE IF EXISTS mcu.SeriesCharacter;
CREATE TABLE mcu.SeriesCharacter
(
	CharacterIdSeries	INT UNSIGNED,
	ActorIdSeries		INT	UNSIGNED,
	SeriesIdSeries	INT	UNSIGNED,
	CONSTRAINT	pk_character_actor_series_id
		PRIMARY KEY (CharacterIdSeries, ActorIdSeries, SeriesIdSeries),
	CONSTRAINT	#fk_link_character_id
		FOREIGN KEY (CharacterIdSeries)
			REFERENCES mcu.Character (CharacterId)
			ON DELETE RESTRICT,
	CONSTRAINT	#fk_link_series_id
		FOREIGN KEY (SeriesIdSeries)
			REFERENCES Series (SeriesId)
			ON DELETE RESTRICT,
	CONSTRAINT	#fk_link_actor_id
		FOREIGN KEY (ActorIdSeries)
			REFERENCES mcu.Character (ActorId)
			ON DELETE RESTRICT
);


#adding data

INSERT INTO actor
VALUES
	(1,'Robert Downey Jr.','1965-04-04','Nominee'),
	(2,'Don Cheadle','1969-03-11','Nominee'),
	(3,'Jeff Bridges','1949-12-04','Winner'),
	(4,'Shaun Toub','1963-04-06','Not yet'),
	(5,'Gwyneth Paltrow','1972-09-27','Winner'),
	(6,'Samuel L. Jackson','1948-12-21','Nominee'),
	(7,'Mark Ruffalo','1967-11-22','Nominee'),
	(8,'William Hurt','1950-03-20','Winner'),
	(9,'Scarlett Johansson',NULL,NULL),
	(10,'Mickey Rourke',NULL,NULL),
	(11,'Chris Hemsworth',NULL,NULL),
	(12,'Natalie Portman',NULL,NULL),
	(13,'Tom Hiddleston',NULL,NULL),
	(14,'Stellan Skarsgard',NULL,NULL),
	(15,'Idris Elba',NULL,NULL),
	(16,'Anthony Hopkins',NULL,NULL),
	(17,'Rene Russo',NULL,NULL),
	(18,'Jeremy Renner',NULL,NULL),
	(19,'Clark Gregg',NULL,NULL),
	(20,'Cobie Smulders',NULL,NULL),
	(21,'Chris Evans',NULL,NULL),
	(22,'Hugo Weaving',NULL,NULL),
	(23,'Hayley Atwell',NULL,NULL),
	(24,'Sebastian Stan',NULL,NULL),
	(25,'Dominic Cooper',NULL,NULL),
	(26,'Guy Pearce',NULL,NULL),
	(27,'Jon Favrue',NULL,NULL),
	(28,'Christopher Eccleston',NULL,NULL),
	(29,'Jaimie Alexander',NULL,NULL),
	(30,'Anthony Mackie',NULL,NULL),
	(31,'Frank Grillo',NULL,NULL),
	(32,'Emily VanCamp',NULL,NULL),
	(33,'Robert Redford',NULL,NULL),
	(34,'Chris Pratt',NULL,NULL),
	(35,'Zoe Saldana',NULL,NULL),
	(36,'Dave Bautista',NULL,NULL),
	(37,'Vin Diesel',NULL,NULL),
	(38,'Bradley Cooper',NULL,NULL),
	(39,'Lee Pace',NULL,NULL),
	(40,'Michael Rooker',NULL,NULL),
	(41,'Karen Gillan',NULL,NULL),
	(42,'Benicio del Toro',NULL,NULL),
	(43,'Josh Brolin',NULL,NULL),
	(44,'Aaron Taylor-Johnson',NULL,NULL),
	(45,'Elizabeth Olsen',NULL,NULL),
	(46,'Paul Bettany',NULL,NULL),
	(47,'James Spader',NULL,NULL),
	(48,'Paul Rudd',NULL,NULL),
	(49,'Evangeline Lily',NULL,NULL),
	(50,'Corey Stoll',NULL,NULL),
	(51,'Michael Douglas',NULL,NULL),
	(52,'Chadwick Boseman',NULL,NULL),
	(53,'Tom Holland',NULL,NULL),
	(54,'Daniel Bruhl',NULL,NULL),
	(55,'Benedict Cumberbatch',NULL,NULL),
	(56,'Chiwetel Ejiofor',NULL,NULL),
	(57,'Benedict Wong',NULL,NULL),
	(58,'Tilda Swinton',NULL,NULL),
	(59,'Pom Klementieff',NULL,NULL),
	(60,'Elizabeth Debicki',NULL,NULL),
	(61,'Chirs Sullivan',NULL,NULL),
	(62,'Kurt Russell',NULL,NULL),
	(63,'Michael Keaton',NULL,NULL),
	(64,'Zendaya',NULL,NULL),
	(65,'Donald Glover',NULL,NULL),
	(66,'Marisa Tomei',NULL,NULL),
	(67,'Jacob Batalon',NULL,NULL),
	(68,'Cate Blanchett',NULL,NULL),
	(69,'Jeff Goldblum',NULL,NULL),
	(70,'Tessa Thompson',NULL,NULL),
	(71,'Karl Urban',NULL,NULL),
	(72,'Michael B. Jordan',NULL,NULL),
	(73,'Lupita Nyong`o',NULL,NULL),
	(74,'Danai Gurira',NULL,NULL),
	(75,'Martin Freeman',NULL,NULL),
	(76,'Daniel Kaluuya',NULL,NULL),
	(77,'Letitia Wright',NULL,NULL),
	(78,'Winston Duke',NULL,NULL),
	(79,'Andy Serkis',NULL,NULL),
	(80,'Peter Dinklage',NULL,NULL),
	(81,'Clark Gregg','1962-04-02','Not yet'),
	(82,'Ming-Na Wen','1963-11-20','Not yet'),
	(83,'Brett Dalton','1983-01-07','Not yet'),
	(84,'Chloe Bennet','1992-04-18','Not yet'),
	(85,'Elizabeth Henstridge','1987-09-11','Not yet'),
	(86,'Natalia Cordova-Buckley','1982-11-25','Not yet'),
	(87,'Hayley Atwell ','1982-04-05','Not yet'),
	(88,'James D`Arcy ','1975-08-24','Not yet'),
	(89,'Anson Mount','1973-02-25','Not yet'),
	(90,'Serinda Swan','1984-07-11','Not yet'),
	(91,'Ken Leung','1970-01-21','Not yet'),
	(92,'Eme Ikwaukor','1984-08-13','Not yet'),
	(93,'Isabelle Cornish','1994-07-24','Not yet'),
	(94,'Iwan Rheon','1985-05-13','Not yet'),
	(95,'Charlie Cox','1982-12-15','Not yet'),
	(96,'Deborah Ann Woll','1985-02-07','Not yet'),
	(97,'Elden Henson','1977-08-30','Not yet'),
	(98,'Krysten Ritter',NULL,NULL),
	(99,'Mike Colter',NULL,NULL),
	(100,'David Tennant',NULL,NULL),
	(101,'Mahershala Ali',NULL,NULL),
	(102,'Simone Missick',NULL,NULL),
	(103,'Theo Rossi',NULL,NULL),
	(104,'Finn Jones',NULL,NULL),
	(105,'Jessica Henwick',NULL,NULL),
	(106,'Tom Pelphrey',NULL,NULL),
	(107,'Jon Bernthal',NULL,NULL),
	(108,'Ebon Moss-Bachrach ',NULL,NULL),
	(109,'Ben Barnes',NULL,NULL),
	(110,'Rhenzy Feliz',NULL,NULL),
	(111,'Lyrica Okano ',NULL,NULL),
	(112,'Virginia Gardner',NULL,NULL),
	(113,'Ariela Barer',NULL,NULL),
	(114,'Julian McMahon',NULL,NULL),
	(115,'Olivia Holt',NULL,NULL),
	(116,'Aubrey Joseph ',NULL,NULL),
	(117,'Andrea Roth',NULL,NULL);


SELECT * FROM actor;




