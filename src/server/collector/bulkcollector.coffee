xml2js = require 'xml2js'
http = require 'http'


#example url:
#	http://www.brickset.com/webservices/brickset.asmx/search?apiKey=&userHash=&query=&theme=&subtheme=&year=&owned=&wanted=&setNumber=10030-1
exports.createBulkCollector = (urlGenerator)->

	setInformation:(setNumber,fun)->
		@requestSetXml setNumber,(data)=>
			@parseXml data,fun

	requestSetXml:(setNumber,fun)->
		http.get urlGenerator(setNumber), (res) ->
			res.setEncoding('utf8')
			res.on 'data', (chunk)->
				fun(chunk)
		.on 'error', (e)->	
			console.log("Got error: " + e.message)

	parseXml:(data,fun) ->
		parser = new xml2js.Parser()
		parser.parseString data, (err,result)->
			fun(err,result.ArrayOfSetData.setData[0])

exports.url = (urlGenerator)-> "http://www.brickset.com/webservices/brickset.asmx/search?apiKey=&userHash=&query=&theme=&subtheme=&year=&owned=&wanted=&setNumber=#{urlGenerator}-1"