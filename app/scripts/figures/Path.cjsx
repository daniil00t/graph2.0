React = require 'react'

Path = React.createClass
	displayName: 'Path'
	componentWillMount: ->
		console.log Math.min @props._xy.x, @props.__xy.x + (Math.abs @props._xy.x - @props.__xy.x) / 2 - 10
	render: ->
		if @props.CalcWeightMode
			<g>
				<path d={@props.d} fill="transparent" stroke="black" style={{strokeWidth: 2}}/>
				<rect x={Math.min(@props._xy.x, @props.__xy.x) + (Math.abs @props._xy.x - @props.__xy.x) / 2 - 23.5} 
							y={Math.min(@props._xy.y, @props.__xy.y) + (Math.abs @props._xy.y - @props.__xy.y) / 2 - 16}
							width="60" height="30" fill={@props.fill} widthStroke="5" stroke="#333"></rect>
				<text x={Math.min(@props._xy.x, @props.__xy.x) + (Math.abs @props._xy.x - @props.__xy.x) / 2 - 15} 
							y={Math.min(@props._xy.y, @props.__xy.y) + (Math.abs @props._xy.y - @props.__xy.y) / 2 - 5} 
							fill="#fff" dy=".6em" fontFamily="sans-serif" fontSize="17px" className="weightPaths">
								{""+@props.weight}
				</text>
			</g>
		else
			<path d={@props.d} fill="transparent" stroke="black" style={{strokeWidth: 2}}/>

module.exports = Path