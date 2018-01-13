React = require 'react'

History = React.createClass
	displayName: "History"
	getInitialState: ->
		itemNow: "history"
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
	render: ->
		<div className="wrapInfo">
			<i className={if @state.itemNow == "history" then "fa fa-history itemInfoIcon IconActionGold" else "fa fa-history itemInfoIcon"} title="history" onClick={(e) => @switchItem {type: "history", e: e}}></i>
			<i className={if @state.itemNow == "database" then "fa fa-database itemInfoIcon IconActionGold" else "fa fa-database itemInfoIcon"} title="history" onClick={(e) => @switchItem {type: "database", e: e}}></i>
			<i className={if @state.itemNow == "map" then "fa fa-map itemInfoIcon IconActionGold" else "fa fa-map itemInfoIcon"} title="history" onClick={(e) => @switchItem {type: "map", e: e}}></i>
			{
				if @state.itemNow == "history"
					<div className="wrap_history">
						<div className="history">
							{
								@props.data.map (i, j)->
									<div className="history_item" key="item#{j}">{i.type}: {i.MainData}</div>
							}
						</div>
					</div>
				else
					if @state.itemNow == "database"
						<div>
							database
						</div>
					else
						if @state.itemNow == "map"
							<div>
								map
							</div>
			}
			
		</div>

module.exports = History