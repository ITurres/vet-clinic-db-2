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
    date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';

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