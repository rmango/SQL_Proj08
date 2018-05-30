DROP DATABASE IF EXISTS mcu;
CREATE DATABASE mcu;
USE mcu;
SHOW TABLES;

DROP TABLE IF EXISTS mcu.Person;
CREATE TABLE mcu.Person
(	
	PersonId	INT	UNSIGNED	PRIMARY KEY	AUTO_INCREMENT,
    FirstName	VARCHAR(45)	NOT NULL,
    LastName	VARCHAR(45)	NOT NULL,
    BirthDate	DATE,
    Oscars		ENUM('Winner','Nominee')	NULL
);


#DROP TABLE IF EXISTS mcu.Actor;
#CREATE TABLE mcu.Actor
#(
#	ActorId		INT	UNSIGNED PRIMARY KEY	AUTO_INCREMENT,
#    Name	VARCHAR(45)	NOT NULL,
#    BirthDate	DATE		NULL,
#    OscarWinner	ENUM('Winner','Nominee','Not Yet')
#);

#DROP TABLE IF EXISTS mcu.Director;
#CREATE TABLE mcu.Director
#(
#	DirectorId	INT UNSIGNED PRIMARY KEY	AUTO_INCREMENT,
#    FirstName	VARCHAR(45)	NOT NULL,
#    LastName 	VARCHAR(45)	NOT NULL,
#    BirthDate	DATE		NULL
#);

