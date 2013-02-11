_ = require 'underscore'

exports.createSearch = (mongostore)->

	getResults:(fun)->
		res = {}
		facets = ["theme","year"]
		fin = (facetName)->(err,results)->
			res[facetName] = results
			fun(null,res) if _.keys(res).length == facets.length
		for facet in facets
			mongostore.getFacet facet, fin(facet)

