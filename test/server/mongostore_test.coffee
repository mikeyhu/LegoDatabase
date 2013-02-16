mongostore = require '../../src/server/mongostore.coffee'
should = require 'should'

connectionString = "mongodb://localhost:27000/legodb"

setData = [
	{"setID":"111","setName":"Y-Wing","theme":"Star Wars","year":"1996"},
	{"setID":"222","setName":"X-Wing","theme":"Star Wars","year":"1998"},
	{"setID":"333","setName":"Alien","theme":"Space","year":"1998"}]

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
		@ms.insert setData,(err,result)=>
			@ms.getFacet null,"theme",(err,result)->
				result.should.eql [{_id:"Star Wars",count:2},{_id:"Space",count:1}]
				for facet in result when facet._id=="Star Wars" 
					facet.count.should.equal 2
				done()
	
	it 'should be able to get facet information with an existing facet search', (done)->
		done()

	it 'should be able to get Set information', (done)->			
		@ms.insert setData,(err,result)=>
			@ms.getSets null,(err,result)->
				result.length.should.equal 3
				result[0].theme.should.equal "Star Wars"
				done()

	it 'should be able to get Set information with an existing facet search', (done)->
		@ms.insert setData,(err,result)=>
			facets={"theme":"Star Wars"}
			@ms.getSets facets,(err,result)->
				result.length.should.equal 2
				done()
