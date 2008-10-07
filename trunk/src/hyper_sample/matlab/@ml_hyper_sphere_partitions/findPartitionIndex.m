function partitionIndex = findPartitionIndex(hobj, x)
%function partitionIndex = findPartitionIndex(hobj, x)

% The below is really bad matlab code written to help me prototype
% some C++ code, it shouldn't be incorporated into a production
% environment since it is dead slow

assert(size(x,2)==1);

s = toPolar(x);

angleBoundsTree = getAngleBoundsTree(hobj);

dimCount = hobj.dimCount;

for iAngle = dimCount:-1:1
  if angleBoundsTree.leafIndex
    break;
  end
  branchIdx = find(s(iAngle) >= angleBoundsTree.lower & ...
                   s(iAngle) < angleBoundsTree.upper);
  angleBoundsTree = angleBoundsTree.branch{branchIdx}
end

partitionIndex = angleBoundsTree.leafIndex;
  
