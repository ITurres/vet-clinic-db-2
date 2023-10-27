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
-- *
-- ** Project 3 START.
-- **** What animals belong to Melody Pond?
SELECT
    animals.name AS animals_owned_by_melody_pond
FROM
    animals
    JOIN owners ON owners.id = animals.owner_id
WHERE
    owners.full_name = 'Melody Pond';

-- **** List of all animals that are pokemon (their type is Pokemon).
SELECT
    animals.name AS pokemons
FROM
    animals
    JOIN species ON species.id = animals.species_id
WHERE
    species.name = 'Pokemon';

-- **** List all owners and their animals, remember to include those that
-- **** don't own any animal.
SELECT
    owners.full_name AS own_by,
    animals.name AS animal_name
FROM
    owners
    FULL JOIN animals ON animals.owner_id = owners.id
ORDER BY
    own_by;

-- **** How many animals are there per species?
SELECT
    species.name AS type_of_specie,
    COUNT(animals) AS count_of_specie
FROM
    species
    JOIN animals ON animals.species_id = species.id
GROUP BY
    type_of_specie;

-- **** List all Digimons owned by Jennifer Orwell.
SELECT
    animals.name AS digimons_owned_by_jennifer_orwell
FROM
    animals
    JOIN owners ON owners.id = animals.owner_id
    JOIN species ON species.id = animals.species_id
WHERE
    owners.full_name = 'Jennifer Orwell'
    AND species.name = 'Digimon';

-- **** List all animals owned by Dean Winchester that haven't tried to escape.
SELECT
    animals.name AS dean_winchester_good_animals
FROM
    animals
    JOIN owners ON owners.id = animals.owner_id
WHERE
    owners.full_name = 'Dean Winchester'
    AND animals.escape_attempts = 0;

-- **** Who owns the most animals?
SELECT
    owners.full_name AS most_animals_owner,
    COUNT(animals) AS animals_own
FROM
    owners
    JOIN animals ON animals.owner_id = owners.id
GROUP BY
    most_animals_owner
ORDER BY
    animals_own DESC
LIMIT
    1;

-- ** Project 3 END.
-- *
-- ** Project 4 START.
-- **** Who was the last animal seen by William Tatcher?
SELECT
    animals.name AS last_animal_seen_by_dr_tatcher,
    visits.date_of_visit AS date_of_visit
FROM
    animals
    JOIN visits ON visits.animal_id = animals.id
    JOIN vets ON vets.id = visits.vet_id
WHERE
    vets.name = 'William Tatcher'
ORDER BY
    visits.date_of_visit DESC
LIMIT
    1;

-- **** How many different animals did Stephanie Mendez see?
SELECT DISTINCT
    COUNT(animals.name) AS diff_animals
FROM
    animals
    JOIN visits ON visits.animal_id = animals.id
    JOIN vets ON vets.id = visits.vet_id
WHERE
    vets.name = 'Stephanie Mendez';

-- **** List all vets and their specializations,
-- **** including vets with no specialization.
SELECT
    vets.name AS vet_name,
    species.name AS species_name
FROM
    vets
    FULL JOIN specializations ON specializations.vet_id = vets.id
    FULL JOIN species ON species.id = specializations.species_id;

-- **** List all animals that visited Stephanie Mendez between
-- **** April 1st and August 30th, 2020.
SELECT
    animals.name AS animal_name,
    visits.date_of_visit AS date_of_visit
FROM
    animals
    JOIN visits ON visits.animal_id = animals.id
    JOIN vets ON vets.id = visits.vet_id
WHERE
    vets.name = 'Stephanie Mendez'
    AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- **** What animal has the most visits to vets?
SELECT
    animals.name AS animal_with_most_visits_to_the_vet
FROM
    animals
    JOIN visits ON visits.animal_id = animals.id
GROUP BY
    animals.name
ORDER BY
    COUNT(visits.animal_id) DESC
LIMIT
    1;

-- **** Who was Maisy Smith's first visit?
SELECT
    animals.name AS animal_name
FROM
    animals
    JOIN visits ON visits.animal_id = animals.id
    JOIN vets ON vets.id = visits.vet_id
WHERE
    vets.name = 'Maisy Smith'
ORDER BY
    visits.date_of_visit
LIMIT
    1;

-- **** Details for most recent visit: animal information,
-- **** vet information, and date of visit.
SELECT
    animals.*,
    vets.*,
    visits.date_of_visit AS date_of_visit
FROM
    animals
    JOIN visits ON visits.animal_id = animals.id
    JOIN vets ON vets.id = visits.vet_id
ORDER BY
    date_of_visit DESC
LIMIT
    1;

-- **** How many visits were with a vet that did not specialize
-- **** in that animal's species?
SELECT
    animals.name AS animal_name,
    vets.name AS vet_name,
    COUNT(visits.date_of_visit) AS visit_count
FROM
    animals
    JOIN visits ON visits.animal_id = animals.id
    JOIN vets ON vets.id = visits.vet_id
    LEFT JOIN specializations ON spec.vet_id = vets.id
    AND spec.species_id = animals.species_id
WHERE
    spec.vet_id IS NULL
GROUP BY
    animal_name,
    vet_name;

-- **** What specialty should Maisy Smith consider getting?
-- **** Look for the species she gets the most.
SELECT
    species.name AS species_name,
    COUNT(visits.date_of_visit) AS visit_count
FROM
    species
    JOIN animals ON animals.species_id = species.id
    JOIN visits ON visits.animal_id = animals.id
    JOIN vets ON vets.id = visits.vet_id
WHERE
    vets.name = 'Maisy Smith'
GROUP BY
    species_name
ORDER BY
    visit_count DESC
LIMIT
    1;

-- ** Project 4 END.