import sympy as sp
A = sp.Matrix([[3,-7],[1,7]])
b = sp.Matrix([4,10])
z = A.LUsolve(b)
A.inv(), z
print(A.inv(), z)