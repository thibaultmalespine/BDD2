--Question 3
--Faites une vue permettant de vérifier que les propriétaire possèdent tous au moins un bateau. Testez
DROP VIEW q3;

CREATE OR REPLACE VIEW q3 AS 
SELECT nomP, prenomP 
FROM Proprietaire 
WHERE nomP NOT IN ( 
    SELECT nomP FROM Proprietaire, Bateau 
    WHERE leProprio=idProprio );

