Lego Database
=============
The LegoDatabase project was created as an exercise to learn more about the following technologies: CoffeeScript, Node.js, MongoDB.

The project has two parts:
1. harvest set data into MongoDB by using [Brickset.com](http://www.brickset.com)'s excellent Set [API](http://www.brickset.com/webservices/).

2. run a webserver to display your sets using facets, these are generated using MongoDBs aggregation framework.

Usage
-----
To put data into MongoDB from Brickset and then start the site, just use:

	ops/start-dev-mongodb.sh
	cat sets.txt | coffee src/server/collector/runcollector.coffee
	cake dev

To run tests, just do:

	./run-tests.sh

