React = require "react"
ee = require '../../global/Events'
history_app = require "../modules/history.module"

Deleting = React.createClass
	displayName: "Mods"
	handleChangeDeleting: (e)->
		#console.log e.target.checked
		history_app.setEvent {deletingMode: e.target.checked}, "deleteMode"
		ee.emit 'changeDeletingMode', {data: e.target.checked}
	handleChangeModeNodesNumbering: (e)->
		history_app.setEvent {modeNodesNumbering: e.target.checked}, "modeNodesNumbering"
		ee.emit 'ChangeModeNodesNumbering', {data: e.target.checked}
	handleChangeModeCalcWeight: (e)->
		history_app.setEvent {data: e.target.checked}, "calcWeightPathsMode"
		ee.emit 'ChangeCalcWeightPathsMode', {data: e.target.checked}
	handleAddItemMapMode: (e)->
		history_app.setEvent {data: e.target.checked}, "addItemMapMode"
		ee.emit 'AddItemMapMode', {data: e.target.checked}
	render: ->

		<div className="wrapMods">
			<div className="wrapDeleting">
				<div className="labelFor">
					<span>Deleting Mode: </span>
				</div>
				<div className="toggleWrapper">
				  <input type="checkbox" name="toggle2" className="mobileToggle" id="toggle1" onChange={(e) => @handleChangeDeleting e}/>
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
			<div className="wrapModeCalcWeight">
				<div className="labelFor">
					<span>CalcWeightPathMode: </span>
				</div>
				<div className="toggleWrapper">
				  <input type="checkbox" name="toggle2" className="mobileToggle" id="toggle3" onChange={(e) => @handleChangeModeCalcWeight e}/>
				</div>
			</div>
			<div className="wrapAddItemMapMode">
				<div className="labelFor">
					<span>AddItemMapMode: </span>
				</div>
				<div className="toggleWrapper">
				  <input type="checkbox" name="toggle2" className="mobileToggle" id="toggle4" onChange={(e) => @handleAddItemMapMode e}/>
				</div>
			</div>
		</div>

module.exports = Deleting