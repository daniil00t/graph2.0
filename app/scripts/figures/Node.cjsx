React = require 'react'

Node = React.createClass
	styles:
		radius: 20
		fill: "#2e9f5c"
		stroke: "#333333"
		width_stroke: 3
	render: ->
		<circle cx={@props.cx} cy={@props.cy} r="20" fill="#2e9f5c" stroke="#333333" id={@props.id} style="stroke-width: 3;"></circle>