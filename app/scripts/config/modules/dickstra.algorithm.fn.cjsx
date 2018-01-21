

# -> ["circle0", "circle4", "circle6", "circle3", "circle9"]

###
Path = {
	color:"#000"
	coords1: {…}
	coords2: {…}
	d: "M 366, 115L 896, 101Z"
	fill: "#2e9f5c"
	id: "circle0.circle1"
	weight: 26.5
}

namesArr = [
	["circle3", "circle0"]
	["circle0", "circle2"]
	["circle2", "circle1"]
	["circle3", "circle1"]
	["circle4", "circle1"]
	["circle4", "circle0"]
]


###

Paths = [
	{
		id: "circle3.circle0"
		weight: 23.95
	},
	{
		id: "circle0.circle2"
		weight: 12.85
	},
	{
		id: "circle2.circle1"
		weight: 23.1
	},
	{
		id: "circle3.circle1"
		weight: 12.35
	}, 
	{
		id: "circle4.circle1"
		weight: 9.6
	},
	{
		id: "circle4.circle0"
		weight: 12.15
	}
]

namesArr = [
	["circle3", "circle0"]
	["circle0", "circle2"]
	["circle2", "circle1"]
	["circle3", "circle1"]
	["circle4", "circle1"]
	["circle4", "circle0"]
]


getMapDejkstra = (namesArr, paths, data)->
	obj = {}
	start = data.start
	finish = data.finish
	for i, j in namesArr
		obj[i[0]] = obj[i[0]] or {}
		obj[i[0]][i[1]] = paths[j].weight
	console.log obj


getMapDejkstra namesArr, Paths, {start: "circle0", finish: "circle4"}