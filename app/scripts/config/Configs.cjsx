React = require 'react'
Colors = require "./colors"
Matrix = require './matrix.class'
RadiusChanger = require "./RadiusChanger"
ee = require '../global/Events'
COLORS = ["#2e9f5c", "#47356C", "#FF0018", "#0DF6FF", "#440BDB", "#FFAA0D"]



Configs = React.createClass
	displayName: 'Configs'
	getInitialState: ->
		active: 0
		Items: []
		colorNow: "#2e9f5c"
		Matrix: []
	handleChangeColor: (id)->
		@setState active: id
		for i, j in @state.Items
			if i.active
				@state.Items[j].active = no
				continue
			if i.id == id
				@state.Items[j].active = on
				@setState colorNow: i.color
				ee.emit "changeColorNodes", {color: i.color}
	componentWillMount: ->
		for i, j in COLORS
			@state.Items.push {color: i, id: j, active: if j == 0 then on else no}
	render: ->
		<div className="wrap_configs">
			<div className="configs">
				<Colors colors={@state.Items} onChange={((id)=>@handleChangeColor(id))}/>
				<hr/>
				<RadiusChanger />
				<hr />
				<Matrix matrix={@props.matrix}/>
			</div>
		</div>

module.exports = Configs