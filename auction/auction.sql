-- DB SETUP START
CREATE TABLE bidders (id serial PRIMARY KEY, name text NOT NULL);

CREATE TABLE items (
  id serial PRIMARY KEY,
  name text NOT NULL,
  initial_price numeric(6, 2) NOT NULL CHECK (
    initial_price BETWEEN 0.01 AND 1000.00
  ),
  sales_price numeric(6, 2) CHECK (
    sales_price BETWEEN 0.01 AND 1000.00
  )
);

CREATE TABLE bids (
  id serial PRIMARY KEY,
  bidder_id integer NOT NULL REFERENCES bidders(id) ON DELETE CASCADE,
  item_id integer NOT NULL REFERENCES items(id) ON DELETE CASCADE,
  amount numeric(6, 2) NOT NULL CHECK (
    amount BETWEEN 0.01 AND 1000.00
  )
);

CREATE INDEX ON bids (bidder_id, item_id);

COPY bidders
FROM '/tmp/sql/bidders.csv' WITH DELIMITER ',' CSV HEADER;

COPY items
FROM '/tmp/sql/items.csv' WITH DELIMITER ',' CSV HEADER;

COPY bids
FROM '/tmp/sql/bids.csv' WITH DELIMITER ',' CSV HEADER;

-- DB SETUP END
SELECT *
FROM bidders;

INSERT INTO bidders
VALUES (8, 'Daniel Chae'),
  (9, 'Justin Moon');

SELECT *
FROM bidders;