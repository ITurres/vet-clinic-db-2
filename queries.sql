-- * Queries that provide answers to the questions from all projects.
-- ** Project 1 START.
SELECT
    *
FROM
    animals
WHERE
    name LIKE '%mon';

SELECT
    name
from
    animals
WHERE
    date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT
    name
FROM
    animals
WHERE
    neutered
    AND escape_attempts < 3;

SELECT
    date_of_birth
FROM
    animals
WHERE
    name IN ('Agumon', 'Pikachu');

SELECT
    name,
    escape_attempts AS escapes
FROM
    animals
WHERE
    weight_kg > 10.5;

SELECT
    *
FROM
    animals
WHERE
    neutered;

SELECT
    *
FROM
    animals
WHERE
    name != 'Gabumon';

SELECT
    *
FROM
    animals
WHERE
    weight_kg BETWEEN 10.4 AND 17.3;

-- ** Project 1 END.
-- ** Project 2 START.
-- *** Transactions START.
BEGIN;

UPDATE animals
SET
    species = 'unspecified';

SELECT
    species
FROM
    animals;

ROLLBACK;

SELECT
    species
FROM
    animals;

BEGIN;

UPDATE animals
SET
    species = 'digimon'
WHERE
    name LIKE '%mon';

UPDATE animals
SET
    species = 'pokemon'
WHERE
    species IS NULL;

SELECT
    species
FROM
    animals;

COMMIT;

SELECT
    species
FROM
    animals;

BEGIN;

DELETE FROM animals;

SELECT
    species
FROM
    animals;

ROLLBACK;

SELECT
    species
FROM
    animals;

BEGIN;

DELETE FROM animals
WHERE
    date_of_birth > '2022-01-01';

SAVEPOINT update_animals_weight;

UPDATE animals
SET
    weight_kg = weight_kg * -1;

ROLLBACK TO update_animals_weight;

UPDATE animals
SET
    weight_kg = weight_kg * -1
WHERE
    weight_kg < 0;

COMMIT;

-- *** Transactions END.
-- *** Queries START.
SELECT
    COUNT(*) AS total_animals
FROM
    animals;

SELECT
    COUNT(*) AS never_escaped
FROM
    animals
WHERE
    escape_attempts = 0;

SELECT
    AVG(weight_kg) AS avg_weight_kg
FROM
    animals;

SELECT
    name
FROM
    animals
ORDER BY
    escape_attempts DESC
LIMIT
    1;

SELECT
    species,
    MIN(weight_kg) AS min_weight_kg,
    MAX(weight_kg) AS max_weight_kg
FROM
    animals
GROUP BY
    species;

SELECT DISTINCT
    species,
    AVG(escape_attempts) AS avg_escape_attempts
FROM
    animals
GROUP BY
    species,
    date_of_birth
HAVING
    date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';

-- *** Queries END.
-- ** Project 2 END.