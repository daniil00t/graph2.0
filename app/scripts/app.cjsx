React = require 'react'																		#|Platform
ee = require './global/Events'														#|Events

Node = require "./figures/Node"														#|Figures
Path = require "./figures/Path"														#|

Configs = require './config/classes/Configs'							#|Configs class
mx = require './config/modules/matrix.fn'									#|module matrix
history_app = require "./config/modules/history.module"	#|module history



App = React.createClass
	displayName: 'App'

	getInitialState:->
		Nodes: []
		val: 0
		IdsPath: []
		Paths: []
		MatrixNamesNodes: []
		_Matrix: []
		colorNodes: "#2e9f5c"
		radiusNode: 20
		history_app: []
		deletingMode: false


	handleClick: (e)->
		#console.log "X: #{e.nativeEvent.offsetX}, Y: #{e.nativeEvent.offsetY}"

		if e.target.nodeName == "svg"
			@setState val: @state.val + 1
			@AddNode e.nativeEvent.offsetX, e.nativeEvent.offsetY, "circle"+@state.val, @state.colorNodes, @state.radiusNode
		if e.target.nodeName == "circle"
			if !@state.deletingMode
				@AddPath e.target.id
			else
				@DeleteNodeById(e.target.id)

	AddNode: (cx, cy, id, color, r)->
		@state.Nodes.push {cx: cx, cy: cy, id: id, color: color, r: r}
		@setState _Matrix: mx @state.MatrixNamesNodes, @state.Nodes.length
		history_app.setEvent {cx: cx, cy: cy, id: id, color: color, r: r}, 'AddNode'
		#console.log @state.Nodes
	DeleteLastNode: ->
		tmp = @state.Nodes
		tmp.splice tmp.length - 1, tmp.length
		@setState Nodes: tmp
	DeleteNodeById: (id)->
		console.log id
		tmp = @state.Nodes
		for i, l in @state.Nodes
			if id == i.id
				tmp.splice l, l+1
				break
		console.log tmp
		@setState Nodes: tmp
	AddPath: (id)->
		@state.IdsPath.push id
		if @state.IdsPath.length == 2
			@DrawPath @state.IdsPath
			@state.MatrixNamesNodes.push @state.IdsPath
			@setState _Matrix: mx @state.MatrixNamesNodes, @state.Nodes.length
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
		@setState colorNodes: "#FF0018"
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
			@deletingModeActive()

		ee.on 'changeHistory', (data) =>
			@setState history_app: data.data
			
	render: ->
		<div id="wrap">
		  <svg height="100%" version="1.1" width="100%" xmlns="http://www.w3.org/2000/svg" onClick={((e)=>this.handleClick e)}>
		  	<desc>Created with Daniil(den50)</desc>
		  	<defs></defs>
				{
		  		@state.Paths.map((i)->
		  			<Path d={i} key="path#{@state.val}"/>
		  		)
		  	}
		  	{
		  		@state.Nodes.map((i)=>
		  			<Node cx={i.cx} cy={i.cy} id={i.id} bgc={i.color} r={i.r} key="node#{@state.val}"/>
		  		)
		  	}
		  </svg>
		  <Configs matrix={@state._Matrix} history={@state.history_app} key="Configs"/>
		</div>      


module.exports = App	  
