DROP FUNCTION IF EXISTS nomProprio;
DROP TYPE IF EXISTS proprio;

CREATE TYPE proprio AS (nomP VARCHAR(40), prenomP VARCHAR(40));

CREATE OR REPLACE FUNCTION nomProprio(noBateau VARCHAR(40))
RETURNS proprio as $$
BEGIN
    RETURN (nomP, prenomP) FROM Proprietaire, Bateau 
    WHERE leProprio = idProprio AND noImm = $1;
END; 
$$ LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION bateauDe(noProprio INT)
RETURNS SETOF VARCHAR(40) as $$
DECLARE
    nomBateau VARCHAR(40);
BEGIN
    FOR nomBateau IN SELECT nomB FROM Bateau, Proprietaire 
    WHERE $1 = idProprio AND leProprio = $1
    LOOP
        RETURN NEXT nomBateau;
    END LOOP;
    RETURN;  
END; 
$$ LANGUAGE 'plpgsql';