React = require 'react'

Node = React.createClass
	displayName: 'Node'
	render: ->
		<circle cx={@props.cx} cy={@props.cy} r={@props.r} fill={@props.bgc} id={@props.id}></circle>


module.exports = Node