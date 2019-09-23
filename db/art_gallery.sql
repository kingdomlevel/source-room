DROP TABLE artist_exhibitions;
DROP TABLE exhibition_images;
DROP TABLE exhibitions;
DROP TABLE artists;

CREATE TABLE artists(
    id              SERIAL8         PRIMARY KEY,
    name            VARCHAR(255)    NOT NULL,
    year_born       INT4,
    hometown        VARCHAR(255)
);

CREATE TABLE exhibitions(
    id              SERIAL8         PRIMARY KEY,
    title           VARCHAR(255)    NOT NULL,
    start_date      DATE,
    end_date        DATE,
    description     TEXT
);

CREATE TABLE artist_exhibitions (
    id              SERIAL8         PRIMARY KEY,
    artist_id       INT8            REFERENCES artists(id) NOT NULL,
    exhibition_id   INT8            REFERENCES exhibitions(id) NOT NULL
);

CREATE TABLE exhibition_images (
    id              SERIAL8         PRIMARY KEY,
    exhibition_id   INT8            REFERENCES exhibitions(id) NOT NULL,
    image_url       VARCHAR(800)
);

