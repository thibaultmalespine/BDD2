\echo [INFO] Debut du script

-- \i C:/Users/fpouit/Documents/FP/L2_BDD_TP4.sql
\echo [INFO] Creation de la base de donnees resavol
DROP DATABASE IF EXISTS resavol;
CREATE DATABASE resavol ENCODING 'UTF8';
\echo [INFO] Connexion a la nouvelle base de donnees resavol

\c resavol

SET DATESTYLE='DMY';

DROP VIEW IF EXISTS checkCardAgenceVol;
DROP VIEW IF EXISTS checkCardClientVol;

DROP TABLE IF EXISTS estClientDe;
DROP TABLE IF EXISTS Reservation;
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
    dateVol DATE DEFAULT CURRENT_DATE,
    CONSTRAINT ckVilleDepartVilleArrivee CHECK (Vol.villeDepart != Vol.villeArrivee)
   ) ;

   
CREATE TABLE Reservation
   (
    unClient INT 
	CONSTRAINT fkReserveClient REFERENCES Client(noClient),
    unVol INT
    CONSTRAINT fkReserveVol REFERENCES Vol(noVol),
	dateResa DATE DEFAULT CURRENT_DATE,
	nbBillets INT 
    CONSTRAINT ckNbBillets CHECK (nbBillets >= 1),
    CONSTRAINT pkReservation PRIMARY KEY (unVol, unClient)
   ) ;

CREATE TABLE estClientDe
    (
        unClient INT 
        CONSTRAINT fkEstClientDeClient REFERENCES Client(noClient),
        uneAgence INT
        CONSTRAINT fkEstClientDeAgence REFERENCES Agence(noAgence),
        CONSTRAINT pkEstClientDe PRIMARY KEY (unClient, uneAgence)
    );
   


-- contraintes d, e et f nécessitent un trigger