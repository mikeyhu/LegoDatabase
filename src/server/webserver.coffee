express = require 'express'
mongostore = require './mongostore.coffee'
domain = require './domain.coffee'

mongoPort = process.env.MONGOPORT or 27017
connectionString = "mongodb://localhost:#{mongoPort}/legodb"

app = express()

console.log __dirname + '/../resources/views'

app.use express.static(process.cwd() + '/src/resources/')
app.set('views', __dirname + '/../resources/views')
app.set('view engine', 'jade')

#app.use express.static(process.cwd() + '/dev/resources')
port = process.env.PORT or 5555

app.get '/', (req, res)->
	search = domain.createSearch mongostore.createMongostore(connectionString)
	search.getResults req.query,(err,result)=>
		res.send err if err
		res.render('index',{title:"Your Lego Sets",searchResults:result})

# Start Server
app.listen port, -> console.log "LegoDatabase server is listening on #{port}\nPress CTRL-C to stop server."