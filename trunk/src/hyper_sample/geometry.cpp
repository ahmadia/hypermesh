/**
 * @file   geometry.cpp
 * @author Aron Ahmadia <aron@casiphia.local>
 * @date   Tue Feb 26 15:26:49 2008
 * 
 * @brief  Geometry - Implementation of Geometry methods
 * 
 * 
 */

#include "hyper_sample/utility/geometry.hpp"
#include "utility/error.hpp"

#include <iostream>

#include <cmath>

#include <o2scl/funct.h>
#include <o2scl/gsl_root_brent.h>
#include <gsl/gsl_sf_gamma.h>

#include <boost/numeric/ublas/matrix_proxy.hpp>
#include <boost/math/common_factor.hpp>

namespace smo {

  using namespace boost::numeric::ublas;  
  using namespace boost::math;

  PolarAngle Geometry::polarCap(DimCount d, PointCount n) 
  {
    switch (n) {
    case 1:
      return pi;
    case 2:
      return pi/2;
    }
    return angleOfCap(d, regionArea(d,n));
  }

  Area Geometry::regionArea(DimCount d, PointCount n)
  {
    return areaOfSphere(d)/n;
  }

  Area Geometry::regionArea(DimCount d, Area polarCapArea, PolarAngle phi1, PolarAngle phi2, PointCount n)
  {
    Area toPartition = areaOfCollar(d,phi1,phi2);
    Area toDivide = toPartition - polarCapArea;
    return toDivide/n;
  }

  PolarAngle Geometry::angleOfCap(DimCount d, Area capArea) 
  {
    switch (d) {
      case 1:
	return capArea/2;
      case 2:
	return 2*asin(sqrt(capArea/pi)/2);
      }
    // general case d > 2
    
    Area sphereArea = areaOfSphere(d);
    
    if (capArea >= sphereArea) {
      return pi;
    }
    else {
      o2scl::funct_fptr_noerr<AreaOfCapP> f(&Geometry::areaOfCap);
      o2scl::gsl_root_brent<AreaOfCapP,o2scl::funct<AreaOfCapP> > s;
      double x1 = 0;  // lower bound AND returned solution for solve_bkt, see O2 documentation
      AreaOfCapP p;
      p.d = d;
      if (2*capArea > sphereArea) {
	p.capAreaZero = sphereArea - capArea;
	s.solve_bkt(x1,pi,p,f);
	return pi - x1;
      }
      else {
	p.capAreaZero = capArea;
	s.solve_bkt(x1,pi,p,f);
	return x1;
      }  
    }    
  }
  
  Area Geometry::areaOfCap(DimCount d, PolarAngle capPhi) 
  {
    AreaOfCapP p;
    p.d = d;
    p.capAreaZero = 0;
    return areaOfCap(capPhi, p);
  }
  
  Area Geometry::areaOfCap(PolarAngle capPhi, AreaOfCapP &p) 
  {
    DimCount d = p.d;
    Area capAreaZero = p.capAreaZero;    
    double e;
    switch (d) {
    case 1:
      return 2*capPhi - capAreaZero;
    case 2:
      return 4*pi*pow(sin(capPhi/2),2) - capAreaZero;
    case 3:
      if (capPhi < pi/6 || capPhi > pi*5/6) { //Near the poles, use the incomplete Beta function ratio.
	e = static_cast<double>(d);    
	return areaOfSphere(d) * gsl_sf_beta_inc(e/2,e/2,pow(sin(capPhi/2),2)) 
	  - capAreaZero;
      }
      else {
	//In the tropics, use closed solution to integral.
	return (2*capPhi - sin(2*capPhi))*pi;
      }
    }

    e = static_cast<double>(d);    	
    return areaOfSphere(d) * gsl_sf_beta_inc(e/2,e/2,pow(sin(capPhi/2),2)) 
      - capAreaZero;
  }
  
  Area Geometry::areaOfSphere(const DimCount d)
  {
    double e = static_cast<double>(d+1)/2;
    return 2*pow(pi,e)/gsl_sf_gamma(e);
  }

