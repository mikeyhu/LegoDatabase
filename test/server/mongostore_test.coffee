mongostore = require '../../src/server/mongostore.coffee'
should = require 'should'

connectionString = "mongodb://localhost:27000/legodb"

describe 'A mongodb store', ->
	beforeEach (done) ->
		@ms = mongostore.createMongostore(connectionString)
		@ms.clear (err,result)->
			done()

	it 'should be able to insert data into the datastore', (done)->
		@ms.insert {name:"mike"},(err,result)=>
			throw err if err
			result[0].name.should.equal("mike")
			should.exist result[0]._id
			done()

	it 'should be able to delete data from the datastore and count results', (done)->
		@ms.count (err,result)=>
			result.should.equal 0
			@ms.insert {name:"mike"},(err,result)=>
				@ms.count (err,result)=>
					result.should.equal 1
					@ms.clear (err,result)=>
						@ms.count (err,result)->
							result.should.equal 0
							done()

	it 'should be able to get facet information about data in the db', (done)->
		data = [
				{"theme":"Star Wars"},
				{"theme":"Star Wars"},
				{"theme":"Space"}]
		@ms.insert data,(err,result)=>
			@ms.getFacet "theme",(err,result)->
				result.should.eql [{_id:"Star Wars",count:2},{_id:"Space",count:1}]
				for facet in result when facet._id=="Star Wars" 
					facet.count.should.equal 2
				done()
				

