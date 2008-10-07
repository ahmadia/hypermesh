#ifndef _INCLUDED_GEOMETRY_HPP_
#define _INCLUDED_GEOMETRY_HPP_
/**
 * @file   geometry.hpp
 * @author Aron Ahmadia <aron@casiphia.local>
 * @date   Tue Feb 26 14:43:29 2008
 * 
 * @brief  Geometry - A set of static methods to assist in hypersphere decomposition
 * 
 * 
 */

#include <boost/numeric/ublas/vector.hpp>
#include <boost/numeric/ublas/matrix.hpp>
//#include "boost_ext/ublas_vector.hpp"
//#include "boost_ext/ublas_matrix.hpp"
#include <boost/version.hpp>

namespace smo {

  const double pi = M_PI;

  typedef double PolarAngle;
  typedef double Area;
  typedef int DimCount;
  typedef int PointCount;
  typedef int RegionCount;

  typedef boost::numeric::ublas::matrix<PolarAngle> Region;
  typedef boost::numeric::ublas::matrix<PolarAngle> SpherePoints;
  typedef boost::numeric::ublas::vector<RegionCount> RegionCounts;
  typedef boost::numeric::ublas::vector<double> CartPoint;
  typedef boost::numeric::ublas::matrix<double> CartPoints;

  typedef struct {
    DimCount d;
    Area capAreaZero;
  } AreaOfCapP;

  class Geometry
  {
  public:
    /** 
     * Find the angle that encloses the area of a d-dimensional spherical cap embedded in R^{d+1}
     * 
     * @param d dimension of the sphere
     * @param capArea area enclosed by the angle
     * 
     * @return angle that ecloses capArea
     */
    static PolarAngle angleOfCap(DimCount d, Area capArea);
    static PolarAngle polarCap(DimCount d, PointCount n);
    static Area regionArea(DimCount d, PointCount n);
    static Area regionArea(DimCount d, Area polarCapArea, PolarAngle phi1, PolarAngle phi2, PointCount n);
    static Area areaOfCap(DimCount d, PolarAngle capPhi);
    static Area areaOfCap(PolarAngle capPhi,AreaOfCapP &p);
    static Area areaOfSphere(DimCount d); 
    static Area areaOfCollar(DimCount d, PolarAngle phi1, PolarAngle phi2); 
    static void bottomCapRegion(DimCount d, PolarAngle capPhi, Region &r);  
    static void topCapRegion(DimCount d, PolarAngle capPhi, Region &r);
    static void sphereRegion(DimCount d, Region &r);
    static PolarAngle circleOffset(PointCount p1, PointCount p2);
    static void toPolar(CartPoints p, SpherePoints &s);
    static void toCart(SpherePoints s, CartPoints &p);
  };
}




#endif
