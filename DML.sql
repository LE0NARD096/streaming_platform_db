INSERT INTO content_type (type_name)
VALUES
  ('album'),
  ('single'),
  ('podcast'),
  ('audio-books'),
  ('radio'),
  ('live-streaming'),
  ('audio-track');
SELECT 
    *
FROM
    content_type;
SELECT 
    *
FROM
    content_to_type;

INSERT INTO subscription_type (subscription_name)
VALUES
  ('daily'),
  ('weekly'),
  ('monthly'),
  ('yearly');
SELECT 
    *
FROM
    subscription_type;
SELECT 
    *
FROM
    subscription_to_type;

INSERT INTO content_genre (genre_name)
VALUES
  ('pop'),
  ('rock'),
  ('metal'),
  ('indie'),
  ('rap'),
  ('jazz'),
  ('blues'),
  ('techno');
SELECT 
    *
FROM
    content_type;
SELECT 
    *
FROM
    content_to_type;

### strong entity tables ###

INSERT INTO CUSTOMER (fullname, email, address, age, gender, language)
VALUES
  ('Marco Marconi', 'marco.marc@example', '123 Main St', 25, 'M', 'English'),
  ('Anna Annina', 'anna.a@example.com', '456 Elm St', 30, 'F', 'Italian'),
  ('Fabio Fabione', 'fabio.f33@example.com', '789 Oak St', 35, 'M', 'Italian'),
  ('Giovanni Giannoni', 'giova.gio@example.com', '789 Oak St', 35, 'M', 'French'),
  ('Lisa Li', 'lisa.l@example.com', '789 Oak St', 35, 'F', 'French');
  
INSERT INTO CONTENT (name, genre, price, type, production_company, upload_date, owner_ID)
VALUES
  ('Infinite Horizons', 'pop', 10, 'single', 'Production Co 1', '2023-01-01', 1),
  ('Oltre il confine', 'indie', 2, 'single', 'Production Co 2', '2023-02-01', 1),
  ('Un nuovo inizio', 'metal', 15, 'album', 'Production Co 3', '2023-03-01', 2),
  ('Luci nella notte', 'rap', 2, 'single', 'Production Co 1', '2023-02-01', 1),
  ('Sogno infinito', 'jazz', 2, 'single', 'Production Co 2', '2023-02-01', 1),
  ('Nel cuore dell’amore', 'pop', 2, 'single', 'Production Co 2', '2023-02-01', 1),
  ('Sussurri del Silenzio', 'blues', 2, 'single', 'Production Co 2', '2023-02-01', 1),
  ('Tra le Onde del Tempo', 'rock', 2, 'single', 'Production Co 1', '2023-02-03', 1),
  ('Conversazioni Intime', 'rock', 2, 'single', 'Production Co 2', '2023-02-23', 1),
  ('I Colori dell’Anima', 'rock', 2, 'single', 'Production Co 3', '2023-05-01', 3);
  
INSERT INTO PLAYLIST (name, type, owner_ID)
VALUES
  ('Energia Esplosiva','public', 1),
  ('Notte Magica', 'public', 2),
  ('Retro Vibes', 'private', 3),
  ('Indie Vibes', 'private', 3),
  ('Risveglio Sereno','public', 3);
  select * from playlist;

INSERT INTO SUBSCRIPTION_PLAN (name, type, end_date)
VALUES
  ('Melody Unlimited', 'monthly', '2023-03-30'),
  ('Rhythm Plus', 'yearly', '2024-06-30'),
  ('Harmony Pro', 'weekly', '2024-05-01');


### DML based on spcific cases ###

INSERT INTO LISTEN (content_ID, customer_ID, device_source, listen_date)
VALUES
((SELECT id FROM content WHERE name LIKE '%infinite%'),
(SELECT id FROM customer WHERE fullname like '%marc%'),
'smart_tv',
current_date()),
((SELECT id FROM content WHERE name LIKE '%infinite%'),
(SELECT id FROM customer WHERE fullname like '%lis%'),
'smartphone',
current_date()),
((SELECT id FROM content WHERE name LIKE '%confine%'),
(SELECT id FROM customer WHERE fullname like '%marc%'),
'smartphone',
current_date()),
((SELECT id FROM content WHERE name LIKE '%confine%'),
(SELECT id FROM customer WHERE fullname like '%lis%'),
'radio',
current_date()),
((SELECT id FROM content WHERE name LIKE '%inizio%'),
(SELECT id FROM customer WHERE fullname like '%marc%'),
'smart_tv',
current_date()),
((SELECT id FROM content WHERE name LIKE '%inizio%'),
(SELECT id FROM customer WHERE fullname like '%lis%'),
'smartphone',
current_date()),
((SELECT id FROM content WHERE name LIKE '%convers%'),
(SELECT id FROM customer WHERE fullname like '%giov%'),
'smart_tv',
current_date()),
((SELECT id FROM content WHERE name LIKE '%convers%'),
(SELECT id FROM customer WHERE fullname like '%anna%'),
'smartphone',
current_date()),
((SELECT id FROM content WHERE name LIKE '%anima%'),
(SELECT id FROM customer WHERE fullname like '%giov%'),
'smartphone',
current_date()),
((SELECT id FROM content WHERE name LIKE '%anima%'),
(SELECT id FROM customer WHERE fullname like '%anna%'),
'radio',
current_date())
;

