#ifndef _INCLUDED_ZONES_HPP_
#define _INCLUDED_ZONES_HPP_

/**
 * @file   zones.hpp
 * @author Aron Ahmadia <aron@valkyrie.appmath.columbia.edu>
 * @date   Wed Apr 23 14:29:32 2008
 * 
 * @brief  Zones - an object describing a set of collars and caps across a sphere
 * 
 * 
 */

#include "hyper_sample/utility/geometry.hpp"
#include "hyper_sample/bounds.hpp"

namespace smo {

  typedef double RationalCount;
  typedef RegionCount ZoneCount;
  typedef boost::numeric::ublas::vector<RegionCount> RegionCounts;
  typedef boost::numeric::ublas::vector<RationalCount> RationalCounts;
  typedef boost::numeric::ublas::vector<PolarAngle> PolarAngles;
  
  class Zones
  {

  public:
    /** 
     * Given a region defined by \p boundaryAngles on a
     * hypersphere with dimension \p dimCount, create an integral
     * distribution of \p localRegionCount regions over the collars
     * and polar caps.  
     * 
     * @param dimCount 
     * @param localRegionCount
     * @param localRegion 
     *
     */
    Zones(DimCount dimCount, RegionCount localRegionCount, const Bounds &boundaryAngles); 
    Zones(DimCount dimCount, RegionCount localRegionCount); 
    void ZonesFactory(DimCount dimCount, RegionCount localRegionCount, const Bounds &boundaryAngles); 

    void computeCapAngles(RegionCount localRegionCount);
    void computeRationalRegionCounts(RationalCounts &regionCounts);
    void roundRegionCounts(const RationalCounts &rationalRegionCounts);
    void refineCollarAngles();  // not implemented!

    ZoneCount getZoneCount() {return capCount + collarCount;}
    PolarAngle getPolarCapAngle() {return polarCapAngle;}
    void getRegionCounts(RegionCounts *&regionCounts) {regionCounts = &this->regionCounts;} 
    void getCapAngles(PolarAngles *&capAngles) {capAngles = &this->capAngles;}
    
    static void setGlobalRegionCount(RegionCount globalRegionCount) {Zones::globalRegionCount = globalRegionCount;}
    static void setEnforceSymmetric(bool enforceSymmetric) {Zones::enforceSymmetric = enforceSymmetric;}
    static void setEnforceExactCount(bool enforceExactCount) {Zones::enforceExactCount = enforceExactCount;}
    static void setRefineCollars(bool refineCollars) {Zones::refineCollars = refineCollars;}

  private:
    bool containsNorthPole;
    bool containsSouthPole;
    RegionCount capCount;
    RegionCount collarCount;

    DimCount dimCount;
    Bounds boundaryAngles;
    Area regionArea;
    PolarAngle polarCapAngle;
    
    RegionCounts regionCounts;
    PolarAngles capAngles;
    
    static RegionCount globalRegionCount;
    static bool enforceSymmetric;
    static bool enforceExactCount;
    static bool refineCollars;
  };

}
#endif
