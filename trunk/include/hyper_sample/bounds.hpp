#ifndef _INCLUDED_BOUNDS_HPP_
#define _INCLUDED_BOUNDS_HPP_

/**
 * @file   bounds.hpp
 * @author Aron Ahmadia <aron@valkyrie.appmath.columbia.edu>
 * @date   Mon Mar  3 14:44:08 2008
 * 
 * @brief  Bounds - an object for handling boundaries of a partition
 * 
 * 
 */

#include <boost/numeric/ublas/vector.hpp>
#include <boost/version.hpp>
#include "hyper_sample/utility/geometry.hpp"

namespace smo {

  class Bounds 
  {
  public:
    Bounds() {
      depth = -1;
    }

    Bounds(const Region &inBoundAngles) {
      boundAngles = inBoundAngles;
      depth = boundAngles.size1() - 1;
    }

    inline
    PolarAngle lower() const {
      return boundAngles(depth,0);
    } 
   
    inline 
    PolarAngle upper() const {
      return boundAngles(depth,1);
    }
    
    inline 
    void sub() {
      depth--;
    }

    inline 
    void super() {
      depth++;
    }

    inline 
    void reset() {
      depth = boundAngles.size1() -1;
    }
    
  private:
    DimCount depth;
    Region boundAngles;
  };
    
  
  
}


#endif