INSERT INTO rate (content_ID , customer_ID , value)
VALUES
((SELECT id FROM content WHERE name LIKE '%infinite%'),
(SELECT id FROM customer WHERE fullname like '%marc%'),
3),
((SELECT id FROM content WHERE name LIKE '%infinite%'),
(SELECT id FROM customer WHERE fullname like '%lis%'),
1),
((SELECT id FROM content WHERE name LIKE '%confine%'),
(SELECT id FROM customer WHERE fullname like '%marc%'),
3),
((SELECT id FROM content WHERE name LIKE '%confine%'),
(SELECT id FROM customer WHERE fullname like '%lis%'),
5),
((SELECT id FROM content WHERE name LIKE '%inizio%'),
(SELECT id FROM customer WHERE fullname like '%marc%'),
4),
((SELECT id FROM content WHERE name LIKE '%inizio%'),
(SELECT id FROM customer WHERE fullname like '%lis%'),
2),
((SELECT id FROM content WHERE name LIKE '%convers%'),
(SELECT id FROM customer WHERE fullname like '%giov%'),
4),
((SELECT id FROM content WHERE name LIKE '%convers%'),
(SELECT id FROM customer WHERE fullname like '%anna%'),
5),
((SELECT id FROM content WHERE name LIKE '%anima%'),
(SELECT id FROM customer WHERE fullname like '%giov%'),
4),
((SELECT id FROM content WHERE name LIKE '%anima%'),
(SELECT id FROM customer WHERE fullname like '%anna%'),
3);

INSERT INTO part_of_playlist (content_ID , playlist_ID)
VALUES
((SELECT id FROM content WHERE name LIKE '%Infinite Horizo%'),
(SELECT id FROM playlist WHERE name like '%Risveglio Seren%')),
((SELECT id FROM content WHERE name LIKE '%oltre%'),
(SELECT id FROM playlist WHERE name like '%Risveglio Seren%')),
((SELECT id FROM content WHERE name LIKE '%inizio%'),
(SELECT id FROM playlist WHERE name like '%Risveglio Seren%')),
((SELECT id FROM content WHERE name LIKE '%iniz%'),
(SELECT id FROM playlist WHERE name like '%notte%')),
((SELECT id FROM content WHERE name LIKE '%luci%'),
(SELECT id FROM playlist WHERE name like '%notte%')),
((SELECT id FROM content WHERE name LIKE '%sogno%'),
(SELECT id FROM playlist WHERE name like '%Energia Esplosiv%')),
((SELECT id FROM content WHERE name LIKE '%cuore%'),
(SELECT id FROM playlist WHERE name like '%Energia Esplosiv%')),
((SELECT id FROM content WHERE name LIKE '%sussu%'),
(SELECT id FROM playlist WHERE name like '%Energia Esplosiv%'));

INSERT INTO part_of_subscription (content_ID , subscription_ID)
VALUES
((SELECT id FROM content WHERE name LIKE '%inizio%'),
(SELECT id FROM subscription_plan WHERE name like '%harmony%')),
((SELECT id FROM content WHERE name LIKE '%confine%'),
(SELECT id FROM subscription_plan WHERE name like '%harmony%')),
((SELECT id FROM content WHERE name LIKE '%notte%'),
(SELECT id FROM subscription_plan WHERE name like '%harmony%')),
((SELECT id FROM content WHERE name LIKE '%sogno%'),
(SELECT id FROM subscription_plan WHERE name like '%harmony%')),
((SELECT id FROM content WHERE name LIKE '%cuore%'),
(SELECT id FROM subscription_plan WHERE name like '%harmony%')),
((SELECT id FROM content WHERE name LIKE '%sussu%'),
(SELECT id FROM subscription_plan WHERE name like '%melody%')),
((SELECT id FROM content WHERE name LIKE '%onde%'),
(SELECT id FROM subscription_plan WHERE name like '%melody%'))
;

INSERT INTO subscription (customer_ID , subscription_ID, start_date, payement_method)
VALUES(
(SELECT id FROM customer WHERE fullname LIKE '%fab%'),
(SELECT id FROM subscription_plan WHERE name LIKE '%harm%'),
date_sub(current_date(), interval 8 day),
'credit_card'
),
((SELECT id FROM customer WHERE fullname LIKE '%mar%'),
(SELECT id FROM subscription_plan WHERE name LIKE '%rhy%'),
'2023-06-04',
'credit_card'),
(
(SELECT id FROM customer WHERE fullname LIKE '%lis%'),
(SELECT id FROM subscription_plan WHERE name LIKE '%mel%'),
'2023-03-12',
'credit_card'),
(
(SELECT id FROM customer WHERE fullname LIKE '%gio%'),
(SELECT id FROM subscription_plan WHERE name LIKE '%mel%'),
'2023-01-30',
'debit_card'
),
(
(SELECT id FROM customer WHERE fullname LIKE '%fab%'),
(SELECT id FROM subscription_plan WHERE name LIKE '%mel%'),
current_date(),
'cryptocurrency'
);

### to multivalued DML ###

INSERT INTO content_to_genre (content_ID , genre_ID)
select content.ID, content_genre.ID from
content join content_genre on content.genre=content_genre.genre_name;
select * from content_to_genre;

INSERT INTO content_to_type (content_ID , type_ID)
select content.ID, content_type.ID from
content join content_type on content.type=content_type.type_name;
select * from content_to_type;

INSERT INTO subscription_to_type (subscription_ID , type_ID)
select subscription_plan.ID, subscription_type.ID from
subscription_plan join subscription_type on subscription_plan.type=subscription_type.subscription_name;
select * from subscription_to_type;