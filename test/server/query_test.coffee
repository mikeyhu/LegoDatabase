query = require '../../src/server/query.coffee'
should = require 'should'

describe 'A query', ->
	it 'should be able to add values to the query',->
		q=query.createQuery({})
		q.extendQuery("a","b").should.eql {"a":"b"}
	it 'should be able to getQuery with multiple values without them being added',->
		q=query.createQuery({"1":"2"})
		q.extendQuery("a","b").should.eql {"1":"2","a":"b"}
		q.extendQuery("c","d").should.eql {"1":"2","c":"d"}
	it 'should remove the facet from the query if it already exists',->
		q=query.createQuery({"a":"2"})
		q.extendQuery("a","3").should.eql {}
	it 'should be able to output a querystring',->
		q=query.createQuery({})
		q.extendQuerystring("a","b").should.equal "?a=b"
	it 'should be able to output multiple querystring values',->
		q=query.createQuery({"1":"2"})
		q.extendQuerystring("a","b").should.equal "?1=2&a=b"

