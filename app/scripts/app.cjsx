React = require 'react'
Node = require "./figures/Node"
Path = require "./figures/Path"


App = React.createClass

	getInitialState:->
		figures: []
		val: 0
		IdsPath: []
		Paths: []
		Matrix: []
	displayName: 'App'
	handleClick: (e)->
		#console.log "X: #{e.nativeEvent.offsetX}, Y: #{e.nativeEvent.offsetY}"
		@setState val: @state.val + 1
		if e.target.nodeName == "svg"
			@AddNode e.nativeEvent.offsetX, e.nativeEvent.offsetY, "circle"+@state.val
		if e.target.nodeName == "circle"
			@AddPath e.target.id
	AddNode: (cx, cy, id)->
		@state.figures.push {cx: cx, cy: cy, id: id}
		console.log @state.val
		#console.log @state.figures
	AddPath: (id)->
		@state.IdsPath.push id
		if @state.IdsPath.length == 2
			console.log @state.IdsPath
			@DrawPath @state.IdsPath
			@state.Matrix.push @state.IdsPath
			@setState IdsPath: []
		console.log "Matix:", @state.Matrix
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
		console.log coords
		console.log str
		@state.Paths.push str
		
	render: ->
		<div id="wrap">
		  <svg height="100%" version="1.1" width="100%" xmlns="http://www.w3.org/2000/svg" onClick={((e)=>this.handleClick e)}>
		  	<desc>Created with Snap</desc>
		  	<defs></defs>

				{
		  		@state.Paths.map((i)->
		  			<Path d={i}/>
		  		)
		  	}
		  	{
		  		@state.figures.map((i)->
		  			<Node cx={i.cx} cy={i.cy} id={i.id}/>
		  		)
		  	}
		  </svg>
		</div>       


module.exports = App	  
