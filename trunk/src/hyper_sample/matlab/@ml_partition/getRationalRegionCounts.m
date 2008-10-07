function [rationalRegionCounts, rationalCapPhis] = getRationalRegionCounts(pobj, dimCount, pointCount, polarCapPhi, idealCollarPhi, angleBounds)
%function [rationalRegionCounts, rationalCapPhis] = getRationalRegionCounts(pobj, dimCount, pointCount, polarCapPhi, idealCollarPhi, angleBounds)
%
%Determine fractional region counts and matching Cap Phis given an exact pointCount to satisfy and an ideal collar angle

myCollarRange = angleBounds.upper - angleBounds.lower;
if angleBounds.lower == 0
  myCollarRange = myCollarRange - polarCapPhi;
end

if angleBounds.upper == pi
  myCollarRange = myCollarRange - polarCapPhi;
end

collarCount = max(1,round(myCollarRange./idealCollarPhi));
  
capCount = (angleBounds.lower == 0) + (angleBounds.upper == pi);
areaOfCaps = capCount* areaOfCap(dimCount, polarCapPhi);
regionCount = collarCount + capCount;

rationalRegionCounts = zeros(1,regionCount);
rationalCapPhis = zeros(1,regionCount);

if angleBounds.lower == 0
  rationalRegionCounts(1) = 1;
  rationalCapPhis(1) = polarCapPhi;
  collarCountOffset = 1;
  collarAngleOffset = polarCapPhi;
else
  collarCountOffset = 0;
  collarAngleOffset = angleBounds.lower;
end

myRange = angleBounds.upper - angleBounds.lower;

if collarCount > 0
    %
    % Based on collarCount and polarCapPhi, determine fittingPhi,
    % the collar angle such that collarCount collars fit between
    % upper and lower region bounds.
    %
    fittingPhi = (myRange-capCount*polarCapPhi)/collarCount;
    regionArea = getSubRegionArea(pobj,dimCount,areaOfCaps,angleBounds,pointCount-capCount);
    for iCollar = 1:collarCount
      collarLower = (iCollar-1)*fittingPhi + collarAngleOffset;
      collarUpper = collarLower + fittingPhi;
      collarArea = areaOfCollar(dimCount, collarLower, collarUpper);
      rationalRegionCounts(collarCountOffset+iCollar) = collarArea / regionArea;
      rationalCapPhis(collarCountOffset + iCollar) = collarUpper; 
    end
end

if angleBounds.upper == pi
  rationalRegionCounts(collarCountOffset+collarCount+1) = 1;
  rationalCapPhis(collarCountOffset+collarCount+1) = pi;
end

assert(norm(sum(rationalRegionCounts) - pointCount) < norm(pointCount)*1e4*eps);
