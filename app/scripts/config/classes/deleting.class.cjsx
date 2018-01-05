React = require "react"
ee = require '../../global/Events'
history_app = require "../modules/history.module"

Deleting = React.createClass
	displayName: "Deleting"
	handleChange: (e)->
		#console.log e.target.checked
		history_app.setEvent {deletingMode: e.target.checked}, "deleteMode"
		ee.emit 'changeDeletingMode', {data: e.target.checked}
	render: ->
		<div className="wrapDeleting">
			<div className="labelFor">
				<span>Deleting Mode: </span>
			</div>
			<div className="toggleWrapper">
			  <input type="checkbox" name="toggle2" className="mobileToggle" id="toggle2" onChange={(e) => @handleChange e}/>
			</div>
		</div>

module.exports = Deleting