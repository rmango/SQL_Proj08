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

DROP TABLE IF EXISTS mcu.Movie;
CREATE TABLE mcu.Movie
(
	MovieId			INT UNSIGNED PRIMARY KEY	AUTO_INCREMENT,
    Title			VARCHAR(45)	NOT NULL,
    Rating			DECIMAL(2,1),
    BoxOffice		DECIMAL(12,2),
    USReleaseDate	DATE,
    Budget			DECIMAL(20,2),
    Phase			TINYINT(1)
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
	UserId		INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    UserName	VARCHAR(45)	NOT NULL,
    MemberSince	DATE		NOT NULL
);

DROP TABLE IF EXISTS mcu.Character;
CREATE TABLE mcu.Character
(
	CharacterId		INT	UNSIGNED PRIMARY KEY	AUTO_INCREMENT,
    CharacterName	VARCHAR(45)		NOT NULL,
    Alias			VARCHAR(45)					NULL,
    Superpower		SET('Wealth','Strength','Speed','Flight','Suit','Intelligence','Weapon','Technology','Magic','Mind Control',
						'Earth','Fire','Water','Air','Size Alteration','Vision','Shape Shifting','Possession','Agility','Martial Arts','Tree',
                        'Light','Darkness')	NULL,
    CharacterRole	ENUM('Hero','Villain','Anti-Hero','Neutral')	NULL,
    ActorId			INT UNSIGNED NOT NULL,
	CONSTRAINT	fk_char_acto_id
		FOREIGN KEY (ActorId)
			REFERENCES Person(PersonId)
            		ON DELETE RESTRICT		
);

DROP TABLE IF EXISTS mcu.MovieDirector;
CREATE TABLE mcu.MovieDirector
(
	DirectorId	INT UNSIGNED,
    MovieId	INT UNSIGNED,
    CONSTRAINT
		PRIMARY KEY (DirectorId, MovieId),
	CONSTRAINT
		FOREIGN KEY (DirectorId)
			REFERENCES Person (PersonId),
	CONSTRAINT
		FOREIGN KEY (MovieId)
			REFERENCES Movie (MovieId)
);

DROP TABLE IF EXISTS mcu.MovieCharacter;
CREATE TABLE mcu.MovieCharacter
(
    MovieId	INT UNSIGNED,
	CharacterId	INT UNSIGNED,
    CONSTRAINT
		PRIMARY KEY (MovieId, CharacterId),
	CONSTRAINT
		FOREIGN KEY (MovieId)
			REFERENCES Movie (MovieId),
	CONSTRAINT
		FOREIGN KEY (CharacterId)
			REFERENCES `Character` (CharacterId)     
);

DROP TABLE IF EXISTS mcu.Comment;
CREATE TABLE mcu.Comment
(
	CommentId	INT UNSIGNED PRIMARY KEY	AUTO_INCREMENT,
	CommentText	VARCHAR(2048),
	CommentTime	DATETIME(6),
	UserId		INT UNSIGNED NOT NULL,
    CONSTRAINT
		FOREIGN KEY (UserId)
			REFERENCES User (UserId)
			ON DELETE RESTRICT
);

DROP TABLE IF EXISTS mcu.MovieComment;
CREATE TABLE mcu.MovieComment
(
	MovieId		INT	UNSIGNED,
    CommentId	INT UNSIGNED,
    CONSTRAINT
		PRIMARY KEY (MovieId, CommentId),        
	CONSTRAINT	
		FOREIGN KEY (MovieId)
			REFERENCES Movie (MovieId)
			ON DELETE RESTRICT,
	CONSTRAINT	
		FOREIGN KEY (CommentId)
			REFERENCES Comment (CommentId)
			ON DELETE RESTRICT	
);

DROP TABLE IF EXISTS mcu.SeriesComment;
CREATE TABLE mcu.SeriesComment
(
	SeriesId	INT	UNSIGNED,
    CommentId	INT UNSIGNED,
    CONSTRAINT
		PRIMARY KEY (SeriesId, CommentId),        
	CONSTRAINT	
		FOREIGN KEY (SeriesId)
			REFERENCES Series (SeriesId)
			ON DELETE RESTRICT,
	CONSTRAINT	
		FOREIGN KEY (CommentId)
			REFERENCES Comment (CommentId)
			ON DELETE RESTRICT	
);

DROP TABLE IF EXISTS mcu.SeriesCharacter;
CREATE TABLE mcu.SeriesCharacter
(
	CharacterId	INT UNSIGNED,
	SeriesId	INT	UNSIGNED,
	CONSTRAINT	pk_character_actor_series_id
		PRIMARY KEY (CharacterId, SeriesId),
	CONSTRAINT	#fk_link_character_id
		FOREIGN KEY (CharacterId)
			REFERENCES mcu.Character (CharacterId)
			ON DELETE RESTRICT,
	CONSTRAINT	#fk_link_series_id
		FOREIGN KEY (SeriesId)
			REFERENCES Series (SeriesId)
			ON DELETE RESTRICT
);

#adding data

