#ifndef _INCLUDED_SPHERE_HPP_
#define _INCLUDED_SPHERE_HPP_

/**
 * @file   sphere.hpp
 * @author Aron Ahmadia <aron@valkyrie.appmath.columbia.edu>
 * @date   Thu Apr 24 19:48:43 2008
 * 
 * @brief  Sphere - an object for building point (and region?) decompositions on a sphere
 * 
 * 
 */

#include <vector>
#include "hyper_sample/utility/geometry.hpp"
#include <boost/dynamic_bitset.hpp>
#include "boost_ext/dynamic_bitset.hpp"

namespace smo {
  
  typedef int DimIndex;
  typedef int PointIndex;
  typedef std::pair<PointIndex,PointIndex> pointRange;
  typedef boost::dynamic_bitset ReflectableDim;
  typedef vector<pointRange> PointRanges;
  typedef vector<ReflectableDim> ReflectableDims;

  class Sphere
  {
  public:
    Sphere(DimCount dimCount, PointCount pointCount);
    void buildPointsRecurse(DimIndex dimIndex, PointCount localPointCount, PointRange pointRange);

  private:
    SpherePoints spherePoints;
    ReflectableDims reflectableDims;
    PointRanges circleOwnerRanges;
  };

}
	

#endif
