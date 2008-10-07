function regionList = getRegionList(pobj, dimCount, regionCount)
%function regionList = getRegionList(pobj)
%function regionList = getRegionlist(pobj, dimCount, regionCount)
%
%with credit to P. Leopardi's eq_sphere_partitions code 

if nargin == 1
  regionCount = pobj.pointCount;
  dimCount = pobj.dimCount;
end

if regionCount == 1
  regionList = ml_region_list(getSphereRegion(dimCount));
  return;
end

angleBounds.lower = 0;

if dimCount == 1
  angleBounds.upper = 2*pi; %longitudinal angle in first dimension ranges [0,2*pi]
  [capPhis, regionCounts] = getCaps(pobj, dimCount, angleBounds, regionCount);
  assert(sum(regionCounts) == regionCount);
  % We have a circle and a_cap is an increasing list of angles of sectors,
  % with a_cap(k) being the cumulative arc length 2*pi/k.
  %
  % Return a list of pairs of sector angles.
  %
  regions = zeros(dimCount,2,regionCount);
  regions(:,1,2:regionCount) = capPhis(1:regionCount-1);
  regions(:,2,:) = capPhis;
else
  % We have a number of zones: two polar caps and a number of collars. regionCounts is the list of the
  % number of regions in each zone
  
  angleBounds.upper = pi; %azimuthal angle in first dimension ranges [0,pi]
  [capPhis, regionCounts] = getCaps(pobj, dimCount, angleBounds, regionCount);
  
  assert(sum(regionCounts) == regionCount);
  collarCount = size(regionCounts,2)-2;
  
  % Start with the top cap
  
  regions = zeros(dimCount, 2, regionCount);
  regions(:,:,1) = getTopCapRegion(dimCount, capPhis(1));
  regionIndex = 2;
  
  if dimCount == 2   
    circleOffset = 0;
  end
  
  for iCollar = 1:collarCount
    %
    % capTop is the colatitude of the top of the current collar.
    %
    capTop = capPhis(iCollar);
    %
    % capBottom is the colatitude of the bottom of the current collar.
    %
    capBottom = capPhis(iCollar + 1);
    %
    % iCollarCount is the number of regions in the current collar.
        %
    iCollarCount = regionCounts(iCollar + 1);
    %
    % The top and bottom of the collar are small (dimCount-1)-spheres,
    % which must be divided into iCollarCount regions.
    % Use getRegionList recursively to divide
    % the unit (dimCount-1)-sphere.
    %
    % if iCollarCount = 0, silently ignore this collar   
    if iCollarCount
      collarRegions = getRegionList(pobj, dimCount-1, iCollarCount); 
      % Given collarRegions, determine the dim-regions for the collar.
      % Each element of collarRegions is a (dim-1)-region pair for the (dimCount-1)-sphere.
      %
      collarRegionIndex = 1:iCollarCount;
      
      % Offset rotations on 2-spheres for better energy minimizations
      if dimCount == 2   
        for iRegion = 1:iCollarCount;              
          % Top of 2-region;
          % The first angle is the longitude of the top of
          % the current sector of regions_1, and
          % the second angle is the top colatitude of the collar.
          
          regionTop = [mod(collarRegions(1,1,iRegion)+2*pi*circleOffset,2*pi); capTop];
 
          % Bottom of 2-region;
          % The first angle is the longitude of the bottom of
          % the current sector of regions_1, and
          % the second angle is the bottom colatitude of the collar.
        
          regionBottom = [mod(collarRegions(1,2,iRegion)+2*pi*circleOffset,2*pi); capBottom];
          
          if regionBottom(1) < regionTop(1)
            regionBottom(1) = regionBottom(1) + 2*pi;
          end
          
          regions(:,:,regionIndex) = [regionTop,regionBottom];
          regionIndex = regionIndex + 1;
        end
        
        % Given the number of sectors in the current collar and
        % in the next collar, calculate the next offset.
        % Accumulate the offset, and force it to be a number between 0 and 1.
        
        circleOffset = circleOffset + getCircleOffset(iCollarCount, regionCounts(iCollar + 2));
        circleOffset = circleOffset - floor(circleOffset);
        
      else
        for iRegionIndex = 1:iCollarCount
          
          % Dim-region;
          % The first angles are those of the current (dim-1) region of regions_1.
          %
          regions(1:dimCount-1,:,regionIndex) = collarRegions(:,:,iRegionIndex);
          %
          % The last angles are the top and bottom colatitudes of the collar.
          %
          regions(dimCount,:,regionIndex) = [capTop,capBottom];
          regionIndex = regionIndex + 1;
        end
      end
    end
  end

  %end with the bottom cap
    
  regions(:,:,regionCount) = getBottomCapRegion(dimCount, capPhis(1));
  
end

regionList = ml_region_list(regions);