INSERT INTO person
VALUES
	(1,'Robert','Downey Jr.','1965-04-04','Nominee'),
	(2,'Don','Cheadle','1969-03-11','Nominee'),
	(3,'Jeff','Bridges','1949-12-04','Winner'),
	(4,'Shaun','Toub','1963-04-06',NULL),
	(5,'Gwyneth','Paltrow','1972-09-27','Winner'),
	(6,'Samuel L.','Jackson','1948-12-21','Nominee'),
	(7,'Mark','Ruffalo','1967-11-22','Nominee'),
	(8,'William','Hurt','1950-03-20','Winner'),
	(9,'Scarlett','Johansson','1984-11-22',NULL),
	(10,'Mickey','Rourke','1952-09-16','Nominee'),
	(11,'Chris','Hemsworth','1983-08-11',NULL),
	(12,'Natalie','Portman','1981-06-09','Winner'),
	(13,'Tom','Hiddleston','1981-02-09',NULL),
	(14,'Stellan','Skarsgard','1951-06-13',NULL),
	(15,'Idris','Elba','1972-09-06',NULL),
	(16,'Anthony','Hopkins','1937-12-31','Winner'),
	(17,'Rene','Russo','1954-02-17',NULL),
	(18,'Jeremy','Renner','1971-01-07','Nominee'),
	(19,'Clark','Gregg','1962-04-02',NULL),
	(20,'Cobie','Smulders','1982-04-03',NULL),
	(21,'Chris','Evans','1981-06-13',NULL),
	(22,'Hugo','Weaving','1960-04-04',NULL),
	(23,'Hayley','Atwell','1982-04-05',NULL),
	(24,'Sebastian','Stan','1982-08-13',NULL),
	(25,'Dominic','Cooper','1978-06-02',NULL),
	(26,'Guy','Pearce','1967-10-05',NULL),
	(27,'Jon','Favrue','1966-10-19',NULL),
	(28,'Christopher','Eccleston','1964-02-16',NULL),
	(29,'Jaimie','Alexander','1984-03-12',NULL),
	(30,'Anthony','Mackie','1978-09-23',NULL),
	(31,'Frank','Grillo','1965-06-08',NULL),
	(32,'Emily','VanCamp','1986-05-12',NULL),
	(33,'Robert','Redford','1936-08-18','Winner'),
	(34,'Chris','Pratt','1979-06-21',NULL),
	(35,'Zoe','Saldana','1978-06-19',NULL),
	(36,'Dave','Bautista','1969-01-18',NULL),
	(37,'Vin','Diesel','1967-07-18',NULL),
	(38,'Bradley','Cooper','1975-01-05','Nominee'),
	(39,'Lee','Pace','1979-03-25',NULL),
	(40,'Michael','Rooker','1955-04-06',NULL),
	(41,'Karen','Gillan','1987-11-28',NULL),
	(42,'Benicio','del Toro','1967-02-19','Winner'),
	(43,'Josh','Brolin','1968-02-12','Nominee'),
	(44,'Aaron','Taylor-Johnson','1990-06-13',NULL),
	(45,'Elizabeth','Olsen','1989-02-16',NULL),
	(46,'Paul','Bettany','1971-05-27',NULL),
	(47,'James','Spader','1960-02-07',NULL),
	(48,'Paul','Rudd','1969-04-06',NULL),
	(49,'Evangeline','Lily','1979-08-03',NULL),
	(50,'Corey','Stoll','1976-03-04',NULL),
	(51,'Michael','Douglas','1944-09-25','Winner'),
	(52,'Chadwick','Boseman','1977-11-29',NULL),
	(53,'Tom','Holland','1996-06-01',NULL),
	(54,'Daniel','Bruhl','1978-06-16',NULL),
	(55,'Benedict','Cumberbatch','1976-07-19','Nominee'),
	(56,'Chiwetel','Ejiofor','1977-07-10','Nominee'),
	(57,'Benedict','Wong','1971-06-03',NULL),
	(58,'Tilda','Swinton','1960-11-05','Winner'),
	(59,'Pom','Klementieff','1986-05-03',NULL),
	(60,'Elizabeth','Debicki','1990-08-24',NULL),
	(61,'Chirs','Sullivan','1980-07-19',NULL),
	(62,'Kurt','Russell','1951-03-17',NULL),
	(63,'Michael','Keaton','1951-09-05','Nominee'),
	(64,'Zendaya','','1996-09-01',NULL),
	(65,'Donald','Glover','1983-09-25',NULL),
	(66,'Marisa','Tomei','1964-12-04','Winner'),
	(67,'Jacob','Batalon','1996-06-06',NULL),
	(68,'Cate','Blanchett','1969-05-14','Winner'),
	(69,'Jeff','Goldblum','1952-10-22',NULL),
	(70,'Tessa','Thompson','1983-10-03',NULL),
	(71,'Karl','Urban','1972-06-07',NULL),
	(72,'Michael B.','Jordan','1987-02-09',NULL),
	(73,'Lupita','Nyong`o','1983-03-01','Winner'),
	(74,'Danai','Gurira','1978-02-14',NULL),
	(75,'Martin','Freeman','1971-09-08',NULL),
	(76,'Daniel','Kaluuya','1989-02-24','Nominee'),
	(77,'Letitia','Wright','1993-10-31',NULL),
	(78,'Winston','Duke','1986-11-15',NULL),
	(79,'Andy','Serkis','1964-04-20',NULL),
	(80,'Peter','Dinklage','1969-06-11',NULL),
	(81,'Ming-Na','Wen','1963-11-20',NULL),
	(82,'Brett','Dalton','1983-01-07',NULL),
	(83,'Chloe','Bennet','1992-04-18',NULL),
	(84,'Elizabeth','Henstridge','1987-09-11',NULL),
	(85,'Natalia','Cordova-Buckley','1982-11-25',NULL),
	(86,'James','D`Arcy','1975-08-24',NULL),
	(87,'Anson','Mount','1973-02-25',NULL),
	(88,'Serinda','Swan','1984-07-11',NULL),
	(89,'Ken','Leung','1970-01-21',NULL),
	(90,'Eme','Ikwaukor','1984-08-13',NULL),
	(91,'Isabelle','Cornish','1994-07-24',NULL),
	(92,'Iwan','Rheon','1985-05-13',NULL),
	(93,'Charlie','Cox','1982-12-15',NULL),
	(94,'Deborah Ann','Woll','1985-02-07',NULL),
	(95,'Elden','Henson','1977-08-30',NULL),
	(96,'Krysten','Ritter','1981-12-16',NULL),
	(97,'Mike','Colter','1976-08-26',NULL),
	(98,'David','Tennant','1971-04-18',NULL),
	(99,'Mahershala','Ali','1974-02-16','Winner'),
	(100,'Simone','Missick','1982-01-19',NULL),
	(101,'Theo','Rossi','1975-06-04',NULL),
	(102,'Finn','Jones','1988-03-24',NULL),
	(103,'Jessica','Henwick','1992-08-30',NULL),
	(104,'Tom','Pelphrey','1982-07-28',NULL),
	(105,'Jon','Bernthal','1976-09-20',NULL),
	(106,'Ebon','Moss-Bachrach','1977-03-19',NULL),
	(107,'Ben','Barnes','1981-08-20',NULL),
	(108,'Rhenzy','Feliz','1997-10-26',NULL),
	(109,'Lyrica','Okano','1994-11-09',NULL),
	(110,'Virginia','Gardner','1995-04-18',NULL),
	(111,'Ariela','Barer','1998-10-14',NULL),
	(112,'Julian','McMahon','1968-07-27',NULL),
	(113,'Olivia','Holt','1997-08-05',NULL),
	(114,'Aubrey','Joseph','1997-11-26',NULL),
	(115,'Andrea','Roth','1967-09-30',NULL),
	(116,'Louis','Leterrier','1973-06-17',NULL),
	(117,'Kenneth','Branagh','1960-12-10',NULL),
	(118,'Joe','Johnston','1950-05-13','Winner'),
	(119,'Joss','Whedon','1964-06-23',NULL),
	(120,'Shane','Black','1961-12-16',NULL),
	(121,'Alan','Taylor',NULL,NULL),
	(122,'Anthony','Russo','1970-02-03',NULL),
	(123,'Joe','Russo','1971-07-08',NULL),
	(124,'James','Gunn','1966-08-05',NULL),
	(125,'Peyton','Reed','1964-07-03',NULL),
	(126,'Scott','Derrickson','1966-07-16',NULL),
	(127,'Jon','Watts','1981-06-28',NULL),
	(128,'Taika','Waititi','1975-08-16',NULL),
	(129,'Ryan','Coolger','1986-05-23',NULL),
	(130,'Forest','Whitaker','1961-07-15','Winner'),
	(131,'Terrence','Howard','1969-03-11','Nominee'),
	(132,'Edward','Norton','1969-08-18','Nominee'),
	(133,'Ben','Kingsley','1943-12-31','Winner');

