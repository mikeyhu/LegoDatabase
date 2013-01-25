mongostore = require '../../src/server/mongostore.coffee'
should = require 'should'

connectionString = "mongodb://localhost:27017/legodb"

describe 'A mongodb store', ->
	beforeEach () ->
		@ms = mongostore.createMongostore(connectionString)

	it 'should be able to record data in the datastore', (done)->
		@ms.connect (err,db)->
			throw err if err
			done()
	it 'should be able to insert a set into the datastore', (done)->
		@ms.insert {name:"mike"},(err,result)->
			throw err if err
			result[0].name.should.equal("mike")
			should.exist(result[0]._id)
			done()
	