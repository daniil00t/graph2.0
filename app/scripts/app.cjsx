React = require 'react'

App = React.createClass

	displayName: 'App'
	handleClick: (e)->
		console.log "X: #{e.nativeEvent.offsetX}, Y: #{e.nativeEvent.offsetY}"
	render: ->
		<div>
		  <svg height="100%" version="1.1" width="100%" xmlns="http://www.w3.org/2000/svg" onClick={((e)=>this.handleClick e)}>
		  	<desc>Created with Snap</desc>
		  	<defs></defs>
		  </svg>
		</div>       


module.exports = App	  
