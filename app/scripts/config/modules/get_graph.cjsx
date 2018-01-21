module.exports = (_arrNames, _paths)->
	arrNames = _arrNames
	paths = _paths
	obj = {}
	for i, j in arrNames
		obj[i[0]] = obj[i[0]] or {}
		obj[i[0]][i[1]] = paths[j].weight

	for i, j in arrNames
		tmp = arrNames[j][0]
		arrNames[j][0] = arrNames[j][1]
		arrNames[j][1] = tmp

	for i, j in arrNames
		obj[i[0]] = obj[i[0]] or {}
		obj[i[0]][i[1]] = paths[j].weight

	obj