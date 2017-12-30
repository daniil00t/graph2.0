React = require 'react'

Path = React.createClass
	displayName: 'Path'
	render: ->
		<path d={@props.d} fill="transparent" stroke="black" style={{strokeWidth: 2}}/>


module.exports = Path