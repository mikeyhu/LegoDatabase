bulkCollector = require './bulkcollector.coffee'

connectionString = "mongodb://localhost:27017/legodb"
bc = bulkCollector.createBulkCollector connectionString,bulkCollector.url

data = []
stdin = process.openStdin()
stdin.on 'data', (buffer) ->
	data = buffer.toString().split("\n") if buffer
stdin.on 'end', ->
	bc.insertSets data,(err,result)->
		throw err if err
		console.log 'Finished inserting documents'