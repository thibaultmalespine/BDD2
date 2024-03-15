
CREATE OR REPLACE FUNCTION containte7()
RETURNS TRIGGER AS $$
DECLARE 
    nomProprio VARCHAR(40); 
BEGIN 
    SELECT nomP INTO nomProprio FROM Proprietaire, Bateau 
    WHERE upper(NEW.nomB) = upper(nomP);
    IF upper(NEW.nomB) = upper(nomProprio)
        THEN 
            RAISE NOTICE 'le nom du bateau doit être différent de celui de son propriétaire';
            RETURN NULL;
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE 'plpgsql';

DROP TRIGGER c7 ON Bateau;

CREATE TRIGGER c7 
BEFORE INSERT ON Bateau
FOR EACH ROW EXECUTE PROCEDURE containte7();


