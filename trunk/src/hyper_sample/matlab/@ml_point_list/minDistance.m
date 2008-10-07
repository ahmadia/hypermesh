function d = minDistance(pobj)
%function d = minDistance(pobj)
%
%computes the minimum distance between any two points in the
%PointList

x = toCart(pobj);

d = 2;
n_points = size(x,2);
for i = 1:(n_points-1)
    j = (i+1):n_points;
    x1 = x(:,i)*ones(1,n_points-i);
    x2 = x(:,j);
    dist = sqrt(sum((x1-x2).^2));
    d = min(d,min(dist));
end

