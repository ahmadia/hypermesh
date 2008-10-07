#ifndef _INCLUDED_UBLAS_MATRIX_HPP_
#define _INCLUDED_UBLAS_MATRIX_HPP_

#include <boost/serialization/list.hpp>
#include <boost/serialization/string.hpp>
#include <boost/serialization/version.hpp>
#include <boost/serialization/split_free.hpp>
#include <boost/numeric/ublas/matrix.hpp>

namespace boost {
  namespace serialization {
    template<class Archive, class U>
    inline void save (Archive &ar, const boost::numeric::ublas::matrix<U> &m, const unsigned int) {
      typedef boost::numeric::ublas::matrix<U> matrix;
      unsigned int count1 = m.size1();
      unsigned int count2 = m.size2();
      
      ar << count1 << count2;

      for (unsigned int i = 0; i < count1; ++ i) {
        for (unsigned int j = 0; j < count2; ++ j) {
	  ar << m(i, j);
	}
      }

    }
    
    template<class Archive, class U>
    inline void load (Archive &ar, boost::numeric::ublas::matrix<U> &m, const unsigned int) {
      unsigned int count1, count2;
      ar >> count1 >> count2;
      m.resize(count1,count2,false);

      for (unsigned int i = 0; i < count1; ++ i) {
        for (unsigned int j = 0; j < count2; ++ j) {
	  ar >> m(i, j);
	}
      }

    }
    
    template<class Archive, class U>
    void serialize(Archive & ar, boost::numeric::ublas::matrix<U> &m, const unsigned int file_version)
    {
      boost::serialization::split_free(ar, m, file_version);
    }
    
  
  } // namespace serialization
} // namespace boost

#endif
