function topCapRegion = getTopCapRegion(dimCount, capPhi)
%function topCapRegion = getTopCapRegion(dimCount, capPhi)
%
% An array of two points representing the top cap of radius capPhi as a region

if dimCount == 1
  topCapRegion = [0, capPhi];
else
  sphereRegion = getSphereRegion(dimCount-1);
  topCapRegion = [[sphereRegion(:,1); 0], [sphereRegion(:,2); capPhi]];
end
