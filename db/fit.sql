------------------------------
-- Archivo de base de datos --
------------------------------

DROP TABLE IF EXISTS usuarios CASCADE;

CREATE TABLE usuarios
(
    id         BIGSERIAL    PRIMARY KEY
    , login      VARCHAR(50)  NOT NULL UNIQUE
    CONSTRAINT ck_login_sin_espacios
    CHECK (login NOT LIKE '% %')
    , email      VARCHAR(255) NOT NULL
    , password   VARCHAR(255) NOT NULL
    , nombre     VARCHAR(255) NOT NULL
    , apellido   VARCHAR(255) NOT NULL
    , biografia  VARCHAR(255)
    , genero     VARCHAR(60)  NOT NULL
    , peso       SMALLINT     DEFAULT 70
    CONSTRAINT ck_entrenamientos_peso_valido
    CHECK (coalesce(peso, 0) >= 40 AND coalesce(peso, 0) <= 150)
    , altura     SMALLINT     DEFAULT 170
    CONSTRAINT ck_entrenamientos_altura_valida
    CHECK (coalesce(altura, 0) >= 140 AND coalesce(altura, 0) <= 220)
    , fechaNac   DATE
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
DROP TABLE IF EXISTS actividades CASCADE;

CREATE TABLE actividades
(
    id        BIGSERIAL    PRIMARY KEY
  , actividad VARCHAR(255) NOT NULL UNIQUE
  , gastoCalorico NUMERIC(4) NOT NULL
);

DROP TABLE IF EXISTS entrenamientos CASCADE;

CREATE TABLE entrenamientos
(
    id            BIGSERIAL    PRIMARY KEY
  , usuario_id    BIGINT       NOT NULL
                               REFERENCES usuarios (id)
                               ON DELETE NO ACTION
                               ON UPDATE CASCADE
  , actividad_id  BIGINT       NOT NULL
                               REFERENCES actividades (id)
                               ON DELETE NO ACTION
                               ON UPDATE CASCADE
  , anotacion     VARCHAR(255)
  , fecha         TIMESTAMP    NOT NULL
  , duracion      SMALLINT     DEFAULT 0
                               CONSTRAINT ck_entrenamientos_duracion_positiva
                               CHECK (coalesce(duracion, 0) >= 0)

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
INSERT INTO usuarios (login, email, password, nombre, apellido, biografia, genero, peso, altura, fechaNac)
VALUES ('pepe', 'pepe@hotmail.com', crypt('pepe', gen_salt('bf', 10)), 'Pepe', 'Garcia', 'Soy pepe', 'hombre', 70,180,null)
     , ('admin', 'aaa', crypt('admin', gen_salt('bf', 10)),'Admin', 'admin', 'Soy admin', 'hombre', 70,180,null);

INSERT INTO actividades (actividad, gastoCalorico)
VALUES ('Caminar', 006)
     , ('Ciclismo', 012)
     , ('Correr', 015)
     , ('Crossfit', 016)
     , ('Entrenamiento de fuerza', 014)
     , ('Otro', 0);

INSERT INTO entrenamientos (usuario_id, actividad_id, anotacion, fecha, duracion)
VALUES (1,2,'',DEFAULT,15)
     , (1,3,'...',DEFAULT,30);
