function plot(pobj)
%function plot(pobj)
%
%plot the PointList object

x = toCart(pobj.s);
d = size(x,1);

switch d
 case 1
  plot(x);
 case 2
  scatter(x(1,:),x(2,:),'filled');
 case 3
  scatter3(x(1,:),x(2,:),x(3,:),'filled');
 otherwise
  error('dimension of points too high to plot');
end
