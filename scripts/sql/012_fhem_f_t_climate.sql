CREATE TABLE fhem.f_t_climate (
    ID BIGINT,
    TIMESTAMP TIMESTAMP,
    YEAR SMALLINT,
    MONTH TINYINT,
    WEEK TINYINT,
    DAY TINYINT,
    FK_DEVICE_ID TINYINT,
    FK_READING_ID TINYINT,
    VALUE DOUBLE,
    _CREATED_AT TIMESTAMP,
    PRIMARY KEY (ID),
    INDEX Search_Idx (TIMESTAMP, FK_DEVICE_ID, FK_READING_ID, VALUE),
    INDEX Report_Idx (TIMESTAMP, FK_READING_ID),
    INDEX Date_Idx (YEAR, MONTH, DAY),
    INDEX Week_Idx (YEAR, WEEK)
);