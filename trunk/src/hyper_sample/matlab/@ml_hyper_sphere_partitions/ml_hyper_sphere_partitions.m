function hobj = ml_hyper_sphere_partitions(dimCount, dimPartitionCount, totalPartitionCount, partitionPointCount)
%function hobj = ml_hyper_sphere_partitions(dimCount, dimPartitionCount, totalPartitionCount, partitionPointCount)
%
%Constructor for MATLAB HyperSpherePartitions object
%
%Creates a partition of the dimCount-dimensional hypersphere embedded in dimCount+1 space
%
%dimCount            - total dimensions of the hypersphere
%dimPartitionCount   - number of the last n dimensions partitioned
%totalPartitionCount - number of partitions on the hypersphere
%partitionPointCount - number of points in each partition

assert(dimPartitionCount <= dimCount);

hobj.dimCount = dimCount;
hobj.dimPartitionCount = dimPartitionCount;
hobj.totalPartitionCount = totalPartitionCount;
hobj.partitionPointCount = partitionPointCount;

masterPartition = ml_partition(dimPartitionCount, 1, false, totalPartitionCount); 
regions = getRegionList(masterPartition);
%regions = eq_regions(dimPartitionCount,totalPartitionCount);

dimOffset = dimCount - dimPartitionCount;

for i=1:totalPartitionCount
  for j=1:dimOffset
    angleBounds(j).lower = 0;
    angleBounds(j).upper = (1 + (j==dimCount))*pi;
  end
  for j=1:dimPartitionCount
    %parse region angles in the direction I use them (longitudinal LAST)
    angleBounds(j+dimOffset).lower = regions(dimPartitionCount-j+1,1,i);
    angleBounds(j+dimOffset).upper = regions(dimPartitionCount-j+1,2,i);
  end
 
  partitions{i} = ml_partition(dimCount, totalPartitionCount, angleBounds, partitionPointCount);
  
end

hobj.partitions = partitions;
hobj.angleBoundsTree = [];

hobj = class(hobj,'ml_hyper_sphere_partitions');

% Generate tree search table for fast C++ tree traversal to identify partition
%hobj.angleBoundsTree = buildAngleBoundsTree(hobj,regions,0);
