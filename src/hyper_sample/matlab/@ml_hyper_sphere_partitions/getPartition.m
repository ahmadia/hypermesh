function pobj = getPartition(hobj, partitionIndex)
%function pobj = getPartition(hobj, partitionIndex)
%
%Accessor for partition objects in HyperSpherePartitions list

pobj = hobj.partitions{partitionIndex};
