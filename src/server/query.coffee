_ = require 'underscore'
qs = require 'querystring'

exports.createQuery = (previousQuery)->

	extendQuery:(name,value)->
		if previousQuery.hasOwnProperty name
			_.omit(previousQuery,name)
		else
			q=_.clone(previousQuery)
			q[name]=value
			q


	extendQuerystring:(name,value)->
		"?"+qs.stringify(@extendQuery(name,value))
		
