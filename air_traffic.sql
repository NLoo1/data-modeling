-- from the terminal run:
-- psql < air_traffic.sql

DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic

CREATE TABLE countries(
 id SERIAL PRIMARY KEY,
 name VARCHAR NOT NULL
);

CREATE TABLE cities(
id SERIAL PRIMARY KEY,
country INTEGER REFERENCES countries ON DELETE CASCADE NOT NULL,
name VARCHAR NOT NULL
);

CREATE TABLE airlines(
id SERIAL PRIMARY KEY,
name VARCHAR NOT NULL
);

CREATE TABLE customers(
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(20) NOT NULL,
  last_name VARCHAR(20) NOT NULL
);


-- Airlines only cover certain countries
CREATE TABLE airlines_countries(
  id SERIAL PRIMARY KEY,
  airline_id INTEGER REFERENCES airlines ON DELETE CASCADE,
  country_id INTEGER REFERENCES countries ON DELETE CASCADE
);

CREATE TABLE tickets
(
  id SERIAL PRIMARY KEY,
  customer_id INTEGER NOT NULL REFERENCES customers ON DELETE CASCADE,
  seat VARCHAR NOT NULL,
  departure TIMESTAMP NOT NULL,
  arrival TIMESTAMP NOT NULL,
  airline INTEGER REFERENCES airlines ON DELETE CASCADE NOT NULL,
  from_city INTEGER REFERENCES cities ON DELETE CASCADE NOT NULL,
  to_city INTEGER REFERENCES cities ON DELETE CASCADE NOT NULL
);


