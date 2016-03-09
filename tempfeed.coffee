express = require 'express'
router = express.Router()
fs = require 'fs'
bp = require 'body-parser'

dataFile = __dirname + '/data.json'

getDataFile = (res, dataFn) ->
	fs.stat dataFile, (err, stat) ->
		if err
			res.status(500).send 'ERROR: can not find data file'
		else
			dataFn()
		return

router.get '/', (req, res) ->
	getDataFile res, () ->
		res.sendFile dataFile

router.get '/latest', (req, res) ->
	getDataFile res, () ->
		raw = fs.readFileSync dataFile, 'utf-8'
		json = JSON.parse raw
		res.send json[json.length-1]

parser = bp.urlencoded {extended: false}
router.post '/', parser, (req, res) ->

	#cut off garbage from start and end
	
	json = []
	exists = fs.existsSync dataFile
	if exists
		raw = fs.readFileSync dataFile, 'utf-8'
		if raw and raw.length > 0
			json = JSON.parse raw

	json.push { timeStamp: new Date(), data: { temp: req.body.temp, humidity: req.body.humidity, airq: req.body.airq } }

	fs.writeFile dataFile, JSON.stringify(json), (err) ->
		if err
			res.status(500).send 'ERROR: failed to save data'
		else
			res.send 'SUCCESS: data saved'
	
	return

module.exports = router
