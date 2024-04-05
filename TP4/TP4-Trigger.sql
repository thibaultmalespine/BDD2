--Question 3
--Ecrivez le Trigger prenant en compte la contrainte d)
--d) Le prix d'un vol ne peut augmenter de plus de 10%.
CREATE OR REPLACE FUNCTION contraineD()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.prixVol >= OLD.prixVol * 1.1
    THEN
        RAISE NOTICE 'Le prix d''un vol ne peut pas augmenter de plus de 10%%';
        RETURN OLD; 
    ELSE 
        RETURN NEW;
    END IF;

END;
$$ LANGUAGE 'plpgsql';

DROP TRIGGER IF EXISTS cD ON Vol;

CREATE TRIGGER cD
BEFORE UPDATE ON Vol
FOR EACH ROW 
EXECUTE PROCEDURE contraineD();

--Question 4
--Ecrivez le Trigger prenant en compte la contrainte e).
--e) le nom d’un client ne peut être égal au prénom d’un autre client et inversement.
CREATE OR REPLACE FUNCTION contrainteE()
RETURNS TRIGGER AS $$
DECLARE 
    prenomAutreClient VARCHAR(40); 
    nomAutreClient VARCHAR(40);
BEGIN
    FOR prenomAutreClient IN 
    SELECT prenomC FROM Client
    LOOP
        IF NEW.nomC = prenomAutreClient
        THEN
            RAISE NOTICE 'le nom d''un client ne peut être égal au prénom d''un autre client';
            RETURN NULL;
        END IF;
    END LOOP;

    FOR nomAutreClient IN 
    SELECT nomC FROM Client
    LOOP
        IF NEW.prenomC = nomAutreClient
        THEN
            RAISE NOTICE 'le prenom d''un client ne peut être égal au nom d''un autre client';
            RETURN NULL;
        END IF;
    END LOOP;

    RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

DROP TRIGGER IF EXISTS cE ON Client;

CREATE TRIGGER cE
BEFORE UPDATE OR INSERT ON Client
FOR EACH ROW 
EXECUTE PROCEDURE contrainteE();  


--Question 5
--Ecrivez le Trigger prenant en compte la contrainte f).
--f) Un client ne peut réserver un vol que s’il est client de l’agence qui propose ce vol. 

