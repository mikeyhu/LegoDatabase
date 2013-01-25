#!/bin/bash
rm -rf test/resources/database/*
rm -rf log/database.log
mongod --pidfilepath test/resources/database.pid --nssize 1 --smallfiles --noprealloc --dbpath test/resources/database/ > log/database.log &