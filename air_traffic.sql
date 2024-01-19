-- from the terminal run:
-- psql < air_traffic.sql

DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic

CREATE TABLE countries(
 id SERIAL PRIMARY KEY,
 name TEXT
);

CREATE TABLE cities(
id SERIAL PRIMARY KEY,
country INTEGER REFERENCES countries ON DELETE CASCADE,
name TEXT
);

CREATE TABLE airlines(
id SERIAL PRIMARY KEY,
name TEXT
);


CREATE TABLE tickets
(
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  seat VARCHAR(3) NOT NULL,
  departure TIMESTAMP NOT NULL,
  arrival TIMESTAMP NOT NULL,
  airline INTEGER REFERENCES airlines ON DELETE CASCADE,
  from_city INTEGER REFERENCES cities ON DELETE CASCADE,
  from_country INTEGER REFERENCES countries ON DELETE CASCADE,
  to_city INTEGER REFERENCES cities ON DELETE CASCADE,
  to_country INTEGER REFERENCES countries ON DELETE CASCADE
);

INSERT into airlines
	(name)
VALUES
('United'),
('British Airways'),
('Delta'),
('TUI Fly Belgium'),
('Air China'),
('American Airlines'),
('Avianca Brasil');

INSERT INTO countries
	(name)
VALUES
('United States'),
('Japan'),
('France'),
('UAE'),
('Brazil'),
('United Kingdom'),
('Mexico'),
('Morocco'),
('China'),
('Chile');

INSERT into cities
	(name, country)
VALUES
('Washington DC', 1),
('Seattle', 1),
('Tokyo', 2),
('London', 6),
('Los Angeles', 1),
('Las Vegas', 1),
('Mexico City', 7),
('Paris', 3),
('Casablanca', 8),
('Dubai', 4),
('Beijing', 9),
('New York', 1),
('Charlotte',1),
('Cedar Rapids', 1),
('Chicago', 1),
('New Orleans',1),
('Sao Paolo', 5),
('Santiago', 10);





INSERT INTO tickets
  (first_name, last_name, seat, departure, arrival, airline, from_city, from_country, to_city, to_country)
VALUES
  ('Jennifer', 'Finch', '33B', '2018-04-08 09:00:00', '2018-04-08 12:00:00', 1, 1, 1, 2, 1),
  ('Thadeus', 'Gathercoal', '8A', '2018-12-19 12:45:00', '2018-12-19 16:15:00', 2, 3, 2, 6, 6),
  ('Sonja', 'Pauley', '12F', '2018-01-02 07:00:00', '2018-01-02 08:03:00', 3, 5, 1, 6, 1),
  ('Jennifer', 'Finch', '20A', '2018-04-15 16:50:00', '2018-04-15 21:00:00', 3, 2, 1, 7, 7),
  ('Waneta', 'Skeleton', '23D', '2018-08-01 18:30:00', '2018-08-01 21:50:00', 4, 8, 3, 9, 8),
  ('Thadeus', 'Gathercoal', '18C', '2018-10-31 01:15:00', '2018-10-31 12:55:00', 5, 10, 4, 11, 9),
  ('Berkie', 'Wycliff', '9E', '2019-02-06 06:00:00', '2019-02-06 07:47:00', 1, 12, 1, 13, 1),
  ('Alvin', 'Leathes', '1A', '2018-12-22 14:42:00', '2018-12-22 15:56:00', 6, 14, 1, 15, 1),
  ('Berkie', 'Wycliff', '32B', '2019-02-06 16:28:00', '2019-02-06 19:18:00', 6, 13, 1, 16, 1),
  ('Cory', 'Squibbes', '10D', '2019-01-20 19:30:00', '2019-01-20 22:45:00', 7, 17, 5, 18, 10);