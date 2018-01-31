n = 4
INF = 20000000000000

W = [
	[INF,15,17,INF],
	[15,INF,20,13],
	[17,20,INF,INF],
	[INF,13,INF,INF]
]
A = [[[INF for j in range(n)] for i in range(n)] for k in range(n + 1)]
for i in range(n):
    for j in range(n):
        A[i][j] = W[i][j] 
for k in range(1, n + 1):
    for i in range(n):
        for j in range(n):
            A[k][i][j] = min(A[k-1][i][j], A[k-1][i][k-1] + A[k-1][k-1][j])


"""
A = [[[INF for j in range(n)] for i in range(n)] for k in range(n + 1)]
for i in range(n):
    for j in range(n):
        A[i][j] = W[i][j] 
for k in range(1, n + 1):
    for i in range(n):
        for j in range(n):
            A[k][i][j] = min(A[k-1][i][j], A[k-1][i][k-1] + A[k-1][k-1][j])



for k in range(n):
	for i in range(n):
		for j in range(n):
			if d[j][k] > d[j][i - 1] + d[i - 1][k]:
				d[j][k] = d[j][i - 1] + d[i - 1][k]

for k in range(1, n+1):
	for i in range(n):
		for j in range(n):
			if d[j][k] > d[j][i - 1] + d[i - 1][k]:
				d[j][k] = d[j][i - 1] + d[i - 1][k]


import sys
import math
n = 4
INF = 20000000000000

W = [
	[INF,15,17,INF],
	[15,INF,20,13],
	[17,20,INF,INF],
	[INF,13,INF,INF]
]

G = [
	[INF,19,INF,INF],
	[19,INF,26,INF],
	[INF,26,INF,15],
	[INF,INF,15,INF]
]

D = [
	[INF,	25,	INF,	INF],
	[25,	INF,	16,	INF],
	[INF,	16,	INF,	10],
	[INF,	INF,	10,	INF]

]

d = D
#print(d)

for k in range(1, n):
	for i in range(n):
		for j in range(n):
			d[i][j] = min(d[i][j], d[i][k] + d[k][j])



print(d)
"""
print(A)