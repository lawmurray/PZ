/**
 * @file
 *
 * @author Lawrence Murray <lawrence.murray@csiro.au>
 * @version $Rev:16 $
 * @date $Date:2009-04-14 16:05:17 +0800 (Tue, 14 Apr 2009) $
 */
#include "PZModel.hpp"

PZModel::PZModel() : bi::BayesNet<GET_NODESPEC(Spec)>() {
  addNode(pNode);
  addNode(zNode);
  addInArc(pNode,zNode);
  addExArc(pNode,pNode);
  addExArc(pNode,zNode);
  addExArc(zNode,pNode);
  addExArc(zNode,zNode);
}

PZModel::~PZModel() {
  //
}
