function region = getSphereRegion(dimCount)
%function region = getSphereRegion(dimCount)
%
% The sphere represented as a single region of an EQ partition

if dimCount == 1
  region = [0,2*pi];
else
  sphereRegion = getSphereRegion(dimCount-1);
  region = [[sphereRegion(:,1); 0], [sphereRegion(:,2); pi]];
end