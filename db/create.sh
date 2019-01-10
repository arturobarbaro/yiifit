#!/bin/sh

if [ "$1" = "travis" ]; then
    psql -U postgres -c "CREATE DATABASE fit_test;"
    psql -U postgres -c "CREATE USER fit PASSWORD 'fit' SUPERUSER;"
else
    sudo -u postgres dropdb --if-exists fit
    sudo -u postgres dropdb --if-exists fit_test
    sudo -u postgres dropuser --if-exists fit
    sudo -u postgres psql -c "CREATE USER fit PASSWORD 'fit' SUPERUSER;"
    sudo -u postgres createdb -O fit fit
    sudo -u postgres psql -d fit -c "CREATE EXTENSION pgcrypto;" 2>/dev/null
    sudo -u postgres createdb -O fit fit_test
    sudo -u postgres psql -d fit_test -c "CREATE EXTENSION pgcrypto;" 2>/dev/null
    LINE="localhost:5432:*:fit:fit"
    FILE=~/.pgpass
    if [ ! -f $FILE ]; then
        touch $FILE
        chmod 600 $FILE
    fi
    if ! grep -qsF "$LINE" $FILE; then
        echo "$LINE" >> $FILE
    fi
fi
