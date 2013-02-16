mongostore = require '../../src/server/mongostore.coffee'
domain = require '../../src/server/domain.coffee'
should = require 'should'

connectionString = "mongodb://localhost:27000/legodb"

describe 'A domain', ->
	beforeEach (done) ->
		@ms = mongostore.createMongostore(connectionString)
		@ms.clear (err,result)->
			done()

	it 'should be able to get multiple facets', (done)->
		data = [
			{"setID":"111","setName":"Y-Wing","theme":"Star Wars","year":"1996"},
			{"setID":"222","setName":"X-Wing","theme":"Star Wars","year":"1998"},
			{"setID":"333","setName":"Alien","theme":"Space","year":"1998"}]
		@ms.insert data,(err,result)=>
			d = domain.createSearch(@ms)
			d.getResults null,(err,result)->
				result.sets.length.should.equal 3
				result.sets[0].setID.should.equal "111"
				result.theme.should.eql [{_id:"Star Wars",count:2},{_id:"Space",count:1}]
				result.year.should.eql [{_id:"1998",count:2},{_id:"1996",count:1}]
				done()