bulkcollector = require '../../../src/server/collector/bulkcollector.coffee'
require 'should'


describe 'A bulk collector', ->
	beforeEach () ->
		@bc = bulkcollector.createBulkCollector()
	it 'should be able to parse XML', (done)->
		xml = "<a><b>123</b><c>xyz</c></a>"
		@bc.parseXml xml,(err,result)->
			result.a.b.should.eql(["123"])
			result.a.c.should.eql(["xyz"])
			done()
