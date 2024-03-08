
DELETE FROM Etudiant;
DELETE FROM Equipe;
DELETE FROM Site;
DELETE FROM Defi;
DELETE FROM Organisation;

INSERT INTO Site VALUES('Albi', 'Brillon', 'lBrillon@jfc.fr','08 00 00 00 00');
INSERT INTO Site VALUES('Toulouse', 'Tournesol', 'tTournesol@tlse.fr','08 00 00 00 01');

INSERT INTO Organisation VALUES('Airbus','Entreprise');
INSERT INTO Organisation VALUES('SPORT2000','Entreprise');
INSERT INTO Organisation VALUES('club modelisme','association');
INSERT INTO Organisation VALUES('Les Pecheurs du Tarn','association');

INSERT INTO Defi VALUES('defi1', 500, 'Airbus');
INSERT INTO Defi VALUES('defi2', 800, 'Airbus');
INSERT INTO Defi VALUES('defi3', 500, 'SPORT2000');
INSERT INTO Defi VALUES('defi4', 200, 'Les Pecheurs du Tarn');
INSERT INTO Defi VALUES('defi5', 300, 'club modelisme');

ALTER TABLE Etudiant
DROP CONSTRAINT fklEquipe;

INSERT INTO Etudiant VALUES('bruguier@jfc.fr','BRUGUIER','Florian',1);
INSERT INTO Etudiant VALUES('coulom@jfc.fr','COULOM','Damien',1);
INSERT INTO Etudiant VALUES('fradin@jfc.fr','FRADIN','Mahe',1);
INSERT INTO Etudiant VALUES('guelagli@jfc.fr','GUELAGLI','Oussama',1);
INSERT INTO Etudiant VALUES('garnier@jfc.fr','GARNIER','Clara',2);
INSERT INTO Etudiant VALUES('dalenc@jfc.fr','DALENC','Marie',2);
INSERT INTO Etudiant VALUES('delmasM@jfc.fr','DELMAS','Matthias',2);
INSERT INTO Etudiant VALUES('cabane.fr','CABANE','Renan',3);
INSERT INTO Etudiant VALUES('gakou@jfc.fr','GAKOU','Mohamed',3);
INSERT INTO Etudiant VALUES('saddougui@jfc.fr','SADDOUGUI','Sacha',3);
INSERT INTO Etudiant VALUES('jouenne.fr','JOUENNE','Elisée',4);
INSERT INTO Etudiant VALUES('lavit@jfc.fr','LAVIT','Quentin',4);
INSERT INTO Etudiant VALUES('martignac@jfc.fr','MARTIGNAC','Damien',4);
INSERT INTO Etudiant VALUES('nyiro.fr','NYIRO','Mathis',5);
INSERT INTO Etudiant VALUES('paquies@jfc.fr','PAQUIE','Dylan',5);
INSERT INTO Etudiant VALUES('selas@jfc.fr','SELAS','Pierrick',5);

INSERT INTO Equipe VALUES(NEXTVAL('cleEquipe'),'GRYFFONDOR','defi1','Albi','bruguier@jfc.fr');
INSERT INTO Equipe VALUES(NEXTVAL('cleEquipe'),'POUFSOUFFLE','defi2','Albi','garnier@jfc.fr');
INSERT INTO Equipe VALUES(NEXTVAL('cleEquipe'),'SERPENTARD','defi3','Albi','cabane.fr');
INSERT INTO Equipe VALUES(NEXTVAL('cleEquipe'),'SERDAIGLE','defi4','Toulouse','jouenne.fr');
INSERT INTO Equipe VALUES(NEXTVAL('cleEquipe'),'MANGEMORT','defi2','Toulouse','nyiro.fr');

ALTER TABLE Etudiant
ADD CONSTRAINT fklEquipe
FOREIGN KEY(lEquipe)
REFERENCES Equipe(idEquipe);