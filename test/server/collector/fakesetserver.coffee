express = require 'express'

app = express()
app.use express.static(process.cwd() + '/test/server/collector/resources')
port = process.env.PORT or 7777

# Start Server
app.listen port, -> console.log "Listening on #{port}\nPress CTRL-C to stop server."