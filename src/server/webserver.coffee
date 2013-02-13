express = require 'express'
mongostore = require './mongostore.coffee'
domain = require './domain.coffee'

connectionString = "mongodb://localhost:27017/legodb"

app = express()

console.log __dirname + '/../resources/views'

app.use express.static(process.cwd() + '/src/resources/')
app.set('views', __dirname + '/../resources/views')
app.set('view engine', 'jade')

#app.use express.static(process.cwd() + '/dev/resources')
port = process.env.PORT or 5555

app.get '/', (req, res)->
	search = domain.createSearch mongostore.createMongostore(connectionString)
	search.getResults (err,result)=>
		res.send err if err
		res.render('index',{title:"Your Lego Sets",searchResults:result})

# Start Server
app.listen port, -> console.log "Listening on #{port}\nPress CTRL-C to stop server."