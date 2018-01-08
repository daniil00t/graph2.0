React = require "react"
ee = require '../../global/Events'
history_app = require "../modules/history.module"

Deleting = React.createClass
	displayName: "Mods"
	handleChangeDeleting: (e)->
		#console.log e.target.checked
		history_app.setEvent {deletingMode: e.target.checked}, "deleteMode"
		ee.emit 'changeDeletingMode', {data: e.target.checked}
	handleChangeModeNodesNumbering: (e) ->
		history_app.setEvent {modeNodesNumbering: e.target.checked}, "modeNodesNumbering"
		ee.emit 'ChangeModeNodesNumbering', {data: e.target.checked}
	render: ->

		<div className="wrapMods">
			<i class="fa fa-sliders" aria-hidden="true"></i>
			<div className="wrapDeleting">
				<div className="labelFor">
					<span>Deleting Mode: </span>
				</div>
				<div className="toggleWrapper">
				  <input type="checkbox" name="toggle2" className="mobileToggle" id="toggle2" onChange={(e) => @handleChangeDeleting e}/>
				</div>
			</div>
			<div className="wrapModeNodesNumbering">
				<div className="labelFor">
					<span>ModeNodesNumbering: </span>
				</div>
				<div className="toggleWrapper">
				  <input type="checkbox" name="toggle2" className="mobileToggle" id="toggle2" onChange={(e) => @handleChangeModeNodesNumbering e}/>
				</div>
			</div>
		</div>

module.exports = Deleting