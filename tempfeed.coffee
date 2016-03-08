express = require 'express'
router = express.Router()
fs = require 'fs'
bp = require 'body-parser'

router.get '/', (req, res) ->
	res.send 'send data, don\'t ask for it slut'

parser = bp.urlencoded {extended: false}
router.post '/', parser, (req, res) ->
	console.log req.body
	res.send 'thanks faggot'

router.post '/temp', (req, res) ->
	res.send 'thanks faggot'

router.post '/humidity', (req, res) ->
	res.send 'thanks faggot'

router.post '/airquality', (req, res) ->
	res.send 'thanks faggot'

router.post '/storedata', (req, res) ->
	res.send 'thanks fag'

module.exports = router