DROP TABLE IF EXISTS mcu.MovieDirector;
CREATE TABLE mcu.MovieDirector
(
	DirectorId	INT UNSIGNED,
    MovieId		INT UNSIGNED,
    CONSTRAINT	pk_director_movie_id
		PRIMARY KEY	(DirectorId, MovieId),
	CONSTRAINT	fk_directorId_person
		FOREIGN KEY	(DirectorId)
			REFERENCES	Person(PersonId)
            ON DELETE RESTRICT,
	CONSTRAINT	fk_movieId_movie
		FOREIGN KEY (MovieId)
			REFERENCES	Movie(MovieId)
            ON DELETE RESTRICT
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
    Platform	ENUM('Netflix','Hulu','ABC','Freeform'),
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
    Superpower		VARCHAR(45) NULL, 
    #SET('Flight','Speed','Intelligence','Wealth','Strength')	NULL, <-- change later, cant add data
    CharacterRole	ENUM('Hero','Villain','Anti-Hero','Neutral')				NULL,
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

INSERT INTO user
VALUES
	(1,'bhaken0','2017-10-25'),
	(2,'rchamperlen1','2017-07-30'),
	(3,'khenrion2','2018-04-06'),
	(4,'gborham3','2017-11-15'),
	(5,'prymer4','2017-06-27'),
	(6,'ndessent5','2018-05-20'),
	(7,'awescott6','2017-11-19'),
	(8,'efranks7','2017-07-22'),
	(9,'tweben8','2018-05-08'),
	(10,'nitzkovsky9','2018-01-17'),
	(11,'spoilerguy123','2017-11-11'),
	(12,'wtramelb','2018-01-06'),
	(13,'gklimkoc','2018-03-30');

INSERT INTO `character`
VALUES
	(1,'Tony Stark','Iron Man','Wealth','Hero',1),
	(2,'James Rhodes','War Machine','Suit','Hero',2),
	(3,'Obadiah Stane','Iron Monger','Suit','Villain',3),
	(4,'Yinsen',NULL,NULL,'Neutral',4),
	(5,'Pepper Pots',NULL,NULL,'Neutral',5),
	(6,'Nick Fury',NULL,NULL,'Hero',6),
	(7,'Bruce Banner','Hulk','Strength','Hero',7),
	(8,'Thaddeus Ross','Thunderbolt',NULL,'Anti-Hero',8),
	(9,'Natasha Romanoff','Black Widow',NULL,'Hero',9),
	(10,'Ivan Vanko','Whiplash','Suit','Villain',10),
	(11,'Thor',NULL,'Strength','Hero',11),
	(12,'Jane Foster',NULL,NULL,'Hero',12),
	(13,'Loki',NULL,'Trickery? Shape Shifting?','Anti-Hero',13),
	(14,'Erik Selvig',NULL,NULL,'Neutral',14),
	(15,'Heimdall',NULL,'Vision?','Hero',15),
	(16,'Odin',NULL,'Strength','Neutral',16),
	(17,'Frigga','NULL ',NULL,'Neutral',17),
	(18,'Clint Barton','Hawkeye','Bow and arrow lol','Hero',18),
	(19,'Phil Coulson',NULL,NULL,'Hero',19),
	(20,'Maria Hill',NULL,NULL,'Neutral',20),
	(21,'Steve Rogers','Captain America','Strength','Hero',21),
	(22,'Johann Schmidt','Red Skull',NULL,'Villain',22),
	(23,'Peggy Carter',NULL,NULL,'Hero',23),
	(24,'Bucky Barnes','Winter Soldier','Strength','Hero',24),
	(25,'Howard Stark',NULL,NULL,'Hero',25),
	(26,'Aldrich Killian','The Mandarin',NULL,'Villain',26),
	(27,'Happy Hogan',NULL,NULL,'Neutral',27),
	(28,'Malekith',NULL,NULL,'Villain',28),
	(29,'Sif',NULL,'??','Hero',29),
	(30,'Sam Wilson','Falcon','Suit','Hero',30),
	(31,'Brock Rumlow','Crossbone',NULL,'Villain',31),
	(32,'Sharon Carter','Agent 13',NULL,'Hero',32),
	(33,'Alexander Pierce',NULL,NULL,'Villain',33),
	(34,'Peter Quill','Star Lord',NULL,'Hero',34),
	(35,'Gamora',NULL,NULL,'Hero',35),
	(36,'Drax the Destroyer',NULL,'Strength','Hero',36),
	(37,'Groot','I am Groot','Tree?','Hero',37),
	(38,'Rocket',NULL,NULL,'Hero',38),
	(39,'Ronan the Accuser',NULL,'Strength','Villain',39),
	(40,'Yondu Udonta',NULL,NULL,'Anti-Hero',40),
	(41,'Nebula',NULL,NULL,'Anti-Hero',41),
	(42,'Teneleer Trivan','The Collector',NULL,'Neutral',42),
	(43,'Thanos',NULL,'Strenght','Villain',43),
	(44,'Pietro Maximoff','Quicksilver','Speed','Anti-Hero',44),
	(45,'Wanda Maximoff','Scarlet Witch','Telekenesis,Mind Control','Hero',45),
	(46,'Vision',NULL,'Fligth','Hero',46),
	(47,'Ultron',NULL,'robot?','Villain',47),
	(48,'Scott Lang','Ant Man','tiny','Hero',48),
	(49,'Hope van Dyne','Wasp','tiny','Hero',49),
	(50,'Darren Cross','Yellowjacket','tiny','Villain',50),
	(51,'Hank Pym',NULL,NULL,'Hero',51),
	(52,'T`Challa','Black Panther','Strength, Agility','Hero',52),
	(53,'Peter Parker','Spider Man','Agility,Sensory','Hero',53),
	(54,'Helmut Zemo',NULL,NULL,'Villain',54),
	(55,'Stephen Strange','Dr. Strange','Magic','Hero',55),
	(56,'Karl Mordo',NULL,'Magic','Hero',56),
	(57,'Wong',NULL,'Magic','Hero',57),
	(58,'Ancient One',NULL,'Magic','Hero',58),
	(59,'Mantis',NULL,'Mind Reading','Hero',59),
	(60,'Ayesha',NULL,NULL,'Villain',60),
	(61,'Taserface',NULL,NULL,'Villain',61),
	(62,'Ego',NULL,'Planet','Villain',62),
	(63,'Adrian Toomes','Vulture','Suit','Villain',63),
	(64,'Michelle Jones',NULL,NULL,'Neutral',64),
	(65,'Aaron Davis','Prowler',NULL,'Neutral',65),
	(66,'May Parker',NULL,NULL,'Neutral',66),
	(67,'Ned',NULL,NULL,'Hero',67),
	(68,'Hela',NULL,'Magic','Villain',68),
	(69,'Grandmaster',NULL,NULL,'Neutral',69),
	(70,'Valkryie',NULL,NULL,'Hero',70),
	(71,'Skurge',NULL,NULL,'Villain',71),
	(72,'Erik Stevens','Killmonger',NULL,'Villain',72),
	(73,'Nakia',NULL,NULL,'Hero',73),
	(74,'Okoye',NULL,NULL,'Hero',74),
	(75,'Everett K. Ross','NULL ',NULL,'Hero',75),
	(76,'W`Kabi',NULL,NULL,'Anti-Hero',76),
	(77,'Shuri',NULL,'Intellegence','Hero',77),
	(78,'M`Baku','Man Ape','Strength','Anti-Hero',78),
	(79,'Ulysses Klaue','Klaw','Technology','Villain',79),
	(80,'Eitri',NULL,NULL,'Neutral',80),
	(81,'Phil Coulson',NULL,NULL,'Hero',81),
	(82,'Melinda May',NULL,NULL,'Hero',82),
	(83,'Grant Ward','Hive','Possession','Villain',83),
	(84,'Daisy `Skye` Johnson`','Quake','Earthquakes','Hero',84),
	(85,'Jemma Simmons',NULL,'Intelligence','Hero',85),
	(86,'Elena `Yo-Yo` Rodriguez`','Yo-Yo','speed','Hero',86),
	(87,'Peggy Carter',NULL,NULL,'Hero',87),
	(88,'Edwin Jarvis',NULL,NULL,'Neutral',88),
	(89,'Black Bolt',NULL,'Sound','Hero',89),
	(90,'Medusa',NULL,'Hair','Hero',90),
	(91,'Karnak',NULL,NULL,'Hero',91),
	(92,'Gorgon',NULL,NULL,'Hero',92),
	(93,'Crystal',NULL,'Earth,Air,Fire,Water','Hero',93),
	(94,'Maximus',NULL,NULL,NULL,94),
	(95,'Matt Murdock','Daredevil',NULL,NULL,95),
	(96,'Karen Page',NULL,NULL,'Neutral',96),
	(97,'Elden Henson',NULL,NULL,NULL,97),
	(98,'Jessica Jones',NULL,'Strength, Flight','Hero',98),
	(99,'Luke Cage',NULL,'Strength','Hero',99),
	(100,'Kilgrave',NULL,'Mind control','Villain',100),
	(101,'Cornell `Cottonmouth` Stokes`',NULL,NULL,'Villain',101),
	(102,'Misty Knight',NULL,NULL,'Hero',102),
	(103,'Hernan `Shades` Alvarez`',NULL,NULL,'Villain',103),
	(104,'Danny Rand ','Iron Fist','Kung-fu and Iron Fist','Hero',104),
	(105,'Colleen Wing',NULL,NULL,'Hero',105),
	(106,'Ward Meachum',NULL,NULL,'Neutral',106),
	(107,'Frank Castle','Punisher',NULL,'Anti-Hero',107),
	(108,'David Lieberman','Micro',NULL,'Hero',108),
	(109,'Billy Russo',NULL,NULL,'Neutral',109),
	(110,'Alex Wilder',NULL,'Intelligence','Hero',110),
	(111,'Nico Minoru',NULL,NULL,'Hero',111),
	(112,'Karolina Dean',NULL,'Flight,Light shooting','Hero',112),
	(113,'Gert Yorkes',NULL,'Telepathy','Hero',113),
	(114,'Jonah',NULL,NULL,'Villain',114),
	(115,'Tandy Bowen','Dagger','Light shooting','Hero',115),
	(116,'Tyrone Johnson','Cloak','Darkness','Hero',116),
	(117,'Melissa Bowen',NULL,NULL,'Neutral',117);

INSERT INTO seriescharacter
VALUES
	(81,81,1),
	(82,82,1),
	(83,83,1),
	(84,84,1),
	(85,85,1),
	(86,86,1),
	(87,87,2),
	(88,88,2),
	(89,89,3),
	(90,90,3),
	(91,91,3),
	(92,92,3),
	(93,93,3),
	(94,94,3),
	(95,95,4),
	(95,95,8),
	(96,96,4),
	(96,96,8),
	(96,96,9),
	(97,97,4),
	(98,98,5),
	(98,98,8),
	(99,99,5),
	(99,99,6),
	(99,99,3),
	(100,100,5),
	(101,101,6),
	(102,102,6),
	(103,103,6),
	(104,104,7),
	(104,104,8),
	(105,105,7),
	(106,106,7),
	(107,107,9),
	(108,108,9),
	(109,109,9),
	(110,110,10),
	(111,111,10),
	(112,112,10),
	(113,113,10),
	(114,114,10),
	(115,115,11),
	(116,116,11),
	(117,117,11);
    
#sample queries
SELECT * 
FROM `Character`
WHERE CharacterRole = 'Villain';

