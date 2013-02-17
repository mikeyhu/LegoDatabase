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
			fun err,null if err
			collection.remove {},fun

	count:(fun)->
		@connect (err,collection)->
			fun err,null if err
			collection.count fun

	insert:(data,fun)->
		@connect (err,collection)->
			fun err,null if err
			collection.insert data,{w:1},fun

	getSets:(search,fun)->
		@connect (err,collection)->
			fun err,null if err
			collection.find(search).toArray fun

	getFacet:(search,facetName,fun)->
		@connect (err,collection)->
			fun err,null if err
			query=
				if search? then [{$match:search}]
				else []
			collection.aggregate query.concat([{$group:{_id:"$"+facetName,count:{$sum:1}}},{$sort:{count:-1}}]),[],fun
