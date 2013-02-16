_ = require 'underscore'

exports.createSearch = (mongostore)->

	getResults:(search,fun)->
		res = {}
		facets = ["theme","year"]

		fin = (facetName,expected)->(err,results)->
			res[facetName] = results
			fun(null,res) if _.keys(res).length == expected

		mongostore.getSets search, fin("sets",facets.length+1)
		for facet in facets
			mongostore.getFacet search, facet, fin(facet,facets.length+1)
