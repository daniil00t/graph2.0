# _Matrix = [
# 	["circle0", "circle0"]
# 	["circle0", "circle1"]
# 	["circle1", "circle2"]
# 	["circle2", "circle2"]
# 	["circle2", "circle3"]
# 	["circle3", "circle3"]
# ]
###
matrix = [
	   0  1  2  3
	0 [1, 1, 0, 1]
	1 [1, 0, 0, 1]
	2 [0, 1, 0, 1]
	3 [1, 1, 1, 0]
]

tmp_all = ""
	for i in arr
		tmp_all+= i[0]
		tmp_all+= i[1]
	console.log tmp_all
	arr_ints = tmp_all.match /\d+/g
	for i, j in arr_ints
		arr_ints[j] = +i

###

getMatrix = (arr, paths, n, WeightMode)->
	# console.log arr, paths, n, WeightMode
	if n > 0
		Mx = []
		N = arr.length
		tmp = []
		j = 0
		for i in arr
			re = /\d/
			st = i[0].replace(re, (match) =>
				tmp[j] = []
				tmp[j].push Number match
			)
			fn = i[1].replace(re, (match) =>
				tmp[j].push Number match
			)
			j++
		# console.log tmp
		for j in [0..n-1]
			Mx[j] = []
			for l in tmp
				console.log l, j
				if l[0] == j or l[1] == j
					Mx[j].push 1
				else 
					Mx[j].push 0
		console.log Mx


		Mx
	else
		[]




module.exports = getMatrix
