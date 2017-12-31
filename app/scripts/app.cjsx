React = require 'react'
ee = require './global/Events'
Node = require "./figures/Node"
Path = require "./figures/Path"
Configs = require './config/Configs'


App = React.createClass

	getInitialState:->
		figures: []
		val: 0
		IdsPath: []
		Paths: []
		Matrix: []
		colorNodes: "#2e9f5c"
	displayName: 'App'
	handleClick: (e)->
		#console.log "X: #{e.nativeEvent.offsetX}, Y: #{e.nativeEvent.offsetY}"
		@setState val: @state.val + 1
		if e.target.nodeName == "svg"
			@AddNode e.nativeEvent.offsetX, e.nativeEvent.offsetY, "circle"+@state.val, @state.colorNodes
		if e.target.nodeName == "circle"
			@AddPath e.target.id
	AddNode: (cx, cy, id, color)->
		@state.figures.push {cx: cx, cy: cy, id: id, color: color}
		#console.log @state.figures
	AddPath: (id)->
		@state.IdsPath.push id
		if @state.IdsPath.length == 2
			@DrawPath @state.IdsPath
			@state.Matrix.push @state.IdsPath
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
		@state.Paths.push str
	componentWillMount: ->
		ee.on 'changeColorNodes', ((color)=>
			console.log color
			@setState colorNodes: color.color
		)
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
		  		@state.figures.map((i)=>
		  			<Node cx={i.cx} cy={i.cy} id={i.id} bgc={i.color}/>
		  		)
		  	}
		  </svg>
		  <Configs />
		</div>      


module.exports = App	  