INSERT INTO movie
VALUES
	(1,'Iron Man','7.9',585174222,'2008-05-02',140000000,1),
	(2,'The Incredible Hulk','6.8',263427551,'2008-06-13',150000000,1),
	(3,'Iron Man 2',7,623933331,'2010-05-07',200000000,1),
	(4,'Thor',7,449326618,'2011-05-06',150000000,1),
	(5,'Captain America: The First Avenger','6.9',370569774,'2011-07-21',140000000,1),
	(6,'Marvel`s The Avengers','8.1',1518812988,'2012-05-04',220000000,1),
	(7,'Iron Man 3','7.2',1214811252,'2013-05-03',178400000,2),
	(8,'Thor: The Dark World',7,644571402,'2013-11-08',152700000,2),
	(9,'Captain America: The Winter Soldier','7.8',714264267,'2014-04-04',177000000,2),
	(10,'Guardians of the Galaxy','8.1',773328629,'2014-08-01',195900000,2),
	(11,'Avengers: Age of Ultron','7.4',1405403694,'2015-05-01',365500000,2),
	(12,'Ant-Man','7.3',519311965,'2015-07-17',109300000,2),
	(13,'Captain America: Civil War','7.8',1153304495,'2016-05-06',250000000,3),
	(14,'Doctor Strange','7.5',677718395,'2016-11-04',165000000,3),
	(15,'Guardians of the Galaxy Vol. 2','7.7',863756051,'2017-05-05',200000000,3),
	(16,'Spider-Man: Homecoming','7.5',880166924,'2017-07-07',175000000,3),
	(17,'Thor: Ragnarok','7.9',853977126,'2017-11-03',180000000,3),
	(18,'Black Panther','7.7',1344028665,'2018-02-16',205000000,3),
	(19,'Avengers: Infinity War',9,1841081683,'2018-04-27',358000000,3),
	(20,'Ant-Man and the Wasp',NULL,NULL,'2018-07-06',NULL,3);
    
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

    
INSERT INTO `Character`
VALUES
	(1,'Tony Stark','Iron Man','Wealth,Flight','Hero',1),
	(2,'James Rhodes','War Machine','Suit,Flight','Hero',2),
	(3,'Obadiah Stane','Iron Monger','Suit','Villain',3),
	(4,'Yinsen',NULL,NULL,'Neutral',4),
	(5,'Pepper Pots',NULL,NULL,'Neutral',5),
	(6,'Nick Fury',NULL,NULL,'Hero',6),
	(7,'Bruce Banner','Hulk','Strength','Hero',7),
	(8,'Thaddeus Ross','Thunderbolt',NULL,'Anti-Hero',8),
	(9,'Natasha Romanoff','Black Widow','Martial Arts','Hero',9),
	(10,'Ivan Vanko','Whiplash','Suit','Villain',10),
	(11,'Thor',NULL,'Strength,Weapon,Flight','Hero',11),
	(12,'Jane Foster',NULL,NULL,'Hero',12),
	(13,'Loki',NULL,'Shape Shifting','Anti-Hero',13),
	(14,'Erik Selvig',NULL,NULL,'Neutral',14),
	(15,'Heimdall',NULL,'Vision','Hero',15),
	(16,'Odin',NULL,'Strength','Neutral',16),
	(17,'Frigga','NULL ',NULL,'Neutral',17),
	(18,'Clint Barton','Hawkeye','Weapon','Hero',18),
	(19,'Phil Coulson',NULL,NULL,'Hero',19),
	(20,'Maria Hill',NULL,NULL,'Neutral',20),
	(21,'Steve Rogers','Captain America','Strength,Agility,Martial Arts','Hero',21),
	(22,'Johann Schmidt','Red Skull',NULL,'Villain',22),
	(23,'Peggy Carter',NULL,NULL,'Hero',23),
	(24,'Bucky Barnes','Winter Soldier','Strength','Hero',24),
	(25,'Howard Stark',NULL,NULL,'Hero',25),
	(26,'Aldrich Killian','The Mandarin',NULL,'Villain',26),
	(27,'Happy Hogan',NULL,NULL,'Neutral',27),
	(28,'Malekith',NULL,'Magic','Villain',28),
	(29,'Sif',NULL,NULL,'Hero',29),
	(30,'Sam Wilson','Falcon','Suit,Flight','Hero',30),
	(31,'Brock Rumlow','Crossbone','Suit','Villain',31),
	(32,'Sharon Carter','Agent 13',NULL,'Hero',32),
	(33,'Alexander Pierce',NULL,NULL,'Villain',33),
	(34,'Peter Quill','Star Lord',NULL,'Hero',34),
	(35,'Gamora',NULL,'Martial Arts','Hero',35),
	(36,'Drax the Destroyer',NULL,'Strength','Hero',36),
	(37,'Groot','I am Groot','Tree','Hero',37),
	(38,'Rocket',NULL,'Weapon','Hero',38),
	(39,'Ronan the Accuser',NULL,'Strength','Villain',39),
	(40,'Yondu Udonta',NULL,'Weapon','Anti-Hero',40),
	(41,'Nebula',NULL,'Agility','Anti-Hero',41),
	(42,'Teneleer Trivan','The Collector',NULL,'Neutral',42),
	(43,'Thanos',NULL,'Strength','Villain',43),
	(44,'Pietro Maximoff','Quicksilver','Speed','Anti-Hero',44),
	(45,'Wanda Maximoff','Scarlet Witch','Magic,Mind Control','Hero',45),
	(46,'Vision',NULL,'Flight','Hero',46),
	(47,'Ultron',NULL,'Technology','Villain',47),
	(48,'Scott Lang','Ant Man','Size Alteration','Hero',48),
	(49,'Hope van Dyne','Wasp','Size Alteration','Hero',49),
	(50,'Darren Cross','Yellowjacket','Size Alteration','Villain',50),
	(51,'Hank Pym',NULL,NULL,'Hero',51),
	(52,'T`Challa','Black Panther','Strength,Agility,Martial Arts','Hero',52),
	(53,'Peter Parker','Spider Man','Agility','Hero',53),
	(54,'Helmut Zemo',NULL,NULL,'Villain',54),
	(55,'Stephen Strange','Dr, Strange','Magic','Hero',55),
	(56,'Karl Mordo',NULL,'Magic','Hero',56),
	(57,'Wong',NULL,'Magic','Hero',57),
	(58,'Ancient One',NULL,'Magic','Hero',58),
	(59,'Mantis',NULL,'Mind Control','Hero',59),
	(60,'Ayesha',NULL,NULL,'Villain',60),
	(61,'Taserface',NULL,NULL,'Villain',61),
	(62,'Ego',NULL,'Strength','Villain',62),
	(63,'Adrian Toomes','Vulture','Suit','Villain',63),
	(64,'Michelle Jones',NULL,NULL,'Neutral',64),
	(65,'Aaron Davis','Prowler',NULL,'Neutral',65),
	(66,'May Parker',NULL,NULL,'Neutral',66),
	(67,'Ned',NULL,NULL,'Hero',67),
	(68,'Hela',NULL,'Magic','Villain',68),
	(69,'Grandmaster',NULL,NULL,'Neutral',69),
	(70,'Valkryie',NULL,'Weapon','Hero',70),
	(71,'Skurge',NULL,NULL,'Villain',71),
	(72,'Erik Stevens','Killmonger',NULL,'Villain',72),
	(73,'Nakia',NULL,NULL,'Hero',73),
	(74,'Okoye',NULL,'Weapon','Hero',74),
	(75,'Everett K, Ross','NULL ',NULL,'Hero',75),
	(76,'W`Kabi',NULL,NULL,'Anti-Hero',76),
	(77,'Shuri',NULL,'Intelligence','Hero',77),
	(78,'M`Baku','Man Ape','Strength','Anti-Hero',78),
	(79,'Ulysses Klaue','Klaw','Technology','Villain',79),
	(80,'Eitri',NULL,NULL,'Neutral',80),
	(81,'Melinda May',NULL,NULL,'Hero',81),
	(82,'Grant Ward','Hive','Possession','Villain',82),
	(83,'`Daisy ``Skye`` Johnson`','Quake','Earth','Hero',83),
	(84,'Jemma Simmons',NULL,'Intelligence','Hero',84),
	(85,'Elena Rodriguez','Yo-Yo','Speed','Hero',85),
	(86,'Edwin Jarvis',NULL,NULL,'Neutral',86),
	(87,'Black Bolt',NULL,'Air','Hero',87),
	(88,'Medusa',NULL,'Magic','Hero',88),
	(89,'Karnak',NULL,NULL,'Hero',89),
	(90,'Gorgon',NULL,NULL,'Hero',90),
	(91,'Crystal',NULL,'Earth,Air,Fire,Water','Hero',91),
	(92,'Maximus',NULL,NULL,NULL,92),
	(93,'Matt Murdock','Daredevil',NULL,NULL,93),
	(94,'Karen Page',NULL,NULL,'Neutral',94),
	(95,'Elden Henson',NULL,NULL,NULL,95),
	(96,'Jessica Jones',NULL,'Strength,Flight','Hero',96),
	(97,'Luke Cage',NULL,'Strength','Hero',97),
	(98,'Kilgrave',NULL,'Mind control','Villain',98),
	(99,'Cornell Stokes','Cottonmouth',NULL,'Villain',99),
	(100,'Misty Knight',NULL,NULL,'Hero',100),
	(101,'Hernan Alvarez','Shades',NULL,'Villain',101),
	(102,'Danny Rand ','Iron Fist','Martial Arts','Hero',102),
	(103,'Colleen Wing',NULL,NULL,'Hero',103),
	(104,'Ward Meachum',NULL,NULL,'Neutral',104),
	(105,'Frank Castle','Punisher',NULL,'Anti-Hero',105),
	(106,'David Lieberman','Micro',NULL,'Hero',106),
	(107,'Billy Russo',NULL,NULL,'Neutral',107),
	(108,'Alex Wilder',NULL,'Intelligence','Hero',108),
	(109,'Nico Minoru',NULL,NULL,'Hero',109),
	(110,'Karolina Dean',NULL,'Flight,Light','Hero',110),
	(111,'Gert Yorkes',NULL,'Mind Control','Hero',111),
	(112,'Jonah',NULL,NULL,'VIllain',112),
	(113,'Tandy Bowen','Dagger','Light','Hero',113),
	(114,'Tyrone Johnson','Cloak','Darkness','Hero',114),
	(115,'Melissa Bowen',NULL,NULL,'Neutral',115),
	(116,'Trevor Slattery','The Mandarin',NULL,'Neutral',133),
	(117,'Korg',NULL,'Strength','Hero',128),
	(118,'Zuri',NULL,NULL,'Hero',130);

