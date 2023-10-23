-- *  Database schema to keep the structure of entire database.
CREATE TABLE
    animals (
        id SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        name VARCHAR(30) NOT NULL,
        date_of_birth DATE NOT NULL,
        escape_attempts SMALLINT NOT NULL,
        neutered BOOLEAN NOT NULL,
        weight_kg NUMERIC(5, 2) NOT NULL,
    );