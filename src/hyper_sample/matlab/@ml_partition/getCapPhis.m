function capPhis = getCapPhis(pobj, dimCount, pointCount, polarCapPhi, regionCounts, angleBounds)
%function capPhis = getCapPhis(pobj, dimCount, pointCount, polarCapPhi, regionCounts, angleBounds)
%
%solve for the polar angles that satisfy the given region counts

capCount = (angleBounds.lower == 0) + (angleBounds.upper == pi);
collarCount = size(regionCounts,2) - capCount;

capPhis = zeros(size(regionCounts));
if angleBounds.lower == 0
  capPhis(1) = polarCapPhi;
  areaAboveMe = areaOfCap(dimCount, polarCapPhi);
  collarOffset = 1;
else
  collarOffset = 0;
  areaAboveMe = areaOfCap(dimCount, angleBounds.lower);
end

areaOfCaps = capCount*areaOfCap(dimCount, polarCapPhi);
myRange = angleBounds.upper - angleBounds.lower;

if (pointCount-capCount)
  regionArea = getSubRegionArea(pobj, dimCount, areaOfCaps, angleBounds, pointCount-capCount);
  
  regionCountTotal = 0;
  
  for iCollar = 1:collarCount
    regionCountTotal = regionCountTotal+regionCounts(iCollar + collarOffset);
    capPhis(iCollar+collarOffset) = angleOfCap(dimCount, regionCountTotal*regionArea + areaAboveMe);
  end
end
  
if angleBounds.upper == pi;
  capPhis(1 + collarCount + collarOffset) = pi;
else
  assert(norm(capPhis(collarCount+collarOffset) - angleBounds.upper) < eps*100*norm(angleBounds.upper));
end