INSERT INTO movieDirector
	(MovieId,DirectorId)
VALUES
	(1,27),
	(2,116),
	(3,27),
	(4,117),
	(5,118),
	(6,119),
	(7,120),
	(8,121),
	(9,122),
	(9,123),
	(10,124),
	(11,119),
	(12,125),
	(13,122),
	(13,123),
	(14,126),
	(15,124),
	(16,127),
	(17,128),
	(18,129),
	(19,122),
	(19,123),
	(20,125);
    
INSERT INTO moviecharacter
	(MovieId, CharacterId)
VALUES
	(1,1),
	(2,1),
	(3,1),
	(6,1),
	(7,1),
	(11,1),
	(13,1),
	(16,1),
	(19,1),
	(1,2),
	(3,2),
	(7,2),
	(11,2),
	(13,2),
	(19,2),
	(1,3),
	(1,4),
	(7,4),
	(1,5),
	(3,5),
	(6,5),
	(16,5),
	(19,5),
	(1,6),
	(3,6),
	(4,6),
	(5,6),
	(6,6),
	(9,6),
	(11,6),
	(19,6),
	(2,7),
	(6,7),
	(7,7),
	(11,7),
	(19,7),
	(2,8),
	(13,8),
	(19,8),
	(1,9),
	(3,10),
	(4,11),
	(6,11),
	(8,11),
	(11,11),
	(14,11),
	(17,11),
	(19,11),
	(4,12),
	(8,12),
	(4,13),
	(6,13),
	(8,13),
	(17,13),
	(19,13),
	(4,14),
	(6,14),
	(8,14),
	(11,14),
	(4,15),
	(8,15),
	(11,15),
	(17,15),
	(19,15),
	(4,16),
	(8,16),
	(17,16),
	(4,17),
	(8,17),
	(4,18),
	(6,18),
	(11,18),
	(13,18),
	(1,19),
	(3,19),
	(4,19),
	(6,19),
	(6,20),
	(9,20),
	(11,20),
	(19,20),
	(5,21),
	(6,21),
	(8,21),
	(9,21),
	(11,21),
	(13,21),
	(16,21),
	(19,21),
	(5,22),
	(19,22),
	(5,23),
	(9,23),
	(11,23),
	(12,24),
	(5,24),
	(9,24),
	(13,24),
	(19,24),
	(1,25),
	(3,25),
	(5,25),
	(12,25),
	(13,25),
	(7,26),
	(1,27),
	(3,27),
	(7,27),
	(16,27),
	(8,28),
	(4,29),
	(8,29),
	(9,30),
	(11,30),
	(12,30),
	(13,30),
	(19,30),
	(9,31),
	(13,31),
	(9,32),
	(13,32),
	(9,33),
	(10,34),
	(15,34),
	(19,34),
	(10,35),
	(15,35),
	(19,35),
	(10,36),
	(15,36),
	(19,36),
	(10,37),
	(15,37),
	(19,37),
	(10,38),
	(15,38),
	(19,38),
	(10,39),
	(10,40),
	(15,40),
	(10,41),
	(15,41),
	(19,41),
	(8,42),
	(10,42),
	(19,42),
	(6,43),
	(10,43),
	(11,43),
	(19,43),
	(9,44),
	(11,44),
	(9,45),
	(11,45),
	(13,45),
	(19,45),
	(11,46),
	(13,46),
	(19,46),
	(11,47),
	(12,48),
	(13,48),
	(12,49),
	(12,50),
	(12,51),
	(13,52),
	(18,52),
	(19,52),
	(3,53),
	(13,53),
	(16,53),
	(19,53),
	(13,54),
	(14,55),
	(17,55),
	(19,55),
	(14,56),
	(14,57),
	(19,57),
	(14,58),
	(15,59),
	(19,59),
	(15,60),
	(15,61),
	(15,62),
	(16,63),
	(16,64),
	(16,65),
	(13,66),
	(16,66),
	(16,67),
	(19,67),
	(17,68),
	(15,69),
	(17,69),
	(17,70),
	(17,71),
	(18,72),
	(18,73),
	(18,74),
	(19,74),
	(13,75),
	(18,75),
	(18,76),
	(18,77),
	(19,77),
	(18,78),
	(19,78),
	(11,79),
	(18,79),
	(19,80),
    (7,116),
	(17,117),
	(18,118);

