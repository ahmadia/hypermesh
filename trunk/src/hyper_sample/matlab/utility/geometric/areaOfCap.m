function area = areaOfCap(dim,phi)
%function a = areaOfCap(d,phi)
%
% Finds the area of an S^dim spherical cap of spherical radius phi
% inspired by Leopardi's eq_partitions code

switch dim
 case 1
  area = 2 * phi;
 case 2
  area = 4*pi * sin(phi/2).^2;
 case 3
  shape = size(phi);
  n = prod(shape);
  phi = reshape(phi,1,n);
  area = zeros(size(phi));
  % Near the poles, use the incomplete Beta function ratio.
  %
  pole = (phi < pi/6) | (phi > pi*5/6);
  area(pole) = areaOfSphere(dim) * betainc(sin(phi(pole)/2).^2, dim/2, dim/2);
  %
  % In the tropics, use closed solution to integral.
  %
  trop = phi(~pole);
  area(~pole) = (2*trop-sin(2*trop))*pi;
  area = reshape(area,shape);
 otherwise
  area = areaOfSphere(dim) * betainc(sin(phi/2).^2, dim/2, dim/2);
end