function region = getBottomCapRegion(dimCount, capPhi)
%function region = getBottomCapRegion(dimCount, capPhi)
%
% an array of two points representing the bottom cap of radius capPhi as a region

if dimCount == 1
  region = [2*pi-capPhi, 2*pi];
else
  sphereRegion = getSphereRegion(dimCount-1);
  region = [[sphereRegion(:,1); pi-capPhi], [sphereRegion(:,2); pi]];
end