INSERT INTO comment
VALUES
	(1,'This movie sucks','2008-12-29 14:12:43',2),
	(2,'I really liked this movie','2013-10-24 20:24:09',12),
	(3,'I wish spiderman was in the mcu','2012-05-20 17:29:49',4),
	(4,'Thanos is the best villain in the mcu by far','2018-05-01 12:00:04',1),
	(5,'Loki is the only good villain the mcu has lol','2012-10-24 9:39:21',1),
	(6,'`Avengers: Infinity War manages together the following franchise not too deep, they`re being special effects and in a cliffhanger, ratings would do just met are heart to you! I always curious and the most epically satisfying on safe ground, relying on stunning when just a complete wasting its immense run time`','2017-12-10 19:47:48',3),
	(7,'`This movie a rotten score, this movie is fantasy. It was easily the MCU`s first 10 years, all while balancing numerous characters that for me, then this movie a rotten score, this 19th film that form between character the actors.??`','2017-12-10 19:47:48',4),
	(8,'`It`s not only the more thought amount of the movie to heart, humor a two part asses to be this well balanced`','2018-04-03 15:06:52',8),
	(9,'`Avenger, ratings would be this one of the movie.And I love all of cheesy, pretty decent they`re best mcu`','2017-09-24 6:00:09',9),
	(10,'`Infinity War manages together the Star thought that I can imagine, this well balanced`','2018-04-16 22:35:29',13),
	(11,'Everything happened. Some bits are a fan of the story! if you`ll never get movie. recommend highly for mindless summer action that an instant hit in ever-growing because I am always watched it. fun for this','2017-11-21 4:03:44',12),
	(12,'`Best Spider-Man has somehow mixing were definitely, not like a kid reading Ned. I am laughing like something to putting at Jacob Batalon for into more producer camera angles that was... Can and Shocker who quick witted, the skater-like some stupid`','2017-08-20 22:25:45',10),
	(13,'`The genre of the Star thought that I can chew. Thable or flat-out nonsensical comic book story was AMAZING. They have thought that just a complete was good to be in the critics who gave this well (without was added to make it entertainly the future, I mean, come on, Marvel in general, you should tank for event that we know where are funny and open mindless because I am always curious Project to date, but near. It`s hilarious about. Usually satisfying on stunning`','2017-05-22 0:15:41',6),
	(14,'Michelle who invents gadgets bonus point of the audienced played him to concur evil because of the script is.','2017-12-30 13:20:42',8),
	(15,'Contrary to witness the modern teenage life just a very much two hours? How did Zendaya make his superpower shines through another','2017-06-21 19:06:10',12),
	(16,'`Did not amazing many teen genetic mutational character of Peter parker, understanding Ned. I am laughing like that make him to concur evil because of a genetics. Spider-Man review.`','2017-08-02 3:15:42',2),
	(17,'`Spider-Mans power shines that doesn`t somehow mixing with human DNA some funny moments, in the fundamentals of fun`','2017-06-15 6:59:11',7),
	(18,'`I agree with both actor to be the strong point of a special suit, his enormous amounts of my all time favorites. I felt that have a Spider Man movie that made for the Easter reboot this money and although another his teen-aged romances an and although another good as the identity of the MCU!`','2017-06-09 22:27:11',7),
	(19,'`Iron Man reviously enjoyable. Spider-Man film to more entity of the Spider-Man somehow mixing a different another have a spected bag. In fantastic, the MCU, Spidermances. The Vulture are in the fun quickly because of Marisa Tom Holland is a unique abilities yet.`','2018-04-09 14:04:09',7),
	(20,'Grade us for to date.','2017-07-21 9:34:17',9),
	(21,'`Michael Keaton is and how relation, Spider-Man reboot that Tony and supposed on his own suit.... Can and the villains - Tomei as There definity to go about with his than augmenterplaying by Michael Keaton is pather good concentrate favorites. I love this concent MCU entity of our time. Hannibal Buress the different into more true charath`','2018-03-06 2:32:29',5),
	(22,'`Easily threw me of the character, and failing title. Spider-man fan out that wasn`t Mary Jane...also Flash isn`t some of Iron Man movie that Iron Man script is.`','2017-07-24 21:17:02',4),
	(23,'tom holland is THE Spider-Man has unique ability to concur evil because of the character Spider-Man anyone really well done It Again!','2017-08-08 10:07:30',4),
	(24,'`Delivers are acquired because of the strong, the like a kid really revealed to tug at Jacob Batalon for this is a 2017 American spirit of a genetics. Spider-Man movie was back where are this movie, way between peter had play the web slinger. The villains on set. Also did not the villain as Adrian tombs/vulture the modern teenage life just as well done`','2018-04-16 19:20:18',8),
	(25,'`Excellent, one of my favorite now :) Loved this is a very good villain in my opinion, humor and this movie`','2017-12-27 5:59:27',2),
	(26,'UTELY HILARIOUS!','2017-09-20 15:11:50',6),
	(27,'amazing movie seeing one of the comic-like the problems of the other Thor movie. One of rock man supporting this new management.','2017-09-07 22:34:52',5),
	(28,'An enjoyed the recent Guardians of yet.','2017-09-30 2:16:05',9),
	(29,'If she directed by the most important three. A deadly enjoyable among Marvel movie altogether.','2017-12-26 18:47:55',2),
	(30,'`Before it, maybe I missed this new characters since parts from being scenes..With a surprisingly good elements, climax, nor characters involved the end of to be served and please checking the MCU Movie I ended up and showed up and this one of my all-time favorite now that SHIELD is dealing we have become a movie. this movies! The First saw on CCTV that Shield.`','2017-03-13 7:10:15',5),
	(31,'`Civil War was given and lots of the list of good villain in my opinion, but they don`t everyone else and decided to see the entire affair way better for killed the art action the previous thor movie? Hulk vs Iron Man in my opinion of a film was puzzled by putting in Age of my all-time SHIELD`','2018-01-12 16:54:34',7),
	(32,'`Well the MCU, without super heroes fights Hulkbuster movie is back the film doesn`t even die. Robert Downey Jr. just made that I loved the most of world war hulk who because when the film.`','2017-12-18 16:52:03',10),
	(33,'`There the second half, but the right amount is able movies has done. The script has a brain.`','2017-06-03 14:22:42',11),
	(34,'`I had seen it almost predictable among Marvel villain Zemo, playing`','2017-11-28 10:29:24',3),
	(35,'Fans love this film and look at they see how it`s different during the continues Marvel`s Top 5','2018-02-18 20:55:23',6),
	(36,'There it to the trailer was some lame pathetic comedy with the Defenders. And so on.','2018-02-22 2:27:17',8),
	(37,'`I take thing and Spider-Man, Spider-Man fought thing astonishing really interesting to watch it`','2018-03-03 1:17:39',7),
	(38,'This movie seen it almost predictable romp of action battles. I thorough who wanted revengers and so far. It fixed all well done. The Vision with very humorous movie is back thing really terrible to showed you don`t even stay interesting to get them to be obsessed the budget it was hoping film of 2016 America: Civil War that it now :) Loved the same time','2018-03-18 2:44:29',2),
	(39,'`Excellent, one of Iron Fist film of 2016 America show off new antagonist and very funniest cameo was good element.`','2017-06-11 11:50:30',6),
	(40,'`An entertaining so why not liking to get back the Avengers movie. It feels liked through it (the transition to see any sense, like I had seen it being for killed the served and Rogers before it to all along. Even if you why not necesara.`','2018-01-10 17:26:53',12),
	(41,'`Fans loved thrown in. A new heroes set a new hero film is a joke? Because he blames even die. Robert Downey Jr. just phones fight in the Avenge on ever, so far. It feels like super nor characters involved, ever have died the new managements, it even see what we didn`t seen it almost of characters, but they all-time to the film`','2018-05-08 4:20:55',13),
	(42,'`There were are a little nauseating, and it almost impossible in the serious. Lets not being film based on the only casualty due to all the fact remains that the films and d`','2017-05-08 12:54:24',13),
	(43,'This series was great i loved the main character','2018-04-29 5:55:23',1),
	(44,'WOW great 10/10','2017-11-28 10:29:24',1),
	(45,'Watched entire series straight through did not sleep 2/10','2018-09-22 5:27:17',1);
    
