-- from the terminal run:
-- psql < outer_space.sql

DROP DATABASE IF EXISTS outer_space;

CREATE DATABASE outer_space;

\c outer_space

CREATE TABLE galaxies
(
  id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL
);

CREATE TABLE stars
(
  id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL
);

CREATE TABLE planets
(
  id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL,
  orbital_period_in_years FLOAT NOT NULL,
  orbits_around INTEGER REFERENCES stars(id) ON DELETE CASCADE,
  galaxy INTEGER REFERENCES galaxies(id) ON DELETE CASCADE
);

CREATE TABLE moons(
  id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL
);

CREATE TABLE planets_moons(
  id SERIAL PRIMARY KEY,
  planet_id INTEGER REFERENCES planets ON DELETE CASCADE NOT NULL,
  moon_id INTEGER REFERENCES moons ON DELETE CASCADE
);

INSERT INTO galaxies
	(name)
VALUES
('Milky Way');

INSERT INTO stars
	(name)
VALUES
('The Sun'), 
('Proxima Centauri'),
('Gliese 876');

INSERT INTO planets
	(name, orbital_period_in_years, orbits_around, galaxy)
VALUES
	('Earth', 1.00, 1, 1),
  ('Mars', 1.88, 1, 1),
  ('Venus', 0.62, 1, 1),
  ('Neptune', 164.8, 1, 1),
  ('Proxima Centauri b', 0.03, 2, 1),
  ('Gliese 876 b', 0.23, 3, 1);

INSERT INTO moons
  (name)
VALUES
  ('The Moon'), ('Phobos'), ('Deimos'), ('Naiad'),
  ('Thalassa'), ('Despina'), ('Galatea'), ('Larissa'),
  ('S/2004 N 1'), ('Proteus'), ('Triton'), ('Nereid'),
  ('Halimede'), ('Sao'), ('Laomedeia'), ('Psamanthe'), ('Neso');


INSERT INTO planets_moons
  (planet_id, moon_id)
VALUES
((SELECT p.id FROM planets AS p WHERE p.name = 'Earth'), (SELECT m.id FROM moons as m WHERE m.name = 'The Moon')),
((SELECT p.id FROM planets AS p WHERE p.name = 'Mars'), (SELECT m.id FROM moons as m WHERE m.name = 'Phobos')),
((SELECT p.id FROM planets AS p WHERE p.name = 'Mars'), (SELECT m.id FROM moons as m WHERE m.name = 'Deimos')),
((SELECT p.id FROM planets AS p WHERE p.name = 'Neptune'), (SELECT m.id FROM moons as m WHERE m.name = 'Naiad')),
((SELECT p.id FROM planets AS p WHERE p.name = 'Neptune'), (SELECT m.id FROM moons as m WHERE m.name = 'Despina')),
((SELECT p.id FROM planets AS p WHERE p.name = 'Neptune'), (SELECT m.id FROM moons as m WHERE m.name = 'Galatea')),
((SELECT p.id FROM planets AS p WHERE p.name = 'Neptune'), (SELECT m.id FROM moons as m WHERE m.name = 'Larissa')),
((SELECT p.id FROM planets AS p WHERE p.name = 'Neptune'), (SELECT m.id FROM moons as m WHERE m.name = 'S/2004 N 1')),
((SELECT p.id FROM planets AS p WHERE p.name = 'Neptune'), (SELECT m.id FROM moons as m WHERE m.name = 'Proteus')),
((SELECT p.id FROM planets AS p WHERE p.name = 'Neptune'), (SELECT m.id FROM moons as m WHERE m.name = 'Triton')),
((SELECT p.id FROM planets AS p WHERE p.name = 'Neptune'), (SELECT m.id FROM moons as m WHERE m.name = 'Nereid')),
((SELECT p.id FROM planets AS p WHERE p.name = 'Neptune'), (SELECT m.id FROM moons as m WHERE m.name = 'Halimede')),
((SELECT p.id FROM planets AS p WHERE p.name = 'Neptune'), (SELECT m.id FROM moons as m WHERE m.name = 'Sao')),
((SELECT p.id FROM planets AS p WHERE p.name = 'Neptune'), (SELECT m.id FROM moons as m WHERE m.name = 'Laomedeia')),
((SELECT p.id FROM planets AS p WHERE p.name = 'Neptune'), (SELECT m.id FROM moons as m WHERE m.name = 'Psamathe')),
((SELECT p.id FROM planets AS p WHERE p.name = 'Neptune'), (SELECT m.id FROM moons as m WHERE m.name = 'Neso'));

  