  Area Geometry::areaOfCollar(const DimCount d, const PolarAngle phi1, const PolarAngle phi2)
  {
    if (phi1 >= phi2) {
      throw meshError("The collar angle phi1 is greater than or equal to phi2\n");
    }
    return areaOfCap(d,phi2) - areaOfCap(d,phi1);
  }

  void 
  Geometry::bottomCapRegion(const DimCount d, const PolarAngle capPhi, Region &r)
  {
    r.resize(d,2);
    if (d == 1) {
      r(0,0) = 2*pi - capPhi;
      r(0,1) = 2*pi;
    }
    else {
      // r(1:d-1,:) = SphereRegion(d-1);
      Region rSphere(d-1,2);
      sphereRegion(d-1, rSphere);
      subrange(r, 0, d-1, 0 ,2) = rSphere;
      r(d-1,0) = pi-capPhi;
      r(d-1,1) = pi;
    }
  }

  void 
  Geometry::topCapRegion(const DimCount d, const PolarAngle capPhi, Region &r)
  {
    r.resize(d,2);
    if (d == 1) {
      r(0,0) = 0;
      r(0,1) = capPhi;
    }
    else {
      // r(1:d-1,:) = SphereRegion(d-1);
      Region rSphere(d-1,2);
      sphereRegion(d-1, rSphere);
      subrange(r, 0, d-1, 0 ,2) = rSphere;
      r(d-1,0) = 0;
      r(d-1,1) = capPhi;
    }
  }

  void
  Geometry::sphereRegion(DimCount d, Region &r) 
  {
    r.resize(d,2);
    r(0,0) = 0;
    r(0,1) = 2*pi;

    for (int i=1; i < d; i++) {
      r(i,0) = 0;
      r(i,1) = pi;
    } 	 
    return;
  }

  PolarAngle 
  Geometry::circleOffset(const PointCount p1, const PointCount p2)
  {
    double d1 = static_cast<double> (p1);
    double d2 = static_cast<double> (p2);
    double sectorTwistAlign = (1/d2 - 1/d1)/2;
    double maxMinAngleRot = gcd(p1,p2)/(2*d1*d2);
    return sectorTwistAlign + maxMinAngleRot;
  }

  void
  Geometry::toPolar(CartPoints p, SpherePoints &s)
  {
    PointCount n = p.size1();
    DimCount d = p.size2() - 1;
    PolarAngle iSinProd;
    PolarAngle aTanTheta;
  
    s.resize(n,d);

    for (int i=0; i < n; ++i) {
      iSinProd = 1;
      for (int j=d-1; j > 0; --j) {
	s(i,j) = acos(p(i,j+1)/iSinProd);
	iSinProd *= sin(s(i,j));
      } 
      aTanTheta = atan2(p(i,1),p(i,0));
      if (aTanTheta >= 0) {
	s(i,0) = aTanTheta;
      }
      else {
	s(i,0) = aTanTheta + 2*pi;
      }
    }    
    return;
  }
   
  void
  Geometry::toCart(SpherePoints s, CartPoints &p)
  {
    PointCount n = s.size1();
    DimCount d = s.size2() + 1;
    PolarAngle iSinProd;
    //    double radiusSqSum, radius;
  
    p.resize(n,d);

    for (int i=0; i < n; ++i) {
      iSinProd = 1;
      // radiusSqSum = 0;
      for (int j=d-1; j > 1; --j) {
	p(i,j) = iSinProd*cos(s(i,j-1));
	//	radiusSqSum += pow(p(i,j),2);
	iSinProd *= sin(s(i,j-1));
      } 
      p(i,1) = iSinProd*sin(s(i,0));
      p(i,0) = iSinProd*cos(s(i,0));


      /* extra code to verify radius is == 1     
      radiusSqSum += pow(p(i,1),2) + pow(p(i,0),2);
      if (radiusSqSum != 1) {
	radius = sqrt(radiusSqSum);
	for (int j=0; j < d; ++j) {
	  p(i,j) = p(i,j)/radius;
	}
      } */
    }    
    
    return;
  }
  
}
