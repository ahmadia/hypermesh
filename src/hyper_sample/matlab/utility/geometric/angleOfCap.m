function phi = angleOfCap(dim, area)
%function phi = angleOfCap(d, a)
%
%find the angle phi that encloses the area a of a d-dimensional
%spherical cap embedded in R^d+1

switch dim
 case 1
  phi = area/2;
 case 2
  phi = 2*asin(sqrt(area/pi)/2);
 otherwise
  sphereArea = areaOfSphere(dim);
  if area >= sphereArea
    phi = pi;
  else
    if (2*area > sphereArea)
      area = sphereArea - area;
      flipped = true;
    else
      flipped = false;
    end
    phi = fzero(@(phi) areaOfCap(dim,phi)-area,[0,pi]);
    if flipped
      phi = pi - phi;
    end
  end
end
