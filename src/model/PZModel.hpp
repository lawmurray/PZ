/**
 * @file
 *
 * @author Lawrence Murray <lawrence.murray@csiro.au>
 * @version $Rev$
 * @date $Date$
 */
#ifndef PZ_MODEL_PZMODEL_HPP
#define PZ_MODEL_PZMODEL_HPP

#include "ThetaNode.hpp"
#include "AlphaNode.hpp"
#include "PNode.hpp"
#include "ZNode.hpp"

#include "bi/model/NodeSpec.hpp"
#include "bi/model/BayesNet.hpp"

/**
 * Node specification for the model.
 */
BEGIN_NODESPEC(Spec)
SINGLE_TYPE(PNode,1)
SINGLE_TYPE(ZNode,1)
END_NODESPEC()

/**
 * Simple Lotka-Volterra type Phytoplankton-Zooplankton (PZ) model.
 */
class PZModel : public bi::BayesNet<GET_NODESPEC(Spec)> {
public:
  /**
   * Constructor.
   */
  PZModel();

  /**
   * Destructor.
   */
  virtual ~PZModel();

private:
  /*
   * Nodes
   */
  PNode pNode;
  ZNode zNode;
};

#endif
