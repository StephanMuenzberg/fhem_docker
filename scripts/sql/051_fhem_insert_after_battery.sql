DELIMITER // 

DROP TRIGGER IF EXISTS fhem.insert_after_battery;

CREATE TRIGGER fhem.insert_after_battery
AFTER
INSERT
    ON fhem.history FOR EACH ROW BEGIN

    IF NEW.READING IN (
        'batteryLevel'
    ) THEN

    INSERT INTO
        fhem.f_t_battery (
            ID,
            TIMESTAMP,
            YEAR,
            MONTH,
            WEEK,
            DAY,
            FK_DEVICE_ID,
            FK_READING_ID,
            VALUE,
            _CREATED_AT
        )
            SELECT 
            NEW.ID,
            NEW.TIMESTAMP,
            NEW.YEAR,
            NEW.MONTH,
            NEW.WEEK,
            NEW.DAY,
            DDM.ID,
            DRM.ID, 
            CAST(NEW.VALUE AS DOUBLE),
            NOW()
        FROM fhem.history AS h
        LEFT JOIN fhem.d_t_device_mapping AS DDM
            ON DDM.DEVICE = NEW.DEVICE
        LEFT JOIN fhem.d_t_reading_mapping AS DRM
            ON DRM.READING_ORIG = NEW.READING
        WHERE NEW.ID = h.ID
        ;

    END IF;
END; //

DELIMITER ;