DROP TABLE TRAIN CASCADE CONSTRAINTS;
DROP TABLE TRAJET CASCADE CONSTRAINTS;
DROP TABLE GARE CASCADE CONSTRAINTS;
DROP TABLE VOYAGEUR CASCADE CONSTRAINTS;
DROP TABLE PROMOTION CASCADE CONSTRAINTS;
DROP TABLE TICKET CASCADE CONSTRAINTS;
DROP TABLE DATE_TIME CASCADE CONSTRAINTS;
DROP TABLE DATE_DATE CASCADE CONSTRAINTS;

DROP VIEW OCC_GARE CASCADE CONSTRAINTS;
DROP VIEW OCC_TRAIN CASCADE CONSTRAINTS;
DROP VIEW OCC_DATE_DATE CASCADE CONSTRAINTS;
DROP VIEW OCC_DATE_TIME CASCADE CONSTRAINTS;

CREATE TABLE GARE(
    ID_GARE               NUMBER(10) PRIMARY KEY NOT NULL,
    NOM_GARE              VARCHAR(250) NOT NULL,
    REGION_GARE           VARCHAR(250) NOT NULL,
    CODE_REGION_GARE      NUMBER(10) NOT NULL,
    DEPARTEMENT_GARE      VARCHAR(250) NOT NULL,
    CODE_DEPARTEMENT_GARE NUMBER(10) NOT NULL,
    VILLE_GARE            VARCHAR(250) NOT NULL,
    CODE_VILLE_GARE       NUMBER(10) NOT NULL
);

CREATE TABLE VOYAGEUR(
    ID_VOYAGEUR         NUMBER(10) PRIMARY KEY NOT NULL,
    NOM                 VARCHAR(250) NOT NULL,
    PRENOM              VARCHAR(250) NOT NULL,
    AGE                 NUMBER(10) NOT NULL,
    ADRESSE             VARCHAR(250) NOT NULL,
    DATE_NAISSANCE      DATE NOT NULL,
    SEXE                CHAR(1) NOT NULL,
    ADRESSE_EMAIL       VARCHAR(250) NOT NULL
);

CREATE TABLE PROMOTION(
    ID_PROMOTION          NUMBER(10) PRIMARY KEY NOT NULL,
    CARTE_REDUCTION       VARCHAR(250) NOT NULL,
    POURCENTAGE_REDUCTION NUMBER(10,2) NOT NULL,
    DEBUT_PROMO           DATE NOT NULL,
    FIN_PROMO             DATE NOT NULL,
    AGE_MINIMUM           NUMBER(2),
    AGE_MAXIMUM           NUMBER(2),
    MODALITES_REDUCTION   VARCHAR(1024)
);

-- PARTIE OCCUPATION DES TRAINS --

CREATE TABLE DATE_TIME (
    ID_TIME        NUMBER(10) PRIMARY KEY NOT NULL,
    HEURES         NUMBER(2) NOT NULL,
    MINUTES        NUMBER(2) NOT NULL,
    SECONDES       NUMBER(2) NOT NULL
);

CREATE TABLE DATE_DATE (
    ID_DATE           NUMBER(10) PRIMARY KEY NOT NULL,
    JOUR              NUMBER(2) NOT NULL,
    MOIS              NUMBER(2) NOT NULL,
    ANNEE             NUMBER(4) NOT NULL,
    SAISON            VARCHAR(20) NOT NULL,
    NUM_SEMAINE       NUMBER(2) NOT NULL,
    NUM_TRIMESTRE     NUMBER(2) NOT NULL
);

CREATE TABLE TRAIN (
    ID_TRAIN              NUMBER(10) PRIMARY KEY NOT NULL,
    TYPE_TRAIN            VARCHAR(10) NOT NULL,
    NMBR_PLACES           NUMBER(10) NOT NULL,
    NMBR_WAGON            NUMBER(10) NOT NULL,
    DATE_MISE_EN_SERVICE  DATE NOT NULL, -- XX/XX/XXXX
    LIEU_DEPOT            VARCHAR(250) NOT NULL
);

