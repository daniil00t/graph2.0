React = require 'react'


Matrix = React.createClass
	displayName: "Matrix"
	render: ->
		<div className="wrapMatrix">
			<table className="Matrix">
				{
					@props.matrix.map (i)->
						<tr>
							{
								i.map (j)->
									<td>{j}</td>
							}
						</tr>
				}
			</table>
		</div>

module.exports = Matrix