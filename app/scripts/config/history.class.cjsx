React = require 'react'

History = React.createClass
	displayName: "History"
	render: ->
		<div className="wrap_history">
			{
				@props.data.map (i)->
					<div className="history_item">{i.type}</div>
			}
		</div>

module.exports = History