/**
 * @file
 *
 * Simulate trajectories from PZModel.
 */
#include "model/PZModel.hpp"
#include "bi/method/MultiSimulator.cuh"

#include "boost/random.hpp"

#include <iostream>
#include <iomanip>

int main(const int argc, const char** argv) {
  /* construct model */
  const unsigned int P = 256, K = 100;
  unsigned int i, k;
  float p, z, r;

  PZModel model;
  bi::MultiSimulator<PZModel,float> sim(&model, P, K);

  srand(time(NULL));
  ode_set_h0(0.2f);

  /* initialise */
  for (i = 0; i < P; i++) {
    r = (double)rand() / (double)RAND_MAX;
    p = 1.0 + r;
    z = 1.0 - r;
    sim.setState(i,0,p);
    sim.setState(i,1,z);
  }

  sim.integrate(K);

  /* output */
  i = 0;
  std::cout << std::setprecision(10);
  for (i = 0; i < P; ++i) {
    for (k = 0; k < K; ++k) {
      std::cout << k;
      std::cout << '\t' << sim.getResult(i,0,k);
      std::cout << '\t' << sim.getResult(i,1,k);
      std::cout << std::endl;
    }
    std::cout << std::endl;
  }

  return 0;
}
