function dimSizes = size(robj, dim)
%function dimSizes = size(robj, dim)

switch nargin
 case 1
  dimSizes = size(robj.s);
 case 2
  dimSizes = size(robj.s,dim);
end