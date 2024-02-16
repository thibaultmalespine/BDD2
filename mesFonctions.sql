CREATE OR REPLACE FUNCTION estDans(emailE VARCHAR(30))
RETURNS VARCHAR(30) AS $$
BEGIN 
    RETURN leSite 
    FROM Etudiant, Equipe
    WHERE email=emailE
    AND lEquipe=idEquipe;
END; 
$$ LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION sommePrix(uneOrga VARCHAR(30))
RETURNS INT AS $$
BEGIN
    RETURN SUM(prix) FROM Defi WHERE uneOrga=lOrganisation; 
END;
$$ LANGUAGE 'plpgsql';


DROP FUNCTION listeEtudiants; 
DROP TYPE IF EXISTS student;
CREATE TYPE student AS (nom VARCHAR(30), prenom VARCHAR(30));

CREATE OR REPLACE FUNCTION listeEtudiants(unSite VARCHAR(30))
RETURNS SETOF student AS $$
DECLARE
    res RECORD;
BEGIN
    FOR res IN SELECT nom,prenom FROM Site, Equipe, Etudiant
    WHERE unSite=nomSite AND leSite=nomSite AND lEquipe=idEquipe
    LOOP
        RETURN NEXT res;
    END LOOP;
    RETURN;
END;
$$ LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION intrus()
RETURNS SETOF VARCHAR(30) AS $$
DECLARE 
    lIntrus VARCHAR(30);
BEGIN 
    FOR lIntrus IN SELECT nomEquipe FROM Equipe,Etudiant
    WHERE emailChef = email 
    AND lEquipe != idEquipe
    LOOP 
        RETURN NEXT lIntrus;
    END LOOP;
    RETURN;
END;
$$ LANGUAGE 'plpgsql';