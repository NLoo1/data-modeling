-- from the terminal run:
-- psql < music.sql

DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music

CREATE TABLE artists(
id SERIAL PRIMARY KEY,
name TEXT NOT NULL
);

INSERT INTO artists
(name)
VALUES
('Hanson'),
('Queen'),
('Mariah Carey'),
('Boyz II Men'),
('Lady Gaga'),
('Bradley Cooper'),
('Nickelback'),
('Jay Z'),
('Alicia Keys'),
('Katy Perry'),
('Juicy J'),
('Maroon 5'),
('Christina Aguilera'),
('Avril Lavigne'),
('Destiny''s Child');

CREATE TABLE producers(
id SERIAL PRIMARY KEY,
name TEXT NOT NULL
);

INSERT INTO producers
(name)
VALUES
('Dust Brothers'),
('Stephen Lironi'),
('Roy Thomas Baker'),
('Walter Afanasieff'),
('Benjamin Rice'),
('Rick Parashar'),
('Al Shux'),
('Max Martin'),
('Cirkut'),
('Shellback'),
('Benny Blanco'),
('The Matrix'),
('Darkchild');

CREATE TABLE albums(
id SERIAL PRIMARY KEY,
release_date DATE NOT NULL
);

CREATE TABLE album_artists(
album_id INTEGER REFERENCES albums(id) ON DELETE CASCADE,
artist_id INTEGER REFERENCES artists(id) ON DELETE CASCADE,
PRIMARY KEY (album_id, artist_id)
);

CREATE TABLE album_producers(
album_id INTEGER REFERENCES albums(id) ON DELETE CASCADE,
producer_id INTEGER REFERENCES producers(id) ON DELETE CASCADE,
PRIMARY KEY (album_id, producer_id)
);

INSERT INTO albums
(id, release_date)
VALUES
(1, '1997-04-15'),
(2, '1975-10-31'),
(3, '1995-11-14'),
(4, '2018-09-27'),
(5, '2001-08-21'),
(6, '2009-10-20'),
(7, '2013-12-17'),
(8, '2011-06-21'),
(9, '2002-05-14'),
(10, '1999-11-07');

INSERT INTO album_artists
(album_id, artist_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 5),
(5, 7),
(6, 8),
(7, 10),
(8, 12),
(9, 14),
(10, 15);

INSERT INTO album_producers
(album_id, producer_id)
VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 6),
(6, 7),
(7, 8),
(8, 9),
(9, 10);

CREATE TABLE songs
(
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  duration_in_seconds INTEGER NOT NULL,
  album_id INTEGER REFERENCES albums(id) ON DELETE CASCADE
);

INSERT INTO songs
  (title, duration_in_seconds, album_id)
VALUES
  ('MMMBop', 238, 1),
  ('Bohemian Rhapsody', 355, 2),
  ('One Sweet Day', 282, 3),
  ('Shallow', 216, 4),
  ('How You Remind Me', 223, 5),
  ('New York State of Mind', 276, 6),
  ('Dark Horse', 215, 7),
  ('Moves Like Jagger', 8, 8),
  ('Complicated', 244, 9),
  ('Say My Name', 240, 10);
