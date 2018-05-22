CREATE DATABASE mcu;
DROP DATABASE IF EXISTS mcu;
CREATE DATABASE mcu;
USE mcu;
SHOW TABLES;

CREATE TABLE mcu.Actor
(
	ActorId		INT	UNSIGNED PRIMARY KEY,
    FirstName	VARCHAR(45),
    LastName 	VARCHAR(45),
    BirthDate	DATE,
    OscarWinner	ENUM('Winner','Nominee','Not Yet')
);

CREATE TABLE mcu.Director
(
	DirectorId	INT UNSIGNED PRIMARY KEY,
    FirstName	VARCHAR(45),
    LastName 	VARCHAR(45),
    BirthDate	DATE
);

CREATE TABLE mcu.Movies
(
	MovieId			INT UNSIGNED PRIMARY KEY,
    Title			VARCHAR(45),
    Rating			DECIMAL(2,1),
    BoxOffice		DECIMAL(12,2),
    DirectorId		INT UNSIGNED,
    USReleaseDate	DATE,
    Budget			INT,
    Phase			TINYINT(1)
);

CREATE TABLE mcu.Series
(
	SeriesId	INT UNSIGNED PRIMARY KEY,
    SeriesName	VARCHAR(45),
    NumEpisodes	TINYINT(3),
    Platform	ENUM('Netflix','Hulu','ABC'),
    FirstAired	DATE
);

CREATE TABLE mcu.User
(
	UserId		INT UNSIGNED PRIMARY KEY,
    UserName	VARCHAR(45)	NOT NULL,
    MemberSince	DATE		NOT NULL
);


CREATE TABLE mcu.Character
(
	CharacterId		INT,
    CharacterName	VARCHAR(45),
    Alias			VARCHAR(45)													NULL,
    Superpower		SET('Flight','Speed','Intelligence','Wealth','Strength')	NULL,
    CharacterRole	ENUM('Hero','Villain','Anti Hero')							NULL,
    ActorId			INT UNSIGNED,
    CONSTRAINT 	pk_char_acto_id
		PRIMARY KEY (CharacterId, ActorId),
	CONSTRAINT	fk_char_acto_id
		FOREIGN KEY (ActorId)
			REFERENCES Actor(ActorId)
            ON DELETE RESTRICT		
);

CREATE TABLE mcu.MovieComments
(
	MovieCommentId	INT PRIMARY KEY,
	CommentText	VARCHAR(45),
	CommentTime	DATETIME(8),
	UserId		INT,
	MovieId		INT,
	CONSTRAINT	fk_comment_user_movie_id
		FOREIGN KEY (UserId)
			REFERENCES User (UserId),
	CONSTRAINT	fk_comment_movie_id
		FOREIGN KEY (MovieId)
			REFERENCES Movie (MovieId),
);

CREATE TABLE mcu.SeriesComments
(
	SeriesCommentId	INT PRIMARY KEY,
	CommentText	VARCHAR(45),
	CommentTime	DATETIME(8),
	UserId		INT,
	SeriesId	INT,
	CONSTRAINT	fk_comment_user_series_id
		FOREIGN KEY (UserId)
			REFERENCES User (UserId),
	CONSTRAINT	fk_comment_series_id
		FOREIGN KEY (SeriesId)
			REFERENCES Series (SeriesId),
);

#LINKING TABLE FOR CHARATERS AND MOVIES
CREATE TABLE mcu.MovieCharacter
(
	CharacterId	INT,
	ActorId		INT,
	MovieId		INT,
	CONSTRAINT	pk_character_actor_movie_id
		PRIMARY KEY (CharacterId, ActorId, MovieId),
	CONSTRAINT	fk_link_character_id
		FOREIGN KEY (CharacterId)
			REFERENCES Character (CharacterId),
	CONSTRAINT	fk_link_movie_id
		FOREIGN KEY (MovieId)
			REFERENCES Movies (MovieId),
	CONSTRAINT	fk_link_actor_id
		FOREIGN KEY (ActorId)
			REFERENCES Character (ActorId)
);

CREATE TABLE mcu.SeriesCharacter
(
	CharacterId	INT,
	ActorId		INT,
	SeriesId	INT,
	CONSTRAINT	pk_character_actor_series_id
		PRIMARY KEY (CharacterId, ActorId, SeriesId),
	CONSTRAINT	fk_link_character_id
		FOREIGN KEY (CharacterId)
			REFERENCES Character (CharacterId),
	CONSTRAINT	fk_link_series_id
		FOREIGN KEY (SeriesId)
			REFERENCES Series (SeriesId),
	CONSTRAINT	fk_link_actor_id
		FOREIGN KEY (ActorId)
			REFERENCES Character (ActorId)
);






