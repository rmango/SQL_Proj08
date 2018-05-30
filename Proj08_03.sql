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
    Title			VARCHAR(45),
    Rating			DECIMAL(2,1),
    BoxOffice		DECIMAL(12,2),
    USReleaseDate	DATE,
    Budget			DECIMAL(20,2), #check this
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
	CharacterId	INT UNSIGNED,
    MovieId	INT UNSIGNED,
    CONSTRAINT
		PRIMARY KEY (CharacterId, MovieId),
	CONSTRAINT
		FOREIGN KEY (CharacterId)
			REFERENCES `Character` (CharacterId),
	CONSTRAINT
		FOREIGN KEY (MovieId)
			REFERENCES Movie (MovieId)
);

DROP TABLE IF EXISTS mcu.Comment;
CREATE TABLE mcu.Comment
(
	CommentId	INT UNSIGNED PRIMARY KEY	AUTO_INCREMENT,
	CommentText	VARCHAR(45),
	CommentTime	DATETIME(6),
	UserId		INT UNSIGNED,
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
	SeriesId		INT	UNSIGNED,
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
