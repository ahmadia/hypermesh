function idealArea = getSubRegionArea(pobj, dimCount,areaOfCaps,angleBounds,pointCount)
%function idealArea = getSubRegionArea(pobj, dimCount,areaOfCaps,angleBounds,pointCount)

areaToPartition = areaOfCap(dimCount,angleBounds.upper) - areaOfCap(dimCount,angleBounds.lower);

% subtract off area of caps because we won't be partitioning this
% area among processors (everybody gets a cap)

areaToDivide = areaToPartition - areaOfCaps;

% now partition into ideal region area
idealArea = areaToDivide/pointCount;

%%% Why can't I just use RegionArea that I calculated earlier?