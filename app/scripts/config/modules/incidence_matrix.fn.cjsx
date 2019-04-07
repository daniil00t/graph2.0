###
Nodes: 4
Paths: 6
INC_MATRIX = [
			e1 e2 e3 e4 e5 e6
	1:	1, 0, 0, 0, 1, 0
	2:	1, 1, 0, 1, 0, 2
	3:	0, 1, 1, 0, 1, 0
	4:	0, 0, 1, 1, 0, 0
]

###
getMatrix = (arr, paths, n, WeightMode)->
	# console.log arr, paths, n, WeightMode
	if n > 0
		Mx = []
		tmpObj = {}
		#Create empty Matrix -> empty object
		for i in [0..n-1]
			tmpObj["circle#{i}"] = {}
			for q in [0..n-1]
				tmpObj["circle#{i}"]["circle#{q}"] = 0
		#console.log tmpObj
		#Fitst going
		for i, j in arr
			for q in Object.keys tmpObj
				if i[0] == q
					tmpObj[q][i[1]] = if WeightMode then Math.round paths[j].weight else 1

		#reverse arr
		RevArr = []
		for i in arr
			RevArr.push [i[1], i[0]]

		#Second going
		for i, j in RevArr
			for q in Object.keys tmpObj
				if i[0] == q
					tmpObj[q][i[1]] = if WeightMode then Math.round paths[j].weight else 1

		#From object into array
		for i in Object.keys tmpObj
			tmpArr = []
			for j in Object.keys tmpObj[i]
				tmpArr.push tmpObj[i][j]
			Mx.push tmpArr
		Mx
	else
		[]

	
module.exports = getMatrix