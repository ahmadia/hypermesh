function [approxRegionCounts, approxCapPhis] = getApproxRegionCounts(pobj, dimCount, pointCount, polarCapPhi, idealCollarPhi, angleBounds)
%function approxRegionCounts = getApproxRegionCounts(pobj, dimCount, pointCount, polarCapPhi, idealCollarPhi, angleBounds)
%
%determine natural region counts for each collar that best match the
%idealCollarPhi collar angle given an approximate pointCount to satisfy

[rationalRegionCounts, approxCapPhis] = getRationalRegionCounts(pobj, dimCount, pointCount, polarCapPhi, idealCollarPhi, angleBounds);
approxRegionCounts = round(rationalRegionCounts);

