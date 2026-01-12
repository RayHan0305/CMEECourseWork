import numpy as np
import matplotlib.pyplot as plt

D = np.linspace(0.5, 5, 200)
T = np.linspace(0.5, 5, 200)

L = D**1.84
S = T**(-0.49)

plt.figure()
plt.plot(D, L)
plt.xlabel("Stem Diameter D")
plt.ylabel("Leaf Area L (k = 1)")
plt.show()

plt.figure()
plt.plot(T, S)
plt.xlabel("Leaf thickness T")
plt.ylabel("Spongy mesophyll fraction S (c=1)")
plt.show()