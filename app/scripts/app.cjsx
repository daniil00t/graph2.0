React = require 'react'																		#|Platform
ee = require './global/Events'														#|Events

Node = require "./figures/Node"														#|Figures
Path = require "./figures/Path"														#|

Configs = require './config/classes/Configs'							#|Configs class
amx = require './config/modules/adjacency_matrix.fn'									#|module matrix
history_app = require "./config/modules/history.module"	  #|module history



App = React.createClass
	displayName: 'App'

	getInitialState:->
		Nodes: []
		Paths: []
		deletingMode: false
		modeNodesNumbering: false
		history_app: []
		_Matrix: []
		MatrixNamesNodes: []
		colorNodes: "#2e9f5c"
		radiusNode: 20
		IdsPath: []
		val: 0


	handleClick: (e)->
		#console.log "X: #{e.nativeEvent.offsetX}, Y: #{e.nativeEvent.offsetY}"

		if e.target.nodeName == "svg" and !@state.deletingMode
			@setState val: @state.val + 1
			@AddNode e.nativeEvent.offsetX, e.nativeEvent.offsetY, "circle"+@state.val, @state.colorNodes, @state.radiusNode
		if e.target.nodeName == "circle" or e.target.nodeName == "text"
			if e.altKey
				@DeleteNodeById(e.target.id)
			else
				if !@state.deletingMode
					@AddPath e.target.id
				else
					@DeleteNodeById(e.target.id)

	AddNode: (cx, cy, id, color, r)->
		@state.Nodes.push {cx: cx, cy: cy, id: id, color: color, r: r}
		@setState _Matrix: amx @state.MatrixNamesNodes, @state.Nodes.length
		history_app.setEvent {cx: cx, cy: cy, id: id, color: color, r: r}, 'AddNode'
		#console.log @state.Nodes
	DeleteLastNode: ->
		tmp = @state.Nodes
		tmp.splice tmp.length - 1, tmp.length
		@setState Nodes: tmp
	DeleteNodeById: (id)->
		tmp = @state.Nodes
		tmpMN = @state.MatrixNamesNodes
		#console.log +id.match(/\d+/g)[0]
		for i, l in @state.Nodes
			if id == i.id
				history_app.setEvent {id: id}, "DeleteNodeById"
				tmp.splice l, 1
				warr = []
				###
				Delete nodes in Adjacency matrix
				begin....
				###
				for q, w in tmpMN
					if q[0] == id or q[1] == id
						#tmpMN.splice w, 1
						warr.push w
				warr.reverse()
				for i in warr
					tmpMN.splice i, 1
					@state.Paths.splice i, 1
				###
				Delete nodes in Adjacency matrix
				End...
				###
				break
		for i, j in tmp
			i.id = "circle#{j}"
			tmp[j] = i
		@setState Nodes: tmp
		maxValArr = []
		#Rename nodes)
		for i, j in tmpMN
			IT = +id.match(/\d+/g)[0]
			num = /\d+/g
			NOW0 = +i[0].match(num)[0]
			NOW1 = +i[1].match(num)[0]
			if NOW0 > IT
				tmpMN[j][0] = "circle#{NOW0-1}"
			if NOW1 > IT
				tmpMN[j][1] = "circle#{NOW1-1}"
		for i in @state.Nodes
			maxValArr.push +i.id.match(/\d+/g)[0]
		maxVal = Math.max.apply(null, maxValArr);
		if @state.Nodes.length == 0
			@setState val: 0
		else
			@setState val: maxVal + 1
		@setState MatrixNamesNodes: tmpMN
		@setState _Matrix: amx @state.MatrixNamesNodes, @state.Nodes.length

	AddPath: (id)->
		@state.IdsPath.push id
		if @state.IdsPath.length == 2
			@DrawPath @state.IdsPath
			@state.MatrixNamesNodes.push @state.IdsPath
			@setState _Matrix: amx @state.MatrixNamesNodes, @state.Nodes.length
			@setState IdsPath: []
			

	DrawPath: (ids)->
		coords = []
		str = "M"
		if ids[0] == ids[1]
			#Arc
			coords.push {cx: document.getElementById(ids[0]).attributes.cx.value, cy: document.getElementById(ids[0]).attributes.cy.value}
			cx = +coords[0].cx
			cy = +coords[0].cy
			str = "M#{cx} #{cy} C #{cx - 150} #{cy - 150}, #{cx + 150} #{cy - 150}, #{cx} #{cy}"
		else	
			for i in ids
				coords.push {cx: document.getElementById(i).attributes.cx.value, cy: document.getElementById(i).attributes.cy.value}
			for i, j in coords
				if j == 0
					str += " #{i.cx}, #{i.cy}"
				else
					str += "L #{i.cx}, #{i.cy}Z"
		history_app.setEvent {d: str}, "AddPath"
		@state.Paths.push str
	deletingModeActive: ->
		for i in @state.Nodes
			i.color = "#FF0018"
	deletingModeNoActive: ->
		for i in @state.Nodes
			i.color = @state.colorNodes
	componentWillMount: ->
		ee.on 'changeColorNodes', ((color)=>
			#console.log color
			@setState colorNodes: color.color
			history_app.setEvent {color: color.color}, 'changeColorNode'
		)
		ee.on 'radiusChangeNode', ((r)=>
			#console.log r.r
			@setState radiusNode: r.r
			history_app.setEvent {r: r.r}, 'changeRadiusNode'
		)
		ee.on "changeDeletingMode", (data)=>
			@setState deletingMode: data.data
			if data.data then @deletingModeActive() else @deletingModeNoActive()
		ee.on "ChangeModeNodesNumbering", (data)=>
			@setState modeNodesNumbering: data.data


		ee.on 'changeHistory', (data) =>
			@setState history_app: data.data
			
	render: ->
		<div id="wrap">
		  <svg height="100%" version="1.1" width="100%" xmlns="http://www.w3.org/2000/svg" onClick={((e)=>this.handleClick e)}>
		  	<desc>Created with Daniil(den50)</desc>
		  	<defs></defs>
				{
		  		@state.Paths.map((i)->
		  			<Path d={i}/>
		  		)
		  	}
		  	{
		  		@state.Nodes.map((i)=>
		  			<Node cx={i.cx} cy={i.cy} id={i.id} bgc={i.color} r={i.r}  numberingNodesMode={@state.modeNodesNumbering} />
		  		)
		  	}
		  </svg>
		  <Configs matrix={@state._Matrix} history={@state.history_app} key="Configs"/>
		</div>      


module.exports = App	  
