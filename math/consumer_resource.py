import numpy as np
from scipy.integrate import odeint
import matplotlib.pyplot as plt

# --- 1. Parameter Settings ---
params = {
    'N': 2,  # Number of consumers
    'M': 2,  # Number of resources
    
    # Consumer parameters
    'u': np.array([      # Uptake rates (N x M)
        [0.02, 0.01],    # Consumer 1's uptake of resources 1 and 2
        [0.01, 0.02]     # Consumer 2's uptake of resources 1 and 2
    ]),
    'm': np.array([0.2, 0.2]),  # Mortality rates of consumers
    
    # Resource parameters (constant input)
    'rho': np.array([5.0, 6.0]),  # Constant resource input rates
    
    # Leakage parameters (N x M x M)
    'l': np.array([
        # Consumer 1's leakage matrix
        [[0.1, 0.05],   # From resource 1: 10% to R1, 5% to R2 (total 15%)
         [0.03, 0.1]],  # From resource 2: 3% to R1, 10% to R2 (total 13%)
        
        # Consumer 2's leakage matrix  
        [[0.08, 0.04],  # From resource 1: 8% to R1, 4% to R2 (total 12%)
         [0.02, 0.08]]  # From resource 2: 2% to R1, 8% to R2 (total 10%)
    ])
}

# --- 2. Leakage Consumer-Resource Model ---
def MiCRM_ode(y, t, p):
    """
    Consumer-resource model with leakage and constant resource input.
    
    Args:
        y: State vector [C1, C2, ..., R1, R2, ...]
        t: Time
        p: Dictionary of parameters
        
    Returns:
        dydt: Derivatives [dC1/dt, dC2/dt, ..., dR1/dt, dR2/dt, ...]
    """
    N, M = p['N'], p['M']
    C = y[:N]   # Consumer abundances
    R = y[N:]   # Resource abundances
    
    # Initialize derivatives
    dCdt = np.zeros(N)
    dRdt = np.zeros(M)
    
    # Calculate consumer dynamics
    for i in range(N):
        effective_uptake = 0.0
        for alpha in range(M):
            # Fraction of resource alpha that consumer i actually assimilates
            assimilated_fraction = 1.0 - np.sum(p['l'][i, alpha, :])
            effective_uptake += p['u'][i, alpha] * assimilated_fraction * R[alpha]
        dCdt[i] = C[i] * (effective_uptake - p['m'][i])
    
    # Calculate resource dynamics
    for alpha in range(M):
        # Constant resource input
        rho_alpha = p['rho'][alpha]
        dRdt[alpha] = rho_alpha
        
        # Direct consumption by consumers (negative term)
        consumption = 0.0
        for i in range(N):
            consumption += C[i] * R[alpha] * p['u'][i, alpha]
        dRdt[alpha] -= consumption
        
        # Leakage from other resources (positive term)
        leakage = 0.0
        for i in range(N):
            for beta in range(M):
                leakage += C[i] * R[beta] * p['u'][i, beta] * p['l'][i, beta, alpha]
        dRdt[alpha] += leakage
    
    return np.concatenate([dCdt, dRdt])

# --- 3. Run Simulation ---
t = np.linspace(0, 200, 2000)
state0 = np.concatenate([[10.0, 12.0], [100.0, 120.0]])  # [C1, C2, R1, R2]
solution = odeint(MiCRM_ode, state0, t, args=(params,))

# Extract results
C1 = solution[:, 0]  # Consumer 1
C2 = solution[:, 1]  # Consumer 2
R1 = solution[:, 2]  # Resource 1
R2 = solution[:, 3]  # Resource 2

# --- 4. Plot Time Dynamics ---
plt.figure(figsize=(12, 5))

# Plot consumer dynamics
plt.subplot(1, 2, 1)
plt.plot(t, C1, 'b-', label='Consumer 1', linewidth=2)
plt.plot(t, C2, 'r-', label='Consumer 2', linewidth=2)
plt.xlabel('Time')
plt.ylabel('Abundance')
plt.title('Consumer Dynamics of MiCRM')
plt.legend()
plt.grid(True, linestyle=':', alpha=0.7)

# Plot resource dynamics
plt.subplot(1, 2, 2)
plt.plot(t, R1, 'g-', label='Resource 1', linewidth=2)
plt.plot(t, R2, 'm-', label='Resource 2', linewidth=2)
plt.xlabel('Time')
plt.ylabel('Abundance')
plt.title('Resource Dynamics of MiCRM')
plt.legend()
plt.grid(True, linestyle=':', alpha=0.7)

plt.tight_layout()
plt.show()