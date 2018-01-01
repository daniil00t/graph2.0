React = require 'react'


Matrix = React.createClass
	displayName: "Matrix"
	render: ->
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

module.exports = Matrix