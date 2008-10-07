function polarCapPhi = getPolarCapPhi(pobj, dimCount, totalPointCount)
%function polarCapPhi = getPolarCapPhi(pobj, dimCount, totalPointCount)
%
%credit to P. Leopardi's eq_sphere_partitions code

switch totalPointCount
 case 1
  polarCapPhi = pi;
 case 2
  polarCapPhi = pi/2;
 otherwise
  polarCapPhi = angleOfCap(dimCount,getRegionArea(pobj, dimCount, totalPointCount));
end
