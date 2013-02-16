server = require '../../src/server/webserver.coffee'
mongostore = require '../../src/server/mongostore.coffee'
Browser = require 'zombie'
should = require 'should'

port = process.env.PORT
mongoPort = process.env.MONGOPORT
baseUrl = "http://localhost:#{port}/"
connectionString = "mongodb://localhost:#{mongoPort}/legodb"

describe 'Requesting the homepage', ()->
	before (done)->
		@ms = mongostore.createMongostore(connectionString)
		@ms.clear (err,result)=>
			data = [
				{"setID":"111","setName":"Y-Wing","theme":"Star Wars","year":"1996"},
				{"setID":"222","setName":"X-Wing","theme":"Star Wars","year":"1998"},
				{"setID":"333","setName":"Alien","theme":"Space","year":"1998"}]	
			@ms.insert data,(err,result)=>
				@browser = new Browser()
				@browser.visit(baseUrl).then(done, done)

	it 'should load the page with 3 sets on', ()->
		@browser.success.should.equal true
		@browser.queryAll(".set").length.should.equal 3

	it 'should load the page with a theme facet', ()->
		firstFacet = @browser.query(".facet")
		@browser.text("div",firstFacet).should.equal "Theme"

