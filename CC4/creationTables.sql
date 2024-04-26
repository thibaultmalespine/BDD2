\echo [INFO] Debut du script

-- \i C:/Users/fpouit/Documents/FP/L2_BDD_TP4.sql
\echo [INFO] Creation de la base de donnees tournoides6nations
DROP DATABASE IF EXISTS t6n;
CREATE DATABASE t6n ENCODING 'UTF8';

\echo [INFO] Connexion a la nouvelle base de donnees tournoides6nations

\c t6n

SET DATESTYLE='DMY';

DROP TABLE IF EXISTS Matchs;

DROP TABLE IF EXISTS Journee;

DROP TABLE IF EXISTS Joueur;

DROP TABLE IF EXISTS Equipe;

DROP TABLE IF EXISTS Poste;


CREATE TABLE Poste
   (
    nomPoste VARCHAR(40) PRIMARY KEY 
    CONSTRAINT ckNomPoste 
    CHECK (nomPoste = 'pilier' 
    OR nomPoste = 'talonneur'
    OR nomPoste = '2e ligne'
    OR nomPoste = '3e ligne'
    OR nomPoste = 'demi de mélée'
    OR nomPoste = 'demi d ouverture'
    OR nomPoste = 'centre'
    OR nomPoste = 'ailier'
    OR nomPoste = 'arrière')

   ) ;

CREATE TABLE Equipe
   (
    nomEquipe VARCHAR(40)  PRIMARY KEY,
    stadeEquipe VARCHAR(40)
    CONSTRAINT nnEquipe NOT NULL 
    CONSTRAINT ukEquipe UNIQUE 
   ) ;

CREATE TABLE Joueur
   (
    idJoueur INT PRIMARY KEY,
    nomJ VARCHAR(40),
	prenomJ VARCHAR(40),
    lePoste VARCHAR(40)
    CONSTRAINT nnlePoste NOT NULL 
    CONSTRAINT fklePoste REFERENCES Poste(nomPoste),
    lEquipe VARCHAR(40)
    CONSTRAINT nnlEquipe NOT NULL 
    CONSTRAINT fklEquipe REFERENCES Equipe(nomEquipe)
   ) ;

CREATE TABLE Journee
(
    noJournee INT PRIMARY KEY,
    ladate DATE CONSTRAINT nnladate NOT NULL
);
   
CREATE TABLE Matchs
   (
    equipe1 VARCHAR(40),
    equipe2 VARCHAR(40),
    CONSTRAINT pkMatchs PRIMARY KEY (equipe1, equipe2),
    CONSTRAINT equipeDif CHECK (equipe1 != equipe2),
    leLieu VARCHAR(40) 
    CONSTRAINT nnleLieu NOT NULL
    CONSTRAINT fkleLieu REFERENCES Equipe(stadeEquipe),
    score1 INT,
    score2 INT,
    uneJournee INT
    CONSTRAINT nnuneJournee NOT NULL 
    CONSTRAINT fkuneJournee REFERENCES Journee(noJournee),
    h_du_match INT
    CONSTRAINT fkHMatch REFERENCES Joueur(idJoueur) 
   ) ;

	
