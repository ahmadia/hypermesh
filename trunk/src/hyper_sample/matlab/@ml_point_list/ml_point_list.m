function pobj = ml_point_list(s)
%function pobj = ml_point_list(s)
%
% Constructor for MATLAB PointList object
%
% s is a (d x n) array where d is (dimension of the space - 1) and n
% is the number of points.  The points are stored in POLAR
% coordinates and radius = 1 is assumed.

% create a new PointList
pobj.s = s;
pobj = class(pobj, 'ml_point_list');
