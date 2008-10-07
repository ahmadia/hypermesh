function hyperPointPolar = toPolar(hyperPointCart)
%function hyperPointPolar = toPolar(hyperPointCart)
%
% converts d-dimensional hyperPoints in Cartesian coordinates to
% Polar coordinates with radius implicitly assumed to be 1.
%
% code inspired by Leopardi's eq_sphere_partitions software
% See Also: toCart

%normalize cartesian points to a sphere of radius 1
r = repmat(sqrt(sum(hyperPointCart.^2)),size(hyperPointCart,1),1);
x = hyperPointCart./r;

dim = size(hyperPointCart,1) - 1;
n = size(hyperPointCart,2);
hyperPointPolar = zeros(dim,n);

% triangular solve for Polar coordinates
iSinProd = 1;
for i=dim:-1:2
  hyperPointPolar(i,:) = acos(x(i+1,:)./iSinProd);
  iSinProd = iSinProd.*sin(hyperPointPolar(i,:));
end

hyperPointPolar(1,:) = cart2pol(x(1,:)./iSinProd,x(2,:)./iSinProd);

negThetaIndex = find(hyperPointPolar(1,:) < 0);

if prod(size(negThetaIndex))
  hyperPointPolar(1,negThetaIndex) = hyperPointPolar(1,negThetaIndex) + 2*pi;
end

