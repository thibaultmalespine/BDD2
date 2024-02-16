DROP TABLE IF EXISTS Site, Organisation, Defi, Equipe, Etudiant; 

DROP SEQUENCE IF EXISTS cleEquipe;

CREATE SEQUENCE cleEquipe MINVALUE 1;

CREATE TABLE Site(
    nomSite Varchar(30) 
    CONSTRAINT pkSite PRIMARY KEY,
    emailResponsable Varchar(30),
    nomResponsable Varchar(30),
    noTelResponsable Varchar(30)
    );

CREATE TABLE Organisation(
    nomOrganisation Varchar(30) 
    CONSTRAINT pkOrganisation PRIMARY KEY,
    typeOrg Varchar(30) 
    CONSTRAINT ckTypeOrg CHECK (typeOrg ='Entreprise' OR typeOrg = 'association')
    );

CREATE TABLE Defi(
    nomDefi Varchar(30) 
    CONSTRAINT pkDefi PRIMARY KEY,
    prix INT,
    lOrganisation Varchar(30) 
    CONSTRAINT fkOrganisation REFERENCES Organisation(nomOrganisation)  
    CONSTRAINT nnlOrganisation NOT NULL
    );

CREATE TABLE Equipe(
    idEquipe INT 
    CONSTRAINT pkEquipe PRIMARY KEY,
    nomEquipe Varchar(30),
    leDefi Varchar(30)
    CONSTRAINT fkDefi REFERENCES Defi(nomDefi)
    CONSTRAINT nnleDefi NOT NULL,
    leSite Varchar(30)
    CONSTRAINT fkSite REFERENCES Site(nomSite) 
    CONSTRAINT nnleSite NOT NULL,
    emailChef Varchar(30)
    );

CREATE TABLE Etudiant(
    email Varchar(30) 
    CONSTRAINT pkEtudiant PRIMARY KEY,
    nom Varchar(30),
    prenom Varchar(30),
    lEquipe INT 
    CONSTRAINT fklEquipe REFERENCES Equipe(idEquipe)
    ); 

ALTER TABLE Equipe 
    ADD CONSTRAINT fkEtudiant 
        FOREIGN KEY (emailChef)
        REFERENCES Etudiant(email);

ALTER TABLE Equipe
    ALTER COLUMN emailChef  
    SET NOT NULL;
