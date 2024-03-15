DROP SEQUENCE IF EXISTS pkE, pkP, pkR;
CREATE SEQUENCE pkE START 1;
CREATE SEQUENCE pkP START 1;
CREATE SEQUENCE pkR START 1;

DELETE FROM Reservation;
DELETE FROM Emplacement;
DELETE FROM Bateau;
DELETE FROM Proprietaire;

INSERT INTO Proprietaire VALUES 
(NEXTVAL('pkP'), 'Dupont', 'Armand', 'Dupont.Armand@gmail.com'),
(NEXTVAL('pkP'), 'Dupond', 'Bertrant', 'Dupond.Bertrant@gmail.com');

INSERT INTO Bateau VALUES
('z7k6cfr', 'TITANIC', 20, 6, 1),
('c5g8fat', 'COCINELLE', 6, 2, 1),
('r8e6pio', 'TEMPETE', 10, 3, 2),
('rasb5io', 'Dupond', 10, 3, 2);

INSERT INTO Emplacement VALUES
(NEXTVAL('pkE'), 20, 'z7k6cfr', '2023-07-20', '2023-08-20'),
(NEXTVAL('pkE'), 15, 'r8e6pio', '2024-01-13', '2024-03-13'),
(NEXTVAL('pkE'), 13,NULL,NULL,NULL),
(NEXTVAL('pkE'), 18,NULL,NULL,NULL),
(NEXTVAL('pkE'), 7,NULL,NULL,NULL);

INSERT INTO Reservation VALUES
(NEXTVAL('pkR'), '2023-06-20', '2023-09-20', 1, 'z7k6cfr'),
(NEXTVAL('pkR'), '2023-12-31', '2024-03-31', 2, 'r8e6pio');