INSERT INTO moviecomment
VALUES
	(8,1),
	(12,2),
	(4,3),
	(19,4),
	(8,5),
	(19,6),
	(19,7),
	(12,8),
	(11,9),
	(19,10),
	(18,11),
	(16,12),
	(16,16),
	(16,18),
	(16,20),
	(16,22),
	(16,24),
	(13,32),
	(2,33),
	(1,34),
	(2,35),
	(7,36),
	(16,38),
	(4,39),
	(7,40),
	(3,41);

INSERT INTO seriescomment
VALUES
	(1,14),
	(2,15),
	(8,17),
	(9,19),
	(10,21),
	(6,23),
	(11,25),
	(4,26),
	(4,27),
	(6,37),
	(3,42),
	(7,43),
	(6,44),
	(5,45),
	(5,13);

INSERT INTO seriescharacter
VALUES
	(6,1),
	(19,1),
	(21,2),
	(23,1),
	(23,2),
	(25,2),
	(29,1),
	(81,1),
	(82,1),
	(83,1),
	(84,1),
	(85,1),
	(86,2),
	(87,3),
	(88,3),
	(89,3),
	(90,3),
	(91,3),
	(92,3),
	(93,4),
	(93,8),
	(94,4),
	(94,8),
	(94,9),
	(95,4),
	(96,5),
	(96,8),
	(97,5),
	(97,8),
	(98,5),
	(98,6),
	(98,8),
	(99,6),
	(100,6),
	(101,6),
	(102,7),
	(102,8),
	(103,7),
	(104,7),
	(105,9),
	(106,9),
	(107,9),
	(108,10),
	(109,10),
	(110,10),
	(111,10),
	(112,10),
	(113,11),
	(114,11),
	(115,11);

