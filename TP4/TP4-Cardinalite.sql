DROP VIEW IF EXISTS checkCardAgenceVol;
DROP VIEW IF EXISTS checkCardClientVol;

-- chaque agence doit avoir au moins un vol
-- doit retourner l'ensemble vide 
CREATE OR REPLACE VIEW checkCardAgenceVol AS
SELECT noAgence FROM Agence
WHERE noAgence NOT IN 
(
    SELECT lAgence FROM Vol, Agence
    WHERE lAgence = noAgence
); 



-- doit retourner l'ensemble vide 
CREATE OR REPLACE VIEW checkCardClientVol AS
SELECT noClient FROM Client
EXCEPT
SELECT unClient FROM Reservation;
