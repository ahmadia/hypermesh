function angleBoundsTree = buildAngleBoundsTree(hobj,regions, offset)

% special cases

% longitudinal axis

if size(regions,1) == 1
  % sanity check - boundaries are touching and unique
  assert( size(unique(regions),2) == size(regions,3) + 1 );
  angleBoundsTree.lower = squeeze(regions(1,1,:));
  angleBoundsTree.upper = squeeze(regions(1,2,:));
  angleBoundsTree.upper(end) = angleBoundsTree.upper(end) + eps(angleBoundsTree.upper(end));
  if size(regions,3) == 1
    angleBoundsTree.leafIndex = 1 + offset;
  else
    angleBoundsTree.leafIndex = 0;
    for i=1:size(regions,3)
      angleBoundsTree.branch{i}.leafIndex = i + offset;
    end
  end
  return;
end

% single polar cap
if size(regions,3) == 1
  % sanity check - bounds are satisfied
  testArray = regions(1:end,1,:) == 0;
  assert( all(testArray(:)) );
  testArray = regions(2:end,2,:) == pi;
  assert( all(testArray(:)) );
  testArray = regions(1,2,:) == 2*pi;
  assert( all(testArray(:)) );
  angleBoundsTree.leafIndex = 1 + offset;
  return;
end
  
angleBoundsTree.leafIndex = 0;

% two polar caps
if size(regions,3) == 2
  % sanity check - bounds are satisfied
  testArray = regions(end,1,1) == 0;
  assert( all(testArray(:)) );
  testArray = regions(end,2,2) == pi;
  assert( all(testArray(:)) );
  angleBoundsTree.lower = squeeze(regions(1,1,:));
  angleBoundsTree.upper = squeeze(regions(1,2,:));
  angleBoundsTree.upper(end) = angleBoundsTree.upper(end) + eps(angleBoundsTree.upper(end));
  angleBoundsTree.branch{1}.leafIndex = 1 + offset;
  angleBoundsTree.branch{2}.leafIndex = 1 + offset;
  return;
end
  
% otherwise

[lowerBounds,iLow, jLow] = unique(regions(end,1,:));
[upperBounds,iHigh, jHigh] = unique(regions(end,2,:));

branchCount = length(lowerBounds);

angleBoundsTree.lower = lowerBounds;
angleBoundsTree.upper = upperBounds;
angleBoundsTree.upper(end) = angleBoundsTree.upper(end) + eps(angleBoundsTree.upper(end));
regionOffset = 0;

for iBranch=1:branchCount
  regionIndex = find(jLow == iBranch);
  angleBoundsTree.branch{iBranch} = ...
      buildAngleBoundsTree(hobj,regions(1:end-1,:,regionIndex),regionOffset);
  regionOffset = regionOffset + length(regionIndex);
end