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
	CONSTRAINT	fk_acto_id
		FOREIGN KEY (ActorId)
			REFERENCES Actor(ActorId)
            ON DELETE RESTRICT		
);