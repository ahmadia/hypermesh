#ifndef _INCLUDED_ZONES_TREE_HPP_
#define _INCLUDED_ZONES_TREE_HPP_

/**
 * @file   zones_tree.hpp
 * @author Aron Ahmadia <aron@casiphia.local>
 * @date   Tue May 13 18:47:44 2008
 * 
 * @brief  ZonesTree class definition, includes ZonesTreeNode
 * 
 * 
 */

#include <vector>
#include "hyper_sample/utility/geometry.hpp"


namespace smo {
  
  typedef int RegionIndex;
  typedef int ZonesTreeNodeIndex;
  typedef int ZonesTreeNodeCount;
  
  typedef struct 
  {
    RegionIndex lastRegion;
    ZonesTreeNodeIndex subNodeStart;
    RegionCount subZoneCount;
    PolarAngle zoneAngle;
  } ZonesTreeNode;

  typedef std::vector<Region> RegionList;
  typedef std::vector<ZonesTreeNode>::iterator ZonesTreeIterator;

  class ZonesTree
  {
  public:
    ZonesTree(DimCount dimCount, RegionCount regionCount);
    // ZonesTree(DimCount dimCount, RegionCount totalRegionCount, RegionIndex localRegionStart, RegionIndex localRegionEnd);
    // void region(RegionIndex outRegionIndex, Region &outRegion);
    // void regionRange(RegionIndex rangeStart, RegionIndex rangeEnd, RegionList &outRegionList);
    // double nearestNeighborDistance();
    
    ZonesTreeNodeCount size() {return nodes.size();}
    DimCount getDimCount() {return dimCount;}
    RegionCount getRegionCount() {return regionCount;}
    void getPoint(RegionIndex pointIndex, CartPoint &cartPoint);
    void display() const;
    

  private:
    void buildSubTree(DimCount dimCount, RegionCount regionCount, PolarAngle zoneAngle, RegionIndex regionStartIndex, ZonesTreeNodeIndex nodeStartIndex, ZonesTreeNode &rootNode, ZonesTreeNodeIndex &nodeEndIndex);

    void buildPolarCapNode(RegionIndex regionIndex, PolarAngle capAngle, ZonesTreeNode &capNode);
    DimCount dimCount;
    RegionCount regionCount;
    RegionIndex localRegionStart;
    RegionIndex localRegionEnd;
    std::vector<ZonesTreeNode> nodes;
  };

}


#endif
