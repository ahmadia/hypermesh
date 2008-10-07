function a = areaOfSphere(d)
%function a = areaOfSphere(d)
%
% Finds the area of the d-sphere embedded in R^(d+1)

e = (d+1)/2;
a = 2*pi.^e./gamma(e);
