React = require 'react'

History = React.createClass
	displayName: "History"
	render: ->
		<div className="wrap_history">
			<div className="history">
				{
					
					@props.data.map (i, j)->
						<div className="history_item" key="item#{j}">{i.type}: {i.MainData}</div>
				}
			</div>
		</div>

module.exports = History