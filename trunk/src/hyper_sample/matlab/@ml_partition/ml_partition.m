function pobj = ml_partition(dimCount, totalPartitionCount, angleBounds, pointCount)
%function pobj = ml_partition(dimCount, totalPartitionCount, angleBounds, pointCount)
%
%Constructor for MATLAB Partition Class


pobj.dimCount = dimCount;
pobj.totalPartitionCount = totalPartitionCount;
pobj.angleBounds = angleBounds;
pobj.pointCount = pointCount;

pobj = class(pobj,'ml_partition');