CREATE TABLE customers_tickets(
  id SERIAL PRIMARY KEY,
  ticket_id INTEGER REFERENCES tickets ON DELETE CASCADE NOT NULL,
  customer_id INTEGER REFERENCES customers on DELETE CASCADE NOT NULL
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
('Washington DC', (SELECT c.id FROM countries as c WHERE c.name='United States')),
('Seattle',  (SELECT c.id FROM countries as c WHERE c.name='United States')),
('Tokyo',  (SELECT c.id FROM countries as c WHERE c.name='United States')),
('London',  (SELECT c.id FROM countries as c WHERE c.name='United Kingdom')),
('Los Angeles', (SELECT c.id FROM countries as c WHERE c.name='United States')),
('Las Vegas', (SELECT c.id FROM countries as c WHERE c.name='United States')),
('Mexico City', (SELECT c.id FROM countries as c WHERE c.name='Mexico')),
('Paris', (SELECT c.id FROM countries as c WHERE c.name='France')),
('Casablanca', (SELECT c.id FROM countries as c WHERE c.name='Morocco')),
('Dubai', (SELECT c.id FROM countries as c WHERE c.name='UAE')),
('Beijing', (SELECT c.id FROM countries as c WHERE c.name='China')),
('New York', (SELECT c.id FROM countries as c WHERE c.name='United States')),
('Charlotte',(SELECT c.id FROM countries as c WHERE c.name='United States')),
('Cedar Rapids', (SELECT c.id FROM countries as c WHERE c.name='United States')),
('Chicago', (SELECT c.id FROM countries as c WHERE c.name='United States')),
('New Orleans',(SELECT c.id FROM countries as c WHERE c.name='United States')),
('Sao Paolo', (SELECT c.id FROM countries as c WHERE c.name='Brazil')),
('Santiago', (SELECT c.id FROM countries as c WHERE c.name='Chile'));

INSERT INTO customers
  (first_name, last_name)
VALUES
('Jennifer', 'Finch'),
('Thadeus', 'Gathercoal'),
('Sonja', 'Pauley'),
('Waneta', 'Skeleton'),
('Berkie', 'Wycliff'),
('Alvin', 'Leathes'),
('Cory', 'Squibbes');

INSERT INTO tickets 
  (customer_id,
  seat,
  departure,
  arrival,
  airline,
  from_city,
  to_city)
VALUES
((SELECT c.id FROM customers as c WHERE c.first_name='Jennifer' AND c.last_name='Finch'), 
'33B', 
'2018-04-08 09:00:00', 
'2018-04-08 12:00:00',
(SELECT a.id FROM airlines as a WHERE a.name='United'), 
(SELECT c.id FROM cities as c WHERE c.name='Washington DC'),
(SELECT c.id FROM cities as c WHERE c.name ='Seattle')
),
((SELECT c.id FROM customers as c WHERE c.first_name='Thadeus' AND c.last_name='Gathercoal'), 
'8A', 
'2018-12-19 12:45:00',
'2018-12-19 16:15:00',
(SELECT a.id FROM airlines as a WHERE a.name='British Airways'), 
(SELECT c.id FROM cities as c WHERE c.name='Tokyo'),
(SELECT c.id FROM cities as c WHERE c.name ='London')
),

((SELECT c.id FROM customers as c WHERE c.first_name='Sonja' AND c.last_name='Pauley'), 
'12F', 
'2018-01-02 07:00:00',
'2018-01-02 08:03:00',
(SELECT a.id FROM airlines as a WHERE a.name='Delta'), 
(SELECT c.id FROM cities as c WHERE c.name='Los Angeles'),
(SELECT c.id FROM cities as c WHERE c.name ='Las Vegas')
),

((SELECT c.id FROM customers as c WHERE c.first_name='Jennifer' AND c.last_name='Finch'), 
'20A', 
'2018-04-15 16:50:00',
'2018-04-15 21:00:00',
(SELECT a.id FROM airlines as a WHERE a.name='Delta'), 
(SELECT c.id FROM cities as c WHERE c.name='Seattle'),
(SELECT c.id FROM cities as c WHERE c.name ='Mexico City')
),

((SELECT c.id FROM customers as c WHERE c.first_name='Waneta' AND c.last_name='Skeleton'), 
'23D', 
'2018-08-01 18:30:00',
'2018-08-01 21:50:00',
(SELECT a.id FROM airlines as a WHERE a.name='TUI Fly Belgium'), 
(SELECT c.id FROM cities as c WHERE c.name='Paris'),
(SELECT c.id FROM cities as c WHERE c.name ='Casablanca')
),

((SELECT c.id FROM customers as c WHERE c.first_name='Thadeus' AND c.last_name='Gathercoal'), 
'18C', 
'2018-10-31 01:15:00',
'2018-10-31 12:55:00',
(SELECT a.id FROM airlines as a WHERE a.name='Air China'), 
(SELECT c.id FROM cities as c WHERE c.name='Dubai'),
(SELECT c.id FROM cities as c WHERE c.name ='Beijing')
),

((SELECT c.id FROM customers as c WHERE c.first_name='Berkie' AND c.last_name='Wycliff'), 
'9E', 
'2019-02-06 06:00:00',
'2019-02-06 07:47:00',
(SELECT a.id FROM airlines as a WHERE a.name='United'), 
(SELECT c.id FROM cities as c WHERE c.name='New York'),
(SELECT c.id FROM cities as c WHERE c.name ='Charlotte')
),

((SELECT c.id FROM customers as c WHERE c.first_name='Alvin' AND c.last_name='Leathes'), 
'1A', 
'2018-12-22 14:42:00',
'2018-12-22 15:56:00',
(SELECT a.id FROM airlines as a WHERE a.name='American Airlines'), 
(SELECT c.id FROM cities as c WHERE c.name='Cedar Rapids'),
(SELECT c.id FROM cities as c WHERE c.name ='Chicago')
),

((SELECT c.id FROM customers as c WHERE c.first_name='Berkie' AND c.last_name='Wycliff'), 
'32B', 
'2019-02-06 16:28:00',
'2019-02-06 19:18:00',
(SELECT a.id FROM airlines as a WHERE a.name='American Airlines'), 
(SELECT c.id FROM cities as c WHERE c.name='Charlotte'),
(SELECT c.id FROM cities as c WHERE c.name ='New Orleans')
),

((SELECT c.id FROM customers as c WHERE c.first_name='Cory' AND c.last_name='Squibbes'), 
'10D', 
'2019-01-20 19:30:00',
'2019-01-20 22:45:00',
(SELECT a.id FROM airlines as a WHERE a.name='Avianca Brasil'), 
(SELECT c.id FROM cities as c WHERE c.name='Sao Paolo'),
(SELECT c.id FROM cities as c WHERE c.name ='Santiago')
);

INSERT INTO customers_tickets
  (customer_id, ticket_id)
VALUES
((SELECT c.id FROM customers as c WHERE c.first_name='Jennifer' AND c.last_name='Finch'), (SELECT t.id FROM tickets as t WHERE t.id=1)),
((SELECT c.id FROM customers as c WHERE c.first_name='Thadeus' AND c.last_name='Gathercoal'), (SELECT t.id FROM tickets as t WHERE t.id=2)),
((SELECT c.id FROM customers as c WHERE c.first_name='Sonja' AND c.last_name='Pauley'), (SELECT t.id FROM tickets as t WHERE t.id=3)),
((SELECT c.id FROM customers as c WHERE c.first_name='Jennifer' AND c.last_name='Finch'), (SELECT t.id FROM tickets as t WHERE t.id=4)),
((SELECT c.id FROM customers as c WHERE c.first_name='Waneta' AND c.last_name='Skeleton'), (SELECT t.id FROM tickets as t WHERE t.id=5)),
((SELECT c.id FROM customers as c WHERE c.first_name='Thadeus' AND c.last_name='Gathercoal'), (SELECT t.id FROM tickets as t WHERE t.id=6)),
((SELECT c.id FROM customers as c WHERE c.first_name='Berkie' AND c.last_name='Wycliff'), (SELECT t.id FROM tickets as t WHERE t.id=7)),
((SELECT c.id FROM customers as c WHERE c.first_name='Alvin' AND c.last_name='Leathes'), (SELECT t.id FROM tickets as t WHERE t.id=8)),
((SELECT c.id FROM customers as c WHERE c.first_name='Berkie' AND c.last_name='Wycliff'), (SELECT t.id FROM tickets as t WHERE t.id=9)),
((SELECT c.id FROM customers as c WHERE c.first_name='Cory' AND c.last_name='Squibbes'), (SELECT t.id FROM tickets as t WHERE t.id=10));

INSERT INTO airlines_countries
  (airline_id, country_id)
VALUES
((SELECT a.id FROM airlines as a WHERE a.name='United'), (SELECT c.id FROM countries as c WHERE c.name='United States')),
((SELECT a.id FROM airlines as a WHERE a.name='American Airlines'), (SELECT c.id FROM countries as c WHERE c.name='United States')),
((SELECT a.id FROM airlines as a WHERE a.name='Avianca Brasil'), (SELECT c.id FROM countries as c WHERE c.name='Brazil')),
((SELECT a.id FROM airlines as a WHERE a.name='Avianca Brasil'), (SELECT c.id FROM countries as c WHERE c.name='Chile')),
((SELECT a.id FROM airlines as a WHERE a.name='Delta'), (SELECT c.id FROM countries as c WHERE c.name='United States')),
((SELECT a.id FROM airlines as a WHERE a.name='Delta'), (SELECT c.id FROM countries as c WHERE c.name='Mexico')),
((SELECT a.id FROM airlines as a WHERE a.name='British Airways'), (SELECT c.id FROM countries as c WHERE c.name='United Kingdom')),
((SELECT a.id FROM airlines as a WHERE a.name='British Airways'), (SELECT c.id FROM countries as c WHERE c.name='United States')),
((SELECT a.id FROM airlines as a WHERE a.name='TUI Fly Belgium'), (SELECT c.id FROM countries as c WHERE c.name='France')),
((SELECT a.id FROM airlines as a WHERE a.name='TUI Fly Belgium'), (SELECT c.id FROM countries as c WHERE c.name='Morocco')),
((SELECT a.id FROM airlines as a WHERE a.name='Air China'), (SELECT c.id FROM countries as c WHERE c.name='UAE')),
((SELECT a.id FROM airlines as a WHERE a.name='Air China'), (SELECT c.id FROM countries as c WHERE c.name='China'));