ee = require "../../global/Events"

dejkstra = require "./algorithms/dejkstra.algorithm.fn" #|Algorithms ->


class Switcher
	constructor: (@ArrNames, @Paths, @start)->
		@graph = {}
		@_obj = {}
		@time = 0
	regist: (data)->
		if typeof data == "string"
			console.log data
			@start = data
		else
			if typeof data[0][0] == "string"
				@ArrNames = data
			else
				@Paths = data
	getGraph: ->
		arrNames = @ArrNames
		paths = @Paths
		obj = {}
		time = performance.now()
		for i, j in arrNames
			obj[i[0]] = obj[i[0]] or {}
			obj[i[0]][i[1]] = paths[j].weight

		for i, j in arrNames
			tmp = arrNames[j][0]
			arrNames[j][0] = arrNames[j][1]
			arrNames[j][1] = tmp

		for i, j in arrNames
			obj[i[0]] = obj[i[0]] or {}
			obj[i[0]][i[1]] = paths[j].weight
		@time = performance.now() - time
		@graph = obj
	AlgProcess: (type)->
		switch type
			when "dejkstra"
				console.log @graph
				@_obj = (dejkstra @graph, @start) or {}
			#when ....
			else @_obj = {}
	init: (type_alg) ->
		@getGraph()
		@AlgProcess type_alg
		ee.emit "sendDataAlgs", {type: type_alg, data: @_obj, time: @time}
		# console.log @_obj

module.exports = new Switcher