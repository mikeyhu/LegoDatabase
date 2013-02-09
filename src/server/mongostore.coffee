mongo = require 'mongodb'

collectionName = "LegoSets"

exports.createMongostore = (connectionString)->

	connect:(fun)->
		mongoClient = mongo.MongoClient
		mongoClient.connect connectionString,(err,db)->
			fun err,null if err
			collection = db.collection collectionName
			fun null,collection


	clear:(fun)->
		@connect (err,collection)->
			throw err if err
			collection.remove {},fun

	count:(fun)->
		@connect (err,collection)->
			fun err,null if err
			collection.count fun

	insert:(data,fun)->
		@connect (err,collection)->
			throw err if err
			collection.insert data,{w:1},fun

	getFacet:(facetName,fun)->
		@connect (err,collection)->
			throw err if err
			collection.aggregate [{$group:{_id:"$"+facetName,count:{$sum:1}}},{$sort:{count:-1}}],[],fun



# example aggregation query to do facet on theme:
# db.LegoSets.aggregate({$group:{_id:"$theme", count: {$sum:1}}},{$sort: {count:-1}})