DROP DATABASE IF EXISTS mcu;
CREATE DATABASE mcu;
USE mcu;
SHOW TABLES;

DROP TABLE IF EXISTS mcu.Actor;
CREATE TABLE mcu.Actor
(
	ActorId		INT	UNSIGNED PRIMARY KEY	AUTO_INCREMENT,
    FirstName	VARCHAR(45)	NOT NULL,
    LastName 	VARCHAR(45)	NOT NULL,
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






