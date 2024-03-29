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