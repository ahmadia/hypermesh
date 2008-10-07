function [regionCounts, approxCapPhis] = getRegionCounts(pobj, dimCount, pointCount, polarCapPhi, idealCollarPhi, angleBounds)
%function [regionCounts, approxCapPhis] = getRegionCounts(pobj, dimCount, pointCount, polarCapPhi, idealCollarPhi, angleBounds)
%
%determine natural region counts for each collar that best match the
%idealCollarPhi collar angle given an exact pointCount to satisfy

[rationalRegionCounts, approxCapPhis] = getRationalRegionCounts(pobj, dimCount, pointCount, polarCapPhi, idealCollarPhi, angleBounds);

discrepancy = 0;
for iZone = 1:size(rationalRegionCounts,2)
  regionCounts(iZone) = round(rationalRegionCounts(iZone)+discrepancy);
  discrepancy = discrepancy+rationalRegionCounts(iZone)-regionCounts(iZone);
end

assert(sum(regionCounts) == pointCount);
