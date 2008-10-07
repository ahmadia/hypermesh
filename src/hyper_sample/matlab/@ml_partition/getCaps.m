function [capPhis, regionCounts] = getCaps(pobj, dimCount, angleBounds, pointCount, isPointCountApprox, areCapPhisApprox)
%function [capPhis, regionCounts] = getCaps(pobj, dimCount, angleBounds, pointCount, isPointCountApprox, areCapPhisApprox)
%
%credit to P. Leopardi's eq_sphere_partitions code

totalPointCount = pobj.totalPartitionCount*pointCount;

if nargin < 5
  isPointCountApprox = false;
end

if nargin < 6
  areCapPhisApprox = false;
end

if isPointCountApprox
  getRegionCountsFun = @getApproxRegionCounts;
else
  getRegionCountsFun = @getRegionCounts;
end

if dimCount == 1
  % We have a circle. Return the angles of N equal sectors.
  %
  sector = 1:pointCount;
  %
  % Make dimCount==1 consistent with dimCount>1 by
  % returning the longitude of a sector enclosing the
  % cumulative sum of arc lengths given by summing regionCounts.
 
  myRange = angleBounds.upper - angleBounds.lower;
  capPhis = sector*myRange/pointCount + angleBounds.lower;
  regionCounts = ones(size(sector));
  
  % these aren't really phi's, they are longitudinal angles breaking
  % up the sector
  %
elseif pointCount == 1
  %
  % We have only one region, which must be the whole sphere.
  %
  capPhis = [angleBounds.lower(end)];
  regionCounts = [1];
  %
else
  %
  % Given dimCount and the totalPointCount, determine polarCapPhi,
  % the colatitude of the North polar spherical cap.
  %
  
  polarCapPhi = getPolarCapPhi(pobj, dimCount, totalPointCount);
 
  %
  % Given dimCount and N, determine the ideal angle for spherical collars.
  
  regionArea = getRegionArea(pobj, dimCount,totalPointCount);
  idealCollarPhi = regionArea.^(1/dimCount);

  % Determine regionCounts,
  % a list of the natural number of regions in each collar and
  % the polar caps.
  % This list is as close as possible to an ideal division of area
  % The sum of regionCounts is N.
  %
  
  if areCapPhisApprox
    [regionCounts, capPhis] = feval(getRegionCountsFun,pobj,dimCount,pointCount,polarCapPhi,idealCollarPhi,angleBounds);
  else
    regionCounts = feval(getRegionCountsFun,pobj,dimCount,pointCount,polarCapPhi,idealCollarPhi,angleBounds);
 
    %
    % Given dimCount, N, polarCapPhi and regionCounts, determine capPhis,
    % an increasing list of colatitudes of spherical caps which enclose the same area
    % as that given by the cumulative sum of regions.
    % capPhis[1] is the lowest collar in the region.
    %
    
    capPhis = getCapPhis(pobj, dimCount, pointCount, polarCapPhi, regionCounts, angleBounds);
  
  end
  
 end

