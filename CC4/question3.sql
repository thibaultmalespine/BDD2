-- Doit resortir les numéros des journées qui n'ont pas exactement 3 matchs 

DROP VIEW IF EXISTS troisMatch;

CREATE OR REPLACE VIEW troisMatch AS 
SELECT noJournee FROM Matchs, Journee 
WHERE uneJournee = noJournee
GROUP BY noJournee
HAVING noJournee != 3