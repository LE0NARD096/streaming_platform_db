drop database if exists project;
create database project;
use project;

drop table if exists CUSTOMER;
CREATE TABLE CUSTOMER (
    fullname VARCHAR(30) NOT NULL,
    email VARCHAR(30) NOT NULL,
    address VARCHAR(30) NOT NULL,
    age INT,
    gender ENUM('M', 'F'),
    language VARCHAR(30),
    ID INT NOT NULL AUTO_INCREMENT,
    UNIQUE (email),
    PRIMARY KEY (ID)
);
SELECT 
    *
FROM
    CUSTOMER;

drop table if exists CONTENT;
CREATE TABLE CONTENT (
    name VARCHAR(30) NOT NULL,
    genre VARCHAR(30) NOT NULL,
    price INT,
    type VARCHAR(30),
    production_company VARCHAR(30),
    upload_date DATE NOT NULL,
    owner_ID INT NOT NULL,
    ID INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (ID),
    FOREIGN KEY (owner_ID)
        REFERENCES customer (ID)
);
SELECT 
    *
FROM
    CONTENT;

drop table if exists PLAYLIST;
CREATE TABLE PLAYLIST (
    name VARCHAR(30) NOT NULL,
    type ENUM('private', 'public'),
    owner_ID INT NOT NULL,
    ID INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (ID),
    FOREIGN KEY (owner_ID)
        REFERENCES customer (ID)
);
SELECT 
    *
FROM
    PLAYLIST;

drop table if exists SUBSCRIPTION_PLAN;
CREATE TABLE SUBSCRIPTION_PLAN (
    name VARCHAR(30) NOT NULL,
    type VARCHAR(30) NOT NULL,
    end_date DATE NOT NULL,
    ID INT AUTO_INCREMENT,
    PRIMARY KEY (ID)
);
SELECT 
    *
FROM
    SUBSCRIPTION_PLAN;

### M:N relations ###

drop table if exists SUBSCRIPTION;
CREATE TABLE SUBSCRIPTION (
    customer_ID INT NOT NULL,
    subscription_ID INT NOT NULL,
    start_date DATE NOT NULL,
    payement_method VARCHAR(30) NOT NULL,
    PRIMARY KEY (customer_ID , subscription_ID),
    FOREIGN KEY (subscription_ID)
        REFERENCES subscription_plan (ID),
    FOREIGN KEY (customer_ID)
        REFERENCES customer (ID),
    CONSTRAINT chk_payement CHECK (payement_method IN ('credit_card' , 'debit_card',
        'cash',
        'mobile_phone',
        'check',
        'cryptocurrency'))
);
SELECT 
    *
FROM
    SUBSCRIPTION;

drop table if exists PART_OF_SUBSCRIPTION;
CREATE TABLE PART_OF_SUBSCRIPTION (
    content_ID INT NOT NULL,
    subscription_ID INT NOT NULL,
    PRIMARY KEY (content_ID , subscription_ID),
    FOREIGN KEY (subscription_ID)
        REFERENCES subscription_plan (ID),
    FOREIGN KEY (content_ID)
        REFERENCES content (ID)
);
SELECT 
    *
FROM
    PART_OF_SUBSCRIPTION;

drop table if exists RATE;
CREATE TABLE RATE (
    content_ID INT NOT NULL,
    customer_ID INT NOT NULL,
    value INT NOT NULL,
    PRIMARY KEY (content_ID , customer_ID),
    FOREIGN KEY (customer_ID)
        REFERENCES customer (ID),
    FOREIGN KEY (content_ID)
        REFERENCES content (ID),
    CHECK (value > 0 AND value <= 5)
);
SELECT 
    *
FROM
    RATE;

drop table if exists LISTEN;
CREATE TABLE LISTEN (
    content_ID INT NOT NULL,
    customer_ID INT NOT NULL,
    device_source VARCHAR(30) NOT NULL,
    listen_date DATE NOT NULL,
    PRIMARY KEY (content_ID , customer_ID),
    FOREIGN KEY (customer_ID)
        REFERENCES customer (ID),
    FOREIGN KEY (content_ID)
        REFERENCES content (ID),
    CONSTRAINT chk_device CHECK (device_source IN ('smartphone' , 'tablet', 'laptop', 'smart_tv', 'radio'))
);
SELECT 
    *
FROM
    LISTEN;

drop table if exists PART_OF_PLAYLIST;
CREATE TABLE PART_OF_PLAYLIST (
    content_ID INT NOT NULL,
    playlist_ID INT NOT NULL,
    PRIMARY KEY (content_ID , playlist_ID),
    FOREIGN KEY (playlist_ID)
        REFERENCES playlist (ID),
    FOREIGN KEY (content_ID)
        REFERENCES content (ID)
);
SELECT 
    *
FROM
    PART_OF_PLAYLIST;

### multivalued DDL ###

DROP TABLE IF EXISTS CONTENT_TYPE;
CREATE TABLE CONTENT_TYPE (
    ID INT NOT NULL AUTO_INCREMENT,
    type_name VARCHAR(30) NOT NULL,
    PRIMARY KEY (ID)
);
SELECT 
    *
FROM
    CONTENT_TYPE;

DROP TABLE IF EXISTS CONTENT_TO_TYPE;
CREATE TABLE CONTENT_TO_TYPE (
    content_ID INT NOT NULL,
    type_ID INT NOT NULL,
    FOREIGN KEY (content_ID)
        REFERENCES content (ID),
    FOREIGN KEY (type_ID)
        REFERENCES content_type (ID)
);
SELECT 
    *
FROM
    CONTENT_TO_TYPE;

DROP TABLE IF EXISTS CONTENT_GENRE;
CREATE TABLE CONTENT_GENRE (
    ID INT NOT NULL AUTO_INCREMENT,
    genre_name VARCHAR(30) NOT NULL,
    PRIMARY KEY (ID)
);
SELECT 
    *
FROM
    CONTENT_GENRE;

DROP TABLE IF EXISTS CONTENT_TO_GENRE;
CREATE TABLE CONTENT_TO_GENRE (
    content_ID INT NOT NULL,
    genre_ID INT NOT NULL,
    FOREIGN KEY (content_ID)
        REFERENCES content (ID),
    FOREIGN KEY (genre_ID)
        REFERENCES content_genre (ID)
);
SELECT 
    *
FROM
    CONTENT_TO_GENRE;

DROP TABLE IF EXISTS SUBSCRIPTION_TYPE;
CREATE TABLE SUBSCRIPTION_TYPE (
    ID INT NOT NULL AUTO_INCREMENT,
    subscription_name VARCHAR(30) NOT NULL,
    PRIMARY KEY (ID)
);
SELECT 
    *
FROM
    SUBSCRIPTION_TYPE;

DROP TABLE IF EXISTS SUBSCRIPTION_TO_TYPE;
CREATE TABLE SUBSCRIPTION_TO_TYPE (
    subscription_ID INT NOT NULL,
    type_ID INT NOT NULL,
    FOREIGN KEY (subscription_ID)
        REFERENCES subscription_plan (ID),
    FOREIGN KEY (type_ID)
        REFERENCES subscription_type (ID)
);
SELECT 
    *
FROM
    SUBSCRIPTION_TO_TYPE;