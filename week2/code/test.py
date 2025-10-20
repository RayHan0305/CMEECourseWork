import numpy as np
import scipy as sc

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
# 1st row, 2nd column element
print(mat[0,-1])
# 1st row, 1st column element
print(mat[0,-2])
# 2nd row, 1st column element
print(mat[-1,0])
# replace a single element
mat[0,0] = -1
print(mat)
# replace whole column
mat[:,0] = [12,12] 
print(mat)
# append row, note axis specification
np.append(mat, [[12,12]], axis = 0)
print(mat)
# reshape
print(mat.reshape((1,4)))
print(np.ones((4,2)))
# Initialize a (4,2) matrix with zeros
print(np.zeros((4,2)))
# create an identity matrix
m = np.identity(4)
print(m)
# fill the matrix with 16
m = m.fill(16)
print(m)
mm = np.arange(16)
mm = mm.reshape(4,4) # COnvert to matrix
print(mm)
# 10 samples from the normal distribution
print(sc.stats.norm.rvs(size = 10))
print(sc.stats.norm.rvs(size = 5, random_state = 1234))
# example of generating random integers between 0 and 10
print(sc.stats.randint.rvs(0, 10, size = 7))
print(sc.stats.randint.rvs(0, 10, size = 7, random_state = 1234))