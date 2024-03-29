DELETE FROM estClientDe;
DELETE FROM Reservation;
DELETE FROM Vol;
DELETE FROM Agence;
DELETE FROM Ville;
DELETE FROM Client;

   
DROP SEQUENCE IF EXISTS cleClient;
CREATE SEQUENCE cleClient MINVALUE 1;

DROP SEQUENCE IF EXISTS cleVol;
CREATE SEQUENCE cleVol MINVALUE 1;

DROP SEQUENCE IF EXISTS cleAgence;
CREATE SEQUENCE cleAgence MINVALUE 1;


INSERT INTO Client VALUES
    (NEXTVAL('cleClient'),'nom','prenom'),
    (NEXTVAL('cleClient'),'nom2','prenom2'),
    (NEXTVAL('cleClient'),'nom3','prenom3'),
    (NEXTVAL('cleClient'),'nom4','prenom4'),
    (NEXTVAL('cleClient'),'nom5','prenom5');

INSERT INTO Ville VALUES
    ('nomVille', 'France'),
    ('nomVille2', 'France'),
    ('nomVille3', 'France'),
    ('nomVille4', 'Angleterre'),
    ('nomVille5', 'Angleterre');

INSERT INTO Agence VALUES
    (NEXTVAL('cleAgence'), 'adresseAgence', 'nomVille'),
    (NEXTVAL('cleAgence'), 'adresseAgence2', 'nomVille2'),
    (NEXTVAL('cleAgence'), 'adresseAgence3', 'nomVille5');

INSERT INTO Vol VALUES
    (NEXTVAL('cleVol'), 150, 'nomVille', 'nomVille2', 1, '2023-06-20'),
    (NEXTVAL('cleVol'), 150, 'nomVille', 'nomVille3', 2, '2023-04-20'),
    (NEXTVAL('cleVol'), 150, 'nomVille3', 'nomVille2', 3, '2022-06-02');

INSERT INTO Reservation VALUES
    (1, 1,NULL, 3),
    (3, 1,NULL, 1),
    (3, 2,NULL, 1),
    (2, 1,NULL, 2),
    (4, 1,NULL, 1),
    (5, 1,NULL, 2);

INSERT INTO estClientDe VALUES
    (1,1),
    (1,2),
    (2,3),
    (3,3);