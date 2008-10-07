function a = areaOfCollar(d, phi1, phi2)
%function a = areaOfCollar(d, phi1, phi2)
%
% computes the area of the collar between phi1 and phi2

assert(phi1 < phi2);

a = areaOfCap(d,phi2) - areaOfCap(d,phi1);

