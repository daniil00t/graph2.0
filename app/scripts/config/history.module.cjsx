ee = require "../global/Events"

###
HISTORY = [
	{ type: "AddNode", date: "21:3:58", id: "circle0" }
	{ type: "AddNode", date: "21:3:59", id: "circle1" }
	{ type: "AddPath", date: "21:4:11" }
]
###
class History
	constructor: ->
		@HISTORY = []
		@Configs = {
			use: ["user", "App"]
		}
		@types_history = [
			"AddNode"
			"AddPath"
			"DeleteNode"
			"ColorChange"
			"RadiusChange"
		]
	setEvent: (obj, type_event)->
		tmp = {}
		tmpstrDate = new Date
		strDate = ""+tmpstrDate.getHours() + ":"+tmpstrDate.getMinutes() + ":"+tmpstrDate.getSeconds()
		tmp["type"] = type_event
		tmp["date"] = strDate
		if obj.id? then tmp['id'] = obj.id
		@HISTORY.push tmp
		ee.emit 'changeHistory', {data: @HISTORY}
	getHistory: ->
		@HISTORY

module.exports = History