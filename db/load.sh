#!/bin/sh

BASE_DIR=$(dirname $(readlink -f "$0"))
if [ "$1" != "test" ]; then
    psql -h localhost -U fit -d fit < $BASE_DIR/fit.sql
fi
psql -h localhost -U fit -d fit_test < $BASE_DIR/fit.sql