/*
Sample queries and views
*/

#views
#view of character, movie, actor
DROP VIEW IF EXISTS character_movie_actor;
CREATE VIEW character_movie_actor AS
SELECT CharacterName, Title, CONCAT(Person.FirstName,' ',Person.LastName) AS ActorName
FROM Person
	JOIN `Character` ON ActorId = PersonId
	JOIN MovieCharacter USING(CharacterId)
    JOIN Movie USING(MovieId);

SELECT * FROM character_movie_actor;

#view of characters and actors
DROP VIEW IF EXISTS character_actor;
CREATE VIEW character_actor AS 
SELECT CONCAT(Person.FirstName,' ',Person.LastName) AS ActorName, CharacterName
FROM Person
	JOIN `Character` ON ActorId = PersonId;

SELECT * FROM character_actor;

#sample queries

#what character(s) did Gwyneth Paltrow play?
SELECT CharacterName, ActorName 
FROM character_actor
WHERE ActorName = 'Gwyneth Paltrow';

#get all actors from Thor
SELECT CONCAT(Person.FirstName,' ',Person.LastName) AS ActorName, CharacterName
FROM Person
	JOIN `Character`
		ON PersonId = ActorId
	JOIN MovieCharacter
		USING (CharacterId)
	JOIN Movie 
		USING (MovieId)
