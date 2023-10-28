/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

CREATE TABLE animals (
    id INT GENERATED BY DEFAULT AS IDENTITY,
	name varchar(100) NULL,
	date_of_birth date NULL,
	escape_attempts INT NULL,
	neutered boolean NULL,
	weight_kg decimal,
	PRIMARY KEY (id)
);

ALTER TABLE animals
ADD COLUMN species varchar;

CREATE TABLE owners (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    full_name VARCHAR(100) NULL,
	age INT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE species (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR(100) NULL,
	PRIMARY KEY(id)
);

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT,
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN owner_id INT,
ADD CONSTRAINT fk_owner
FOREIGN KEY (owner_id) REFERENCES owners(id);

CREATE TABLE vets (
	id INT GENERATED BY DEFAULT AS IDENTITY,
	name varchar(100) NULL,
	age INT NULL,
	date_of_graduation date NULL,
	PRIMARY KEY(id)
);

CREATE TABLE specializations (
    species_id INT,
	CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id),
	vets_id INT,
	CONSTRAINT fk_vets FOREIGN KEY(vets_id) REFERENCES vets(id),
	PRIMARY KEY (species_id, vets_id)
);

CREATE TABLE visits (
    animals_id INT,
	CONSTRAINT fk_animals FOREIGN KEY(animals_id) REFERENCES animals(id),
    vets_id INT,
	CONSTRAINT fk_vets FOREIGN KEY(vets_id) REFERENCES vets(id),
	visit_date date,
	PRIMARY KEY (animals_id, vets_id, visit_date)
);
