function circleOffset = getCircleOffset(topPointCount, bottomPointCount)
%function circleOffset = getCircleOffset(topPointCount, bottomPointCount)
%
% The values topPointCount and bottomPointCount represent the numbers of equally spaced points on two
% overlapping circle arcs
%
% The offset is given in multiples of whole rotations, and consists of two parts
%
% 1) Half the difference between a twist of one sector on each of bottom and top. 
% This brings the centre points into alignment.
% 2) A rotation which will maximize the minimum angle between
% points on the two circles.

circleOffset = (1/bottomPointCount - 1/topPointCount)/2 + gcd(topPointCount, bottomPointCount)/(2*topPointCount*bottomPointCoint);