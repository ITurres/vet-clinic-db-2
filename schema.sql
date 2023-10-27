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

CREATE TABLE
    vets (
        id SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        name VARCHAR(40) NOT NULL,
        age SMALLINT NOT NULL,
        date_of_graduation DATE NOT NULL
    );

-- * Junction Table for -species- -vets- tables.
CREATE TABLE
    specializations (
        specializations_id SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        vet_id SMALLINT,
        species_id SMALLINT,
        CONSTRAINT fk_vet FOREIGN KEY (vet_id) REFERENCES vets (id) ON DELETE CASCADE,
        CONSTRAINT fk_specie FOREIGN KEY (species_id) REFERENCES species (id) ON DELETE CASCADE
    );

-- * Junction Table for -animals- -vets- tables.
CREATE TABLE
    visits (
        visits_id SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        animal_id SMALLINT,
        vet_id SMALLINT,
        CONSTRAINT fk_animal FOREIGN KEY (animal_id) REFERENCES animals (id) ON DELETE CASCADE,
        CONSTRAINT fk_vet FOREIGN KEY (vet_id) REFERENCES vets (id) ON DELETE CASCADE,
        date_of_visit DATE NOT NULL
    );