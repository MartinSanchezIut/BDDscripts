-- Debut de notre script --
DROP TABLE IF EXISTS GARE;
DROP TABLE IF EXISTS VOYAGEUR;
DROP TABLE IF EXISTS PROMOTION;
DROP TABLE IF EXISTS TICKET;
DROP TABLE IF EXISTS DATE_TIME;
DROP TABLE IF EXISTS DATE_DATE;
DROP TABLE IF EXISTS TRAIN;
DROP TABLE IF EXISTS TRAJET;

-- PARTIE VENTE DE TICKETS --

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

CREATE TABLE VOYAGEUR(  -- C'est fait
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

CREATE TABLE DATE_TIME ( -- C'est fait
    ID_TIME        NUMBER(10) PRIMARY KEY NOT NULL,
    HEURES         NUMBER(2) NOT NULL,
    MINUTES        NUMBER(2) NOT NULL,
    SECONDES       NUMBER(2) NOT NULL
);

CREATE TABLE DATE_DATE ( -- C'est fait
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

CREATE TABLE TRAJET (    -- COMMENT FAIRE POUR LA CLE PRIMAIRE ??
    ID_GARE_DEPART         NUMBER(10) NOT NULL,
    ID_GARE_ARRIVEE        NUMBER(10) NOT NULL,
    ID_TRAIN               NUMBER(10) NOT NULL,
    ID_DATE                NUMBER(10) NOT NULL,
    ID_TIME                NUMBER(10) NOT NULL,
    TAUX_OCCUPATION        NUMBER(10,3) NOT NULL,
    FOREIGN KEY (ID_GARE_DEPART) REFERENCES GARE(ID_GARE),   
    FOREIGN KEY (ID_GARE_ARRIVEE) REFERENCES GARE(ID_GARE),
    FOREIGN KEY (ID_TRAIN) REFERENCES TRAIN(ID_TRAIN),
    FOREIGN KEY (ID_DATE) REFERENCES DATE_DATE(ID_DATE),
    FOREIGN KEY (ID_TIME) REFERENCES DATE_TIME(ID_TIME)
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
    FOREIGN KEY (ID_VOYAGEUR) REFERENCES VOYAGEUR(ID_VOYAGEUR)
);