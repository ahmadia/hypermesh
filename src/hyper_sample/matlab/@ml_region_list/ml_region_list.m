function robj = ml_region_list(s)
%function robj = ml_region_list(s)
%
% Constructor for MATLAB RegionList object
%
% r is a (d x 2 x n) array where d is (dimension of the space - 1), and n is the number of regions.  The
% regions are stored in POLAR coordinates and radius = 1 is assumed.  

% create a new RegionList
robj.s = s;
robj = class(robj, 'ml_region_list');

