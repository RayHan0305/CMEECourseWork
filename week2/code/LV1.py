import scipy.integrate as integrate
import numpy as np
import matplotlib.pylab as p

y = np.array([5, 20, 18, 19, 18, 7, 4]) # The y values; can also use a python list here
y1 = p.plot(y)
f1 = p.figure()

def dCR_dt(pops, t=0):

    R = pops[0]
    C = pops[1]
    dRdt = r * R - a * R * C 
    dCdt = -z * C + e * a * R * C
    
    return np.array([dRdt, dCdt])

r = 1.
a = 0.1
z = 1.5
e = 0.75

t = np.linspace(0, 15, 1000)

R0 = 10
C0 = 5
RC0 = np.array([R0, C0])

pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output = True)

p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics')
p.show()# To display the figure

# Save figure
y1.savefig('../results/y1_figure.pdf')
f1.savefig('../results/LV_model.pdf')



