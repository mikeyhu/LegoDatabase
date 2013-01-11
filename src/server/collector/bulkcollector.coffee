xml2js = require 'xml2js'

exports.createBulkCollector = ()->

	parseXml:(data,fun) ->
		parser = new xml2js.Parser()
		parser.parseString data, fun