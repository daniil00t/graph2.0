getRandomInt = (min, max) ->
  Math.floor(Math.random() * (max - min)) + min

hittingOnInterval = (nodes, fl_screen, cx, cy)->
	obj = {
		x: 0
		y: 0
	}
	for j in nodes
		if j.cx - fl_screen <= cx <= j.cx + fl_screen
			obj.x = 1
		if j.cy - fl_screen <= cy <= j.cy + fl_screen
			obj.y = 1
	obj

get_Nodes_random = (n, fl_screen, fl_nodes, screen, _nodes)->
	fl_nodes += 20
	x_min = fl_screen
	x_max = screen.width - fl_screen
	y_min = fl_screen
	y_max = screen.height - fl_screen

	nodes = _nodes or []
	for i in [0..n-1]
		if nodes.length == n
			break
		else
			console.log i
			cx = getRandomInt(x_min, x_max)
			cy = getRandomInt(y_min, y_max)
			if hittingOnInterval(nodes, fl_screen, cx, cy).x == 0 and hittingOnInterval(nodes, fl_screen, cx, cy).y == 0
				nodes.push {cx: cx, cy: cy}
				console.log "ok"
			else
				console.log "no"
				console.log [cx, cy]
	if nodes.length < n
		get_Nodes_random(n, fl_screen, fl_nodes, screen, nodes)
	else 
		nodes
#console.log get_Nodes_random(10, 100, 0, {width: 16800, height: 8000})

div = (val, b)->
	(val - val % b) / b

get_Nodes_sequence = (n, fl_screen, fl_nodes, screen)->
	fl_nodes += 20
	x_min = fl_screen
	x_max = screen.width - fl_screen
	y_min = fl_screen
	y_max = screen.height - fl_screen

	nodes = []
	j = 0
	d = 0

	console.log div screen.width - fl_screen * 2, n
	console.log div(Math.round(x_max - x_min), 50)

	for i in [0..n-1]
		cx = x_min + j*fl_nodes + fl_nodes
		cy = fl_screen + d*50
		if i % div(Math.round(x_max - x_min), 50) == 0
			d++
			j=0
			cx = x_min + j*fl_nodes + fl_nodes
			cy = fl_screen + d*50
			nodes.push {cx: cx, cy: cy}
		else
			nodes.push {cx: cx, cy: cy}
		j++
	nodes


getPaths_max = (n)->
	n1 = 3
	N = 3
	for i in [0..n-4]
		N+=n1
		n1++
	N

# console.log getPaths_max 100

aniqueArray = (arr)-> 

write_paths = (procents, n, I=0)->
	# I - индекс или номер вершины из которой стартуем
	MAX = getPaths_max n # максимальное кол-во вершин
	N = MAX * procents / 100 # Сколько затронуть вершин от макс значения
	paths = []
	d = 1
	# Последовательный проход
	for i in [0..n-2]
		paths.push ["circle#{i}", "circle#{d}"]
		d++
	if paths.length < N
		if I != 0
			for i in [0..n-1]
				paths.push ["circle#{I}", "circle#{i}"]


	paths

# console.log write_paths 80, 9, 5






module.exports = {get_Nodes_sequence: get_Nodes_sequence, write_paths: write_paths}# 100, 100, 10, {width: 1680, height: 800}