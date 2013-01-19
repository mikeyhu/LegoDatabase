mongo = require 'mongodb'

collectionName = "LegoSets"

exports.createMongostore = (connectionString)->

	connect:(fun)->
		mongoClient = mongo.MongoClient
		mongoClient.connect connectionString,fun
		
	insert:(data,fun)->
		@connect (err,db)->
			throw err if err
			collection = db.collection collectionName
			collection.insert data,{w:1},fun

