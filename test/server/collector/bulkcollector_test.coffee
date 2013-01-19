bulkcollector = require '../../../src/server/collector/bulkcollector.coffee'
require 'should'
require './fakesetserver.coffee'
fs = require 'fs'

describe 'A bulk collector', ->
	beforeEach () ->
		@bc = bulkcollector.createBulkCollector (urlGenerator)-> "http://localhost:7777/#{urlGenerator}.xml"

	it 'should be able to parse the lego set XML', (done)->
		fs.readFile __dirname + '/resources/test.xml','utf8', (err, data)=>
			throw err if err
			@bc.parseXml data,(err,result)->
				result.setID.should.eql(["1"])
				result.setName.should.eql(["Test set"])
				done()
	it 'should be able to retrieve and parse some XML', (done)->
		@bc.requestSetXml "test",(result)->
			result.should.not.be.empty
			done()
	it 'should be able to retrieve some XML and turn it into an object', (done)->
		@bc.setInformation "test",(err,result)->
			result.theme.should.eql(["Test theme"])
			done()
	it 'should be able to generate a url to brickset',->
		bulkcollector.url("10030").should.equal("http://www.brickset.com/webservices/brickset.asmx/search?apiKey=&userHash=&query=&theme=&subtheme=&year=&owned=&wanted=&setNumber=10030-1")
	it 'should be able to retrieve a set by sending in an array',(done)->
		@bc.collectSets ["test"],(err,result)->
			result.length.should.equal(1)
			result[0].number.should.eql(["1"])
			done()
	it 'should be able to retrieve more than one set',(done)->
		@bc.collectSets ["10030","928"],(err,result)->
			result.length.should.equal(2)
			result[0].number.should.eql(["10030"])
			result[1].number.should.eql(["928"])
			done()