CREATE VIEW OCC_GARE(ID_GARE, NOM_GARE, REGION_GARE, CODE_REGION_GARE, DEPARTEMENT_GARE, CODE_DEPARTEMENT_GARE, VILLE_GARE, CODE_VILLE_GARE)
AS SELECT * FROM GARE;

CREATE VIEW OCC_TRAIN(ID_TRAIN, TYPE_TRAIN, NMBR_PLACES, NMBR_WAGON, DATE_MISE_EN_SERVICE, LIEU_DEPOT)
AS SELECT * FROM TRAIN;

CREATE VIEW OCC_DATE_DATE(ID_DATE, JOUR, MOIS, ANNEE, SAISON, NUM_SEMAINE, NUM_TRIMESTRE)
AS SELECT * FROM DATE_DATE;

CREATE VIEW OCC_DATE_TIME(ID_TIME, HEURES, MINUTES, SECONDES)
AS SELECT * FROM DATE_TIME;  -- MATERIALIZED


CREATE TABLE TRAJET ( -- Demander a la prof  comment on peut faire /!\
    ID_GARE_DEPART         NUMBER(10) NOT NULL,
    ID_GARE_ARRIVEE        NUMBER(10) NOT NULL,
    ID_TRAIN               NUMBER(10) NOT NULL,
    ID_DATE                NUMBER(10) NOT NULL,
    ID_TIME                NUMBER(10) NOT NULL,
    TAUX_OCCUPATION        NUMBER(10,3) NOT NULL,
    FOREIGN KEY (ID_GARE_DEPART) REFERENCES GARE(ID_GARE),   -- OCC_GARE(ID_GARE),
    FOREIGN KEY (ID_GARE_ARRIVEE) REFERENCES GARE(ID_GARE),  -- OCC_GARE(ID_GARE),
    FOREIGN KEY (ID_TRAIN) REFERENCES TRAIN(ID_TRAIN),    -- OCC_TRAIN(ID_TRAIN),
    FOREIGN KEY (ID_DATE) REFERENCES DATE_DATE(ID_DATE),  -- OCC_DATE_DATE(ID_DATE),
    FOREIGN KEY (ID_TIME) REFERENCES DATE_TIME(ID_TIME),  -- OCC_DATE_TIME(ID_TIME),
    PRIMARY KEY (ID_GARE_DEPART, ID_GARE_ARRIVEE, ID_TRAIN, ID_DATE, ID_TIME)
);

CREATE TABLE TICKET(
    ID_GARE_DEPART        NUMBER(10) NOT NULL,
    ID_GARE_ARRIVEE       NUMBER(10) NOT NULL,
    ID_TRAIN              NUMBER(10) NOT NULL,
    ID_DATE               NUMBER(10) NOT NULL,
    ID_TIME               NUMBER(10) NOT NULL,
    ID_PROMOTION          NUMBER(10) NOT NULL,
    ID_VOYAGEUR           NUMBER(10) NOT NULL,
    PRIX                  NUMBER(10,2) NOT NULL,
    FOREIGN KEY (ID_GARE_DEPART) REFERENCES GARE(ID_GARE),
    FOREIGN KEY (ID_GARE_ARRIVEE) REFERENCES GARE(ID_GARE),
    FOREIGN KEY (ID_TRAIN) REFERENCES TRAIN(ID_TRAIN),
    FOREIGN KEY (ID_DATE) REFERENCES DATE_DATE(ID_DATE),
    FOREIGN KEY (ID_TIME) REFERENCES DATE_TIME(ID_TIME),
    FOREIGN KEY (ID_PROMOTION) REFERENCES PROMOTION(ID_PROMOTION),
    FOREIGN KEY (ID_VOYAGEUR) REFERENCES VOYAGEUR(ID_VOYAGEUR),
    PRIMARY KEY (ID_GARE_DEPART, ID_GARE_ARRIVEE, ID_TRAIN, ID_DATE, ID_TIME, ID_PROMOTION, ID_VOYAGEUR)
);