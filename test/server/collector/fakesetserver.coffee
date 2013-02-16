express = require 'express'

app = express()
app.use express.static(process.cwd() + '/test/server/collector/resources')
port = 7777

# Start Server
app.listen port, -> console.log "FakeSet server is listening on #{port}\nPress CTRL-C to stop server."