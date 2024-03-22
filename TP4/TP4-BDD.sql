\echo [INFO] Debut du script

-- \i C:/Users/fpouit/Documents/FP/L2_BDD_TP4.sql
\echo [INFO] Creation de la base de donnees resavol
DROP DATABASE IF EXISTS resavol;
CREATE DATABASE resavol ENCODING 'UTF8';

\echo [INFO] Connexion a la nouvelle base de donnees resavol

\c resavol

SET DATESTYLE='DMY';

DROP TABLE IF EXISTS Reserve;

DROP TABLE IF EXISTS Vol;

DROP TABLE IF EXISTS Agence;

DROP TABLE IF EXISTS Ville;

DROP TABLE IF EXISTS Client;


CREATE TABLE Client
   (
    noClient INT  PRIMARY KEY,
    nomC VARCHAR(40)  NOT NULL ,
    prenomC VARCHAR(40) NOT NULL
   ) ;
   

CREATE TABLE Ville
   (
    nomV VARCHAR(40)  PRIMARY KEY,
    pays VARCHAR(40)
    CONSTRAINT nnVillePays NOT NULL
   ) ;


CREATE TABLE Agence
   (
    noAgence INT  PRIMARY KEY,
    adresseAgence VARCHAR(40)
    CONSTRAINT nnAgenceAdresse NOT NULL,
	villeAgence VARCHAR(40)
    CONSTRAINT fkAgenceVille REFERENCES Ville(nomV)
    CONSTRAINT nnAgenceVille NOT NULL
   ) ;
   
CREATE TABLE Vol
   (
    noVol INT PRIMARY KEY,
    prixVol INT NOT NULL,
	villeDepart VARCHAR(40)
    CONSTRAINT fkVolVilleDep REFERENCES Ville(nomV)
	CONSTRAINT nnVilleDepart NOT NULL, 
	villeArrivee VARCHAR(40)
    CONSTRAINT fkVolVillArr REFERENCES Ville(nomV)
	CONSTRAINT nnVilleArr NOT NULL, 
	lAgence INT 
    CONSTRAINT fkVolAgence REFERENCES Agence(noAgence)
    CONSTRAINT nnVolAgence NOT NULL,
    dateVol DATE
   ) ;

   
CREATE TABLE Reservation
   (unVol INT
    CONSTRAINT fkReserveVol REFERENCES Vol(noVol),
    unClient INT 
	CONSTRAINT fkReserveClient REFERENCES Client(noClient),
	dateResa DATE DEFAULT CURRENT_DATE,
	nbBillets INT
    -- ajouter la clé primaire double
   ) ;
   
   
DROP SEQUENCE IF EXISTS cleClient;
CREATE SEQUENCE cleClient MINVALUE 1;

DROP SEQUENCE IF EXISTS cleVol;
CREATE SEQUENCE cleVol MINVALUE 1;

DROP SEQUENCE IF EXISTS cleAgence;
CREATE SEQUENCE cleAgence MINVALUE 1;