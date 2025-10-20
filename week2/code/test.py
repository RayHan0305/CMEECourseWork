import numpy as np

a = np.array(range(5), float)

print(type(a))
print(type(a[0]))
print(a.dtype) # CHeck type

x = np.arange(5.)
print(x)

b = np.array([i for i in range(10) if i % 2 == 1]) #odd numbers between 1 and 10
print(b)

# covert back to list
c = b.tolist()
print(c)

mat = np.array([[0, 1], [2, 3]])
print(mat)
print(mat.shape)
# accessing whole 2nd row, remember indexing starts at 0
print(mat[1])
# accessing whole second column
print(mat[:,1])
# 1st row, 1st column element
print(mat[0,0])
# 2nd row, 1st column element
print(mat[1,0])
# accessing whole first column
print(mat[:,0])
# 1st row, 2nd column element
print(mat[0,1])
#
print(mat[0,-1])