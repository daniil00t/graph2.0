n = 5
INF = 20000000000000

W = [
	[INF,3,10,INF, INF],
	[3,INF, INF, 5,INF],
	[10,INF,INF,6, 15],
	[INF,5,6,INF, 4],
	[INF,INF,INF,4, INF]
]
range = (s, f)->
	[s..f-1]
A = [] 
Prev = []
for i in range(0, n)
	a = []
	for j in range(0, n)
		a.push W[i][j]
	A.push a

for i in range(0, n)
	a = []
	for j in range(0, n)
		a.push if i != j then j else "-"
	Prev.push a

for k in range(0, n)
	for i in range(0, n)
		for j in range(0, n)
			if A[i][k] < INF and A[k][j] < INF and A[i][k] + A[k][j] < A[i][j] and i != j
				A[i][j] = A[i][k] + A[k][j]
				Prev[i][j] = k
			else
				if i == j
					A[i][j] = 0

console.log A
console.log Prev
# for i in A:
# 	a = []
# 	for j in i:
# 		a.append(j if j != 0 else "-")
# 	print(a)
# print()
# for i in Prev:
# 	print(i)

# def getPaths_max(n):
# 	n1 = 3
# 	N = 3
# 	for i in range(n-3):
# 		N+=n1
# 		n1+=1
# 	return N

getMinPath = (m, l, A, W)->
	if m == l
		return 0
	start = m
	finish = l

	path = [m]
	subpath = []

	# Start path
	while W[m][l] != l
		subpath.push W[m][l]
		l = W[m][l]

	subpath.reverse()
	for i in subpath
		path.push i

	path.push(finish)

	# print(path)
	#Finish path
	summ = 0
	for i in range(0, path.length-1)
		#path[i]
		#path[i+1]
		summ += A[path[i]][path[i+1]]

	return summ


Mins = []

for i in range(0, n)
	Mins.push {"#{i}": getMinPath(1, i, A, Prev) }

console.log Mins