#ifndef PZ_MODEL_ALPHANODE_HPP
#define PZ_MODEL_ALPHANODE_HPP

#include "bi/model/BayesNode.hpp"
#include "bi/cuda/cuda.hpp"

class AlphaNode : public bi::BayesNode<1> {
public:
  template<class V1, class V2>
  static CUDA_FUNC_BOTH void s(const V1& pax, V2& x);

};

#include "bi/model/NodeStaticTraits.hpp"

IS_SAMPLEABLE(AlphaNode)

template<class V1, class V2>
inline void AlphaNode::s(const V1& pax, V2& x) {

}

#endif
