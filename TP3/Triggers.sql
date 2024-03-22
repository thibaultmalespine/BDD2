-- Le nom d’un bateau ne peut être celui de son propriétaire
CREATE OR REPLACE FUNCTION contrainte7()
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

DROP TRIGGER IF EXISTS c7 ON Bateau;

CREATE TRIGGER c7 
BEFORE INSERT ON Bateau
FOR EACH ROW EXECUTE PROCEDURE contrainte7();


-- Une réservation ne peut concerner un emplacement que si sa longueur est supérieure ou égale à celle du bateau
CREATE OR REPLACE FUNCTION contrainte8()
RETURNS TRIGGER AS $$
DECLARE 
    longueurBateau INT;
    longueurEmplacement INT;
BEGIN
    SELECT longueurB, longueur  INTO longueurBateau, longueurEmplacement 
    FROM Emplacement, Bateau, Reservation
    WHERE NEW.leBateau = Bateau.noImm 
    AND NEW.lEmplacement = Emplacement.noEmpl;
    IF longueurEmplacement < longueurBateau
    THEN
        RAISE NOTICE 'l'' emplacement doit avoir une longueur supérieur à celle du bateau';
        RETURN NULL;
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE 'plpgsql';

DROP TRIGGER IF EXISTS c8 ON Reservation;

CREATE TRIGGER c8 
BEFORE INSERT ON Reservation
FOR EACH ROW EXECUTE PROCEDURE contrainte8();

-- Un bateau ne peut stationner dans un emplacement que si une réservation correspondante a été effectuée
CREATE OR REPLACE FUNCTION contrainte9()
RETURNS TRIGGER AS $$
DECLARE 
    uneReservation RECORD;
BEGIN
    FOR uneReservation IN
    SELECT * FROM Reservation
    LOOP
        IF NEW.leBateau = uneReservation.leBateau AND NEW.noEmpl = uneReservation.lEmplacement
        THEN
            RETURN NEW;
        END IF;
    END LOOP;
    RAISE NOTICE 'Aucune réservation associée à l''emplacement n''a été trouvée';
    RETURN NULL;
END;
$$ LANGUAGE 'plpgsql';

DROP TRIGGER IF EXISTS c9 ON Emplacement;

CREATE TRIGGER c9 
BEFORE UPDATE ON Emplacement
FOR EACH ROW EXECUTE PROCEDURE contrainte9();



CREATE OR REPLACE FUNCTION modifierEmplacement()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Emplacement 
    SET leBateau = NEW.leBateau , dateD = NEW.dateDebut , dateF = NEW.dateFin
    WHERE NEW.lEmplacement = noEmpl;
    RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

DROP TRIGGER IF EXISTS modifEmplacement ON Reservation;

CREATE TRIGGER modifEmplacement
AFTER INSERT ON Reservation
FOR EACH ROW EXECUTE PROCEDURE modifierEmplacement();

