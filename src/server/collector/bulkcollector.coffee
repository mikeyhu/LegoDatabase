xml2js = require 'xml2js'
http = require 'http'
mongostore = require '../mongostore.coffee'
_ = require 'underscore'

#example url:
#	http://www.brickset.com/webservices/brickset.asmx/search?apiKey=&userHash=&query=&theme=&subtheme=&year=&owned=&wanted=&setNumber=10030-1
exports.url = (setNumber)-> "http://www.brickset.com/webservices/brickset.asmx/search?apiKey=&userHash=&query=&theme=&subtheme=&year=&owned=&wanted=&setNumber=#{setNumber}-1"

exports.createBulkCollector = (connectionString, urlGenerator)->

	setInformation:(setNumber,fun)->
		console.log "Retrieving:#{setNumber}"
		@requestSetXml setNumber,(data)=>
			@parseXml data,fun

	requestSetXml:(setNumber,fun)->
		data=""
		http.get urlGenerator(setNumber), (res) ->
			res.setEncoding('utf8')
			res.on 'data', (chunk)->
				data=data+chunk
			res.on 'end', ()->
				fun(data)
		.on 'error', (e)->	
			console.log("Got error: " + e.message)

	parseXml:(data,fun) ->
		parser = new xml2js.Parser()
		parser.parseString data, (err,result)->
			throw err if err
			set = _.pick result?.ArrayOfSetData.setData[0],
				'number','setName','year','theme','subtheme','pieces','minifigs','thumbnailURL'
			fun(err,set)

	collectSets:(listOfSetNumbers,fun,current=0,listOfResults=[])->
		if listOfSetNumbers.length <= current then fun(null,listOfResults)
		else
			@setInformation listOfSetNumbers[current], (err,result)=>
				throw err if err
				listOfResults.push result 
				process.nextTick ()=>
					@collectSets listOfSetNumbers,fun,current+1,listOfResults

	insertSets:(listOfSetNumbers,fun)->
		@collectSets listOfSetNumbers,(err,listOfResults)->
			ms = mongostore.createMongostore connectionString
			ms.insert listOfResults,fun
