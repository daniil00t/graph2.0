React = require 'react'
ee = require "../../global/Events"

Info = React.createClass
	displayName: "Info"
	getInitialState: ->
		itemNow: "history"
		typeAlg: ""
		dataAlg: {}
		timeAlg: 0
	switchItem: (obj)->
		tmp = obj.e.target.classList.value.split(' ')
		for i in tmp
			if i != "IconActionGold"
				continue
			else
				tmp.push "IconActionGold"
				break
		obj.e.target.classList.value = tmp.join " "
		# tmp.push "IconAction"
		# obj.e.target.classList = tmp
		if @state.itemNow != obj.type
			@setState itemNow: obj.type
	componentWillMount: ->
		# ee.on "switchAlgorithm", (data)=>
		# 	@setState typeAlg: data.data
		# 	@setState itemNow: "map"
		ee.on "sendDataAlgs", (data)=>
			@setState itemNow: "map"
			console.log data
			@setState typeAlg: data.type
			@setState dataAlg: data.data
			@setState timeAlg: data.time
	render: ->
		<div className="wrapInfo">
			<i className={if @state.itemNow == "history" then "fa fa-history itemInfoIcon IconActionGold" else "fa fa-history itemInfoIcon"} title="history" onClick={(e) => @switchItem {type: "history", e: e}}></i>
			<i className={if @state.itemNow == "database" then "fa fa-database itemInfoIcon IconActionGold" else "fa fa-database itemInfoIcon"} title="database" onClick={(e) => @switchItem {type: "database", e: e}}></i>
			<i className={if @state.itemNow == "map" then "fa fa-map itemInfoIcon IconActionGold" else "fa fa-map itemInfoIcon"} title="map" onClick={(e) => @switchItem {type: "map", e: e}}></i>
			{
				if @state.itemNow == "history"
					<div className="wrap_history">
						<div className="history">
							{
								@props.history.map (i, j)->
									<div className="history_item" key="item#{j}">{i.type}: {i.MainData}</div>
							}
						</div>
					</div>
				else
					if @state.itemNow == "database"
						<div>
							<span>Count nodes: {@props.database.nodes.length}</span><br/>
							<span>Count paths: {@props.database.paths.length}</span>
						</div>
					else
						if @state.itemNow == "map"
							if @state.dataAlg?
								<div className="wrapMap">
									<span className="InfoAlg">Type_algorithm: <span className="klaster">{@state.typeAlg}</span></span>
									<span className="InfoAlg">Time work algorithm: <span className="klaster">{@state.timeAlg}</span></span>
									<div className="wrapMapItem">
										{
											Object.keys(@state.dataAlg).map (i, j)=>
												<div>
												<span>{i}: {@state.dataAlg[i]}</span><br />
												</div>
										}
									</div>
								</div>
							else
								<p>ooooooh=)MAP IS EMPTY)</p>
							
			}
			
		</div>

module.exports = Info