{exec} = require "child_process"

REPORTER = "min"

task "test", "run all tests", ->
  invoke "unit"

task "unit", "run unit tests", ->
  exec "NODE_ENV=test 
    mocha 
    --compilers coffee:coffee-script
    --reporter #{REPORTER}
    --require coffee-script 
    --colors
    --recursive
    -R spec
  ", (err, output) ->
    throw err if err
    console.log output

