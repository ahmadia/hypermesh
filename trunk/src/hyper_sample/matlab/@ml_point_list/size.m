function dimSizes = size(pobj, dim)
%function dimSizes = size(pobj, dim)

switch nargin
 case 1
  dimSizes = size(pobj.s);
 case 2
  dimSizes = size(pobj.s,dim);
end