#ifndef PZ_MODEL_PNODE_HPP
#define PZ_MODEL_PNODE_HPP

#include "bi/model/BayesNode.hpp"
#include "bi/cuda/cuda.hpp"

class PNode : public bi::BayesNode<1> {
public:
  template<class T, class V1, class V2>
  static CUDA_FUNC_BOTH void dfdt(const T t, const V1& pax, V2& dfdt);

};

#include "bi/model/NodeForwardTraits.hpp"

IS_ODE_FORWARD(PNode)

template<class T, class V1, class V2>
inline void PNode::dfdt(const T t, const V1& pax, V2& dfdt) {
  const float p = pax[0];
  const float z = pax[1];

  dfdt = 0.1f*p - 0.25f*p*z;
}

#endif