WHERE Title = 'Thor';
        
#gets all actors from Thor using view
SELECT ActorName, CharacterName
FROM character_movie_actor
WHERE Title = 'Thor';

#percent difference in movies with oscar winners and movies without
SELECT ROUND((ABS(YesOscar - NoOscar))/((YesOscar + NoOscar)/2)*100,2) AS PercentDifference
FROM (	
		SELECT AVG(Rating) AS 'NoOscar'
		FROM Movie
		WHERE 
		MovieId NOT IN (
			SELECT DISTINCT MovieId
			FROM Movie
				JOIN MovieDirector USING(MovieId)
				JOIN Person AS directorPerson ON DirectorId = PersonId
				JOIN MovieCharacter USING(MovieId)
				JOIN `Character` USING (CharacterId)
				JOIN Person AS actorPerson ON ActorId = actorPerson.PersonId
			WHERE directorPerson.Oscars = 'Winner' OR actorPerson.Oscars = 'Winner')) NoOscarMovieRating
	JOIN (
		SELECT AVG(Rating) AS 'YesOscar'
		FROM (
			SELECT DISTINCT Title, Rating
			FROM Movie
				JOIN MovieDirector USING(MovieId)
				JOIN Person AS directorPerson ON DirectorId = PersonId
				JOIN MovieCharacter USING(MovieId)
				JOIN `Character` USING (CharacterId)
				JOIN Person AS actorPerson ON ActorId = actorPerson.PersonId
			WHERE directorPerson.Oscars = 'Winner' OR actorPerson.Oscars = 'Winner') oscarMovie) OscarMovieRating;

# all comments from movies that Chris Hemsworth was in
SELECT Title, commentText
FROM comment
	JOIN movieComment USING(CommentId)
    JOIN movie USING(MovieId)
    JOIN movieCharacter USING(MovieId)
    JOIN `Character` USING(CharacterId)
    JOIN Person ON ActorId = PersonId
WHERE Person.FirstName = 'Chris' AND Person.LastName = 'Hemsworth';

#people that were born after 1989
SELECT * 
FROM Person
WHERE Birthdate > '1989-12-31'
ORDER BY Birthdate DESC;

#movies that have someone named chris
SELECT Title, LastName
FROM Movie
	JOIN MovieCharacter USING(MovieId)
    JOIN `Character` USING(CharacterId)
    JOIN Person ON PersonId = ActorId
WHERE Person.FirstName = 'Chris';
    
#movies that have someone named michael
SELECT Title, LastName
FROM Movie
	JOIN MovieCharacter USING(MovieId)
    JOIN `Character` USING(CharacterId)
    JOIN Person ON PersonId = ActorId
WHERE Person.FirstName = 'Michael';

#people who are both a director and an actor
SELECT DISTINCT FirstName, LastName
FROM Person
	JOIN `Character` 
		ON PersonId = ActorId
	JOIN MovieDirector
		ON PersonId = DirectorId
WHERE PersonId = ActorId AND PersonId = DirectorId;




