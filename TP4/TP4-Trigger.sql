CREATE OR REPLACE FUNCTION contraineD()
RETURN TRIGGER AS $$
DECLARE 
    INT ancienPrix;
    INT nouveauPrix;
BEGIN
    IF NEW.proxVol >= OLD.prixVol * 1.1
    THEN
        RAISE NOTICE "Le prix d'un vol ne peut augmenter de plus de 10%";
        RETURN OLD; 
    ELSE 
        RETURN NEW;
    END IF;

END;
$$ LANGUAGE 'plpgsql';


CREATE TRIGGER cD
BEFORE UPDATE ON Vol
FOR EACH ROW 
EXECUTE PROCEDURE contraineD();