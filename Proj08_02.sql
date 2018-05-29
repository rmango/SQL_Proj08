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
    Budget			DECIMAL(20,2), #check this
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

INSERT INTO director
VALUES
	(1,'Jon','Favrue','1966-10-19'),
	(2,'Louis','Leterrier','1973-06-17'),
	(3,'Kenneth','Branagh','1960-12-10'),
	(4,'Joe','Johnston','1950-05-13'),
	(5,'Joss','Whedon','1964-06-23'),
	(6,'Shane','Black','1961-12-16'),
	(7,'Alan','Taylor',NULL),
	(8,'Anthony','Russo','1970-02-03'),
	(9,'James','Gunn','1966-08-05'),
	(10,'Peyton','Reed','1964-07-03'),
	(11,'Scott','Derrickson','1966-07-16'),
	(12,'Jon','Watts','1981-06-28'),
	(13,'Taika','Waititi','1975-08-16'),
	(14,'Ryan','Coolger','1986-05-23');

INSERT INTO movie
VALUES
	(1,'Iron Man','7.9',585174222,1,'2008-05-02',140000000,1),
	(2,'The Incredible Hulk','6.8',263427551,2,'2008-06-13',150000000,1),
	(3,'Iron Man 2',7,623933331,1,'2010-05-07',200000000,1),
	(4,'Thor',7,449326618,3,'2011-05-06',150000000,1),
	(5,'Captain America: The First Avenger','6.9',370569774,4,'2011-07-21',140000000,1),
	(6,'Marvel`s The Avengers','8.1',1518812988,5,'2012-05-04',220000000,1),
	(7,'Iron Man 3','7.2',1214811252,6,'2013-05-03',178400000,2),
	(8,'Thor: The Dark World',7,644571402,7,'2013-11-08',152700000,2),
	(9,'Captain America: The Winter Soldier','7.8',714264267,8,'2014-04-04',177000000,2),
	(10,'Guardians of the Galaxy','8.1',773328629,9,'2014-08-01',195900000,2),
	(11,'Avengers: Age of Ultron','7.4',1405403694,5,'2015-05-01',365500000,2),
	(12,'Ant-Man','7.3',519311965,10,'2015-07-17',109300000,2),
	(13,'Captain America: Civil War','7.8',1153304495,8,'2016-05-06',250000000,3),
	(14,'Doctor Strange','7.5',677718395,11,'2016-11-04',165000000,3),
	(15,'Guardians of the Galaxy Vol. 2','7.7',863756051,9,'2017-05-05',200000000,3),
	(16,'Spider-Man: Homecoming','7.5',880166924,12,'2017-07-07',175000000,3),
	(17,'Thor: Ragnarok','7.9',853977126,13,'2017-11-03',180000000,3),
	(18,'Black Panther','7.7',1344028665,14,'2018-02-16',205000000,3),
	(19,'Avengers: Infinity War',9,1841081683,8,'2018-04-27',358000000,3),
	(20,'Ant-Man and the Wasp',NULL,NULL,10,'2018-07-06',NULL,3);

INSERT INTO series
VALUES
	(1,'Marvel`s Agents of S.H.I.E.L.D',73,'ABC','2013-09-24'),
	(2,'Marvel`s Agent Carter',18,'ABC','2015-01-06'),
	(3,'Marvel`s Inhumans',8,'ABC','2017-09-29'),
	(4,'Marvel`s Daredevil',26,'Netflix','2013-4-10'),
	(5,'Marvel`s Jessica Jones',26,'Netflix','2015-11-20'),
	(6,'Marvel`s Luke Cage',26,'Netflix','2016-09-30'),
	(7,'Marvel`s Iron Fist',23,'Netflix','2017-03-17'),
	(8,'Marvel`s The Defenders',8,'Netflix','2017-08-18'),
	(9,'Marvel`s The Punisher',13,'Netflix','2017-11-17'),
	(10,'Marvel`s Runaways',23,'Hulu','2018-11-21'),
	(11,'Marvel`s Cloak & Dagger',10,'Freeform','2018-06-07');




