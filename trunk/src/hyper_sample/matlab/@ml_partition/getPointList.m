function pointList = getPointList(pobj, arg2, angleBounds, pointCount, variant)
%function pointList = getPointList(pobj)
%function pointList = getPointList(pobj, variant)
%function pointList = getPointList(pobj, dimCount, angleBounds, pointCount)
%function pointList = getPointList(pobj, dimCount, angleBounds, pointCount, variant)
%
%with credit to P. Leopardi's eq_sphere_partitions code 

if nargin < 3
  pointCount = pobj.pointCount;
  dimCount = pobj.dimCount;
  angleBounds = pobj.angleBounds;
end

if nargin == 2
  variant = arg2;
elseif nargin > 2
  dimCount = arg2;
end

if nargin ~= 2 && nargin < 5
  variant = 'saff';
end

switch variant
 case 'saff'
  isPointCountApprox = false;
  areCapPhisApprox = false;
 case 'ahmadia'
  isPointCountApprox = false;
  areCapPhisApprox = true;
 case 'rosenbluth'
  isPointCountApprox = true;
  areCapPhisApprox = true;
 otherwise
  error('unknown variant');
end

totalPointCount = pobj.totalPartitionCount*pointCount;

% 1-dimensional sphere is a special case

if pointCount == 1
  points_back = ones(dimCount,1).*([angleBounds(:).upper]' + [angleBounds(:).lower]')/2;
  points = points_back(end:-1:1);
  pointList = ml_point_list(points);
  return;
end

[capPhis, regionCounts] = getCaps(pobj, dimCount, angleBounds(1), pointCount, isPointCountApprox, areCapPhisApprox);

if isPointCountApprox
  pointCount = sum(regionCounts);
else
  assert(sum(regionCounts)==pointCount);
end

if dimCount == 1
  % We have a circle and capPhis is an increasing list of angles of sectors,
  % with capPhis(k) being the cumulative arc length 2*pi/k.
  % The points are placed half way along each sector.
  %
  points = capPhis - pi/totalPointCount;
else
  % We have a number of zones: two polar caps and a number of collars.
  % regionCounts is the list of the number of regions in each zone.
  
  capCount = (angleBounds(1).lower == 0) + (angleBounds(1).upper == pi) ;
  collarCount = size(regionCounts,2)-capCount;
  points = zeros(dimCount,pointCount);
  if dimCount == 2
    circleOffset = 0; 
  end
  
  % check here to see if the North pole is in my partition
  if angleBounds(1).lower == 0
    %
    % Start with the 'centre' point of the North polar cap.
    % This is the North pole.
    %
    pointIndex = 2; % pointIndex = 0 in this dimCountension
    collarIndexOffset = 1;
  else
    pointIndex = 1; % points_1(:,1) = 0 (North Pole) is handled by another partition
    % inject the lower bound in the front of the cap list
    capPhis = [angleBounds(1).lower capPhis];
    collarIndexOffset = 0;
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
    iCollarCount = regionCounts(iCollar + collarIndexOffset);
    %
    % The top and bottom of the collar are small (dimCount-1)-spheres,
    % which must be divided into iCollarCount regions.
    % Use getPointList recursively to divide
    % the unit (dimCount-1)-sphere.
    % collarPoints is the resulting list of points.
    %
    % if iCollarCount = 0, silently ignore this collar
    if iCollarCount
      collarPoints = getPointList(pobj, dimCount-1, angleBounds(2:end), iCollarCount); 
     
      % Given collarPoints, determine the 'center' points for the collar.
      % Each point of collarPoints is a 'center' point on the (dimCount-1)-sphere.
      %
      % Angular 'center' point;
      % The first angles are those of the current 'center' point
      % of collarPoints, and the last angle in polar coordinates is the average of
      % the top and bottom angles of the collar,
      %
      collarCenter = (capTop+capBottom)/2;
      %
      collarPointsIndex = 1:iCollarCount;
      
      % Offset rotations on 2-spheres for better energy minimizations, skip last collar if no pole
      % currently disabled for lower neighbor interface areas
      
%      if dimCount == 2 && iCollar + collarIndexOffset ~= length(regionCounts)
 %       points(1,pointIndex+collarPointsIndex-1) = mod(collarPoints(:,collarPointsIndex)+2*pi*circleOffset,2*pi);
  %      circleOffset = circleOffset + getCircleOffset(iCollarCount,regionCounts(iCollar + collarIndexOffset + 1));
   %     circleOffset = circleOffset - floor(circleOffset);
    %  else
        points(1:dimCount-1,pointIndex+collarPointsIndex-1) = collarPoints(:,collarPointsIndex);
     % end

      points(dimCount, pointIndex+collarPointsIndex-1) = collarCenter;
      pointIndex = pointIndex + size(collarPoints,2);
    end
  end
  if angleBounds(1).upper == pi
    % south pole
    points(:,pointIndex) = zeros(dimCount,1);
    points(dimCount,pointIndex) = pi;
  end
end

pointList = ml_point_list(points);