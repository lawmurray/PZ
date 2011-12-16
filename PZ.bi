/**
 * Lotka-Volterra-like phytoplankton-zooplankton (PZ) model.
 * 
 * @author Lawrence Murray <lawrence.murray@csiro.au>
 * $Rev$
 * $Date$
 */
model PZ {
  const c = 0.25     // zooplankton clearance rate
  const e = 0.3      // zooplankton growth efficiency
  const m_l = 0.1    // zooplankton linear mortality
  const m_q = 0.1    // zooplankton quadratic mortality

  param mu, sigma    // mean and standard deviation of phytoplankton growth
  state P, Z         // phytoplankton, zooplankton
  noise alpha        // stochastic phytoplankton growth rate
  obs P_obs          // observations of phytoplankton
  
  sub prior {
    mu ~ uniform(0.0, 1.0)
    sigma ~ uniform(0.0, 0.5)
  }
  
  sub initial {
    P ~ log_normal(2.0, 0.2)
    Z ~ log_normal(2.0, 0.1)
  }

  sub transition(delta = 1.0) {
    do {
      alpha ~ normal(mu, sigma)
    } then ode(atoler = 1.0e-3, rtoler = 1.0e-3, alg = 'rk43') {
      P <- ode(alpha*P - c*P*Z)
      Z <- ode(e*c*P*Z - m_l*Z - m_q*Z*Z)
    }
  }

  sub observation {
    P_obs ~ log_normal(log(P), 0.2)
  }
}
