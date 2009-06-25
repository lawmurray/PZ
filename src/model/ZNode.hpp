#ifndef PZ_MODEL_ZNODE_HPP
#define PZ_MODEL_ZNODE_HPP

#include "bi/model/BayesNode.hpp"
#include "bi/cuda/cuda.hpp"

class ZNode : public bi::BayesNode<1> {
public:
  template<class T, class V1, class V2>
  static CUDA_FUNC_BOTH void dfdt(const T t, const V1& pax, V2& dfdt);

};

#include "bi/model/NodeForwardTraits.hpp"

IS_ODE_FORWARD(ZNode)

template<class T, class V1, class V2>
inline void ZNode::dfdt(const T t, const V1& pax, V2& dfdt) {
  const float p = pax[0];
  const float z = pax[1];

  dfdt = 0.3f*0.25f*p*z - 0.1f*z - 0.1f*z*z;
}

#endif
