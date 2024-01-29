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

-- Airlines only cover certain countries
CREATE TABLE countries_airlines(
  id SERIAL PRIMARY KEY,
  airline_id INTEGER
  country_id INTEGER
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


-- "Helper" table to create cities table
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

-- This COULD be separated into another table in the case of duplicate city names where countries are different
INSERT into cities
	(name, country)
VALUES
('Washington DC', (SELECT c.name FROM countries as c WHERE c.name='United States')),
('Seattle',  (SELECT c.name FROM countries as c WHERE c.name='United States')),
('Tokyo',  (SELECT c.name FROM countries as c WHERE c.name='United States')),
('London',  (SELECT c.name FROM countries as c WHERE c.name='United Kingdom')),
('Los Angeles', (SELECT c.name FROM countries as c WHERE c.name='United States')),
('Las Vegas', (SELECT c.name FROM countries as c WHERE c.name='United States')),
('Mexico City', (SELECT c.name FROM countries as c WHERE c.name='Mexico')),
('Paris', (SELECT c.name FROM countries as c WHERE c.name='France')),
('Casablanca', (SELECT c.name FROM countries as c WHERE c.name='Morocco')),
('Dubai', (SELECT c.name FROM countries as c WHERE c.name='UAE')),
('Beijing', (SELECT c.name FROM countries as c WHERE c.name='China')),
('New York', (SELECT c.name FROM countries as c WHERE c.name='United States')),
('Charlotte',(SELECT c.name FROM countries as c WHERE c.name='United States')),
('Cedar Rapids', (SELECT c.name FROM countries as c WHERE c.name='United States')),
('Chicago', (SELECT c.name FROM countries as c WHERE c.name='United States')),
('New Orleans',(SELECT c.name FROM countries as c WHERE c.name='United States')),
('Sao Paolo', (SELECT c.name FROM countries as c WHERE c.name='Brazil')),
('Santiago', (SELECT c.name FROM countries as c WHERE c.name='Chile'));


CREATE TABLE tickets
(
  id SERIAL PRIMARY KEY,
  customer_id INTEGER NOT NULL ON DELETE CASCADE,
  seat VARCHAR(3) NOT NULL,
  departure TIMESTAMP NOT NULL,
  arrival TIMESTAMP NOT NULL,
  airline INTEGER REFERENCES airlines ON DELETE CASCADE,
  from_city INTEGER REFERENCES cities ON DELETE CASCADE,
  to_city INTEGER REFERENCES cities ON DELETE CASCADE,
);

CREATE TABLE customers(
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(20),
  last_name VARCHAR(20)
);

CREATE TABLE customers_tickets(
  id SERIAL PRIMARY KEY,
  ticket_id INTEGER,
  customer_id INTEGER
);

