function x = toCart(s)
%TOCART Convert hyperspherical polar points to Cartesian coordinates 
%Syntax
%x = toCart(s)
%
%Description
% X = TOCART(S) sets X to be the Cartesian coordinates of the
% points represented by the spherical polar coordinates S
% 
% S is assumed to be an array of size (dim-1 by N) representing N
% points of S^dim in spherical polar coordinates (one azimuthal
% theta followed by dim-2 polar phi angles), where dim and N are
% positive integers. X will be an array of size (dim by N).   
%
%Examples
%>> s
%
%s =
%
%    0.8383    0.6056    1.0998    0.1619
%    1.4669    1.4832    0.5700    0.7890
%
%>> x = toCart(s)
%
%x =
%
%    0.6651    0.8190    0.2449    0.7004
%    0.7395    0.5670    0.4809    0.1144
%    0.1037    0.0875    0.8419    0.7045
%
% code inspired by Leopardi's eq_sphere_partitions software
% See Also: toPolar

dim = size(s,1) + 1;
n = size(s,2);
x = zeros(dim,n);

sinProd = 1;
for k=dim:-1:3
  x(k,:) = sinProd.*cos(s(k-1,:));
  sinProd = sinProd.*sin(s(k-1,:));
end

x(2,:) = sinProd.*sin(s(1,:));
x(1,:) = sinProd.*cos(s(1,:));

% filter numerical inaccuracies

radius = sqrt(sum(x.^2));

% get index of points with radius not equal to one
i = (radius ~= 1);

% re-normalize 'bad' points to radius 1
if any(i)
  x(:,i) = x(:,i)./(ones(dim,1)*radius(i));
end


