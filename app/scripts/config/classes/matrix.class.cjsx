React = require 'react'


Matrix = React.createClass
	displayName: "Matrix"
	render: ->
		<div className="wrapMatrix">
			<i class="fa fa-th" aria-hidden="true"></i>
			<table className="Matrix">
				{
					@props.matrix.map (i, l)->
						<tr key="tr#{l}">
							{
								i.map (j, p)->
									<td key="td#{p}">{j}</td>
							}
						</tr>
				}
			</table>
		</div>

module.exports = Matrix