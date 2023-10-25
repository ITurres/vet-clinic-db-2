-- *  Database schema to keep the structure of entire database.
CREATE TABLE
    animals (
        id SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        name VARCHAR(30) NOT NULL,
        date_of_birth DATE NOT NULL,
        escape_attempts SMALLINT NOT NULL,
        neutered BOOLEAN NOT NULL,
        weight_kg NUMERIC(5, 2) NOT NULL
    );

ALTER TABLE animals
ADD COLUMN species VARCHAR(20) NULL;

CREATE TABLE
    owners (
        id SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        full_name VARCHAR(50) NOT NULL,
        age SMALLINT NOT NULL
    );

CREATE TABLE
    species (
        id SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        name VARCHAR(20) NOT NULL
    );

ALTER TABLE animals
DROP column species;

ALTER TABLE animals
ADD COLUMN species_id SMALLINT,
ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species (id) ON DELETE CASCADE;

ALTER TABLE animals
ADD COLUMN owner_id SMALLINT,
ADD CONSTRAINT fk_owner FOREIGN KEY (owner_id) REFERENCES owners (id) ON DELETE CASCADE;