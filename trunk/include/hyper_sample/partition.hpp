#ifndef _INCLUDED_PARTITION_HPP_
#define _INCLUDED_PARTITION_HPP_

/**
 * @file   partition.hpp
 * @author Aron Ahmadia <aron@casiphia.local>
 * @date   Fri Feb 29 12:31:56 2008
 * 
 * @brief  Partition - an object for sampling a subpartition of the hypersphere
 * 
 * 
 */

#include <boost/numeric/ublas/vector.hpp>
#include <boost/numeric/ublas/matrix.hpp>
#include "boost_ext/ublas_vector.hpp"
#include "boost_ext/ublas_matrix.hpp"
#include <boost/version.hpp>
#include <string>

#include "hyper_sample/zones.hpp"
#include "hyper_sample/utility/geometry.hpp"
#include "hyper_sample/bounds.hpp"

namespace smo {

  using std::string;
  

  class Partition 
  {
  public:
    Partition();
    Partition(bool enforceSymmetric, bool enforceExactCount, bool reviseCollars);

    //     void regionCaps(DimCount d, const Bounds &b, PointCount n, PolarAngle polarCap, const RegionCounts &c, Region &caps);
    
    //     void setup(DimCount d, const Bounds &b, PointCount n, bool enforceSymmetric, bool enforceExactCount, bool reviseCollars);
    //     void sample(Region &s);
    //     void subPartition(PartitionList &p);
    
    
  private:
    DimCount d; 
    Bounds b;
    PointCount n;
    bool enforceSymmetric;
    bool enforceExactCount;
    bool reviseCollars;
  };


}


#endif
