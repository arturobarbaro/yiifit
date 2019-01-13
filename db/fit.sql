------------------------------
-- Archivo de base de datos --
------------------------------

/* DROP TABLE IF EXISTS actividades CASCADE;

CREATE TABLE actividades
(
    id     BIGSERIAL    PRIMARY KEY
  , actividad VARCHAR(255) NOT NULL UNIQUE
  , gastoCalorico NUMERIC(4) NOT NULL
); */

DROP TABLE IF EXISTS entrenamientos CASCADE;

CREATE TABLE entrenamientos
(
    id            BIGSERIAL    PRIMARY KEY
  , actividad     VARCHAR(255) NOT NULL UNIQUE
  , gastoCalorico NUMERIC(4)   NOT NULL
  , anotacion     VARCHAR(255)
  , fecha         TIMESTAMP    NOT NULL
  , duracion      SMALLINT     DEFAULT 0
                               CONSTRAINT ck_entrenamientos_duracion_positiva
                               CHECK (coalesce(duracion, 0) >= 0)
  /* , actividad_id BIGINT       NOT NULL
                           REFERENCES actividades (id)
                           ON DELETE NO ACTION
                           ON UPDATE CASCADE */
);

DROP TABLE IF EXISTS usuarios CASCADE;

CREATE TABLE usuarios
(
    id         BIGSERIAL    PRIMARY KEY
  , login      VARCHAR(50)  NOT NULL UNIQUE
                            CONSTRAINT ck_login_sin_espacios
                            CHECK (login NOT LIKE '% %')
  , email      VARCHAR(255) NOT NULL UNIQUE
  , password   VARCHAR(255) NOT NULL
  , nombre     VARCHAR(255) NOT NULL
  , apellido   VARCHAR(255) NOT NULL
  , biografia  VARCHAR(255)
  , genero     VARCHAR(60)  NOT NULL
  , peso       SMALLINT     DEFAULT 70
                            CONSTRAINT ck_entrenamientos_peso_valido
                            CHECK (coalesce(duracion, 0) >= 40 AND coalesce(duracion, 0) <= 150)
  , altura     SMALLINT     DEFAULT 170
                            CONSTRAINT ck_entrenamientos_altura_valida
                            CHECK (coalesce(duracion, 0) >= 140 AND coalesce(duracion, 0) <= 220)
  , fechaNac   DATE         NOT NULL
  , url_avatar VARCHAR(255)
  , auth_key   VARCHAR(255)
  , created_at TIMESTAMP(0) NOT NULL DEFAULT LOCALTIMESTAMP
  , updated_at TIMESTAMP(0)

);

DROP TABLE IF EXISTS seguidores CASCADE;

CREATE TABLE seguidores
(
    id             BIGSERIAL    PRIMARY KEY
  , seguidor_id    BIGINT       NOT NULL
                                REFERENCES usuarios (id)
                                ON DELETE NO ACTION
                                ON UPDATE CASCADE
  , seguido_id     BIGINT       NOT NULL
                                REFERENCES usuarios (id)
                                ON DELETE NO ACTION
                                ON UPDATE CASCADE
);

DROP TABLE IF EXISTS eventos CASCADE;

CREATE TABLE eventos
(
    id                  BIGSERIAL    PRIMARY KEY
  , entrenamiento_id    BIGINT       NOT NULL
                                     REFERENCES entrenamientos (id)
                                     ON DELETE NO ACTION
                                     ON UPDATE CASCADE
  , usuario_id          BIGINT       NOT NULL
                                     REFERENCES usuarios (id)
                                     ON DELETE NO ACTION
                                     ON UPDATE CASCADE
);

--GRUPOS PARA ACTIVIDADES GRUPALES???????


-- INSERT

INSERT INTO usuarios (login, password, genero, peso, altura, fechaNacimiento)
VALUES ('pepe', crypt('pepe', gen_salt('bf', 10)),70,180)
     , ('admin', crypt('admin', gen_salt('bf', 10)));

INSERT INTO actividades (actividad)
VALUES ('Caminar', 0.06)
     , ('Ciclismo', 0.12)
     , ('Correr', 0.15)
     , ('Crossfit', 0.16)
     , ('Entrenamiento de fuerza', 0.14)
     , ('Otro', 0);

INSERT INTO entrenamientos (titulo, anyo, sinopsis, duracion, actividad_id)
VALUES ('Los últimos Jedi', 2017, 'Va uno y se cae...', 204, 3)
     , ('Los Goonies', 1985, 'Unos niños encuentran un tesoro', 120, 5)
     , ('Aquí llega Condemor', 1996, 'Mejor no cuento nada...', 90, 1);

DROP TABLE IF EXISTS personas CASCADE;

CREATE TABLE personas
(
    id BIGSERIAL PRIMARY KEY
  , nombre VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS roles CASCADE;

CREATE TABLE roles
(
    id BIGSERIAL PRIMARY KEY
  , rol VARCHAR(255) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS participantes CASCADE;

CREATE TABLE participantes
(
    pelicula_id BIGINT REFERENCES entrenamientos (id)
  , persona_id  BIGINT REFERENCES personas (id)
  , rol_id      BIGINT REFERENCES roles (id)
  , PRIMARY KEY (pelicula_id, persona_id, rol_id)
);

INSERT INTO personas (nombre)
VALUES ('2pac')
     , ('haze')
     , ('goku');

INSERT INTO roles (rol)
VALUES ('Director')
     , ('Actor')
     , ('Guionista');

INSERT INTO participantes (pelicula_id, persona_id, rol_id)
VALUES (1,1,1)
     , (1,2,3)
     , (2,3,2);
