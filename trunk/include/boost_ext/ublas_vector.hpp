#ifndef _INCLUDED_UBLAS_VECTOR_HPP_
#define _INCLUDED_UBLAS_VECTOR_HPP_

#include <boost/serialization/list.hpp>
#include <boost/serialization/string.hpp>
#include <boost/serialization/version.hpp>
#include <boost/serialization/split_free.hpp>
#include <boost/numeric/ublas/vector.hpp>

namespace boost {
  namespace serialization {
    template<class Archive, class U>
    inline void save (Archive &ar, const boost::numeric::ublas::vector<U> &v, const unsigned int) {
      unsigned int count = v.size();
      ar << count;
      typename boost::numeric::ublas::vector<U>::const_iterator it = v.begin();
      while (count-- > 0) {
	ar << *it++;
      }
    }
    
    template<class Archive, class U>
    inline void load (Archive &ar, boost::numeric::ublas::vector<U> &v, const unsigned int) {
      unsigned int count;
      ar >> count;
      v.resize(count);
      typename boost::numeric::ublas::vector<U>::iterator it = v.begin();
      while (count-- > 0) {
	ar >> *it++;
      }
    }
    
    template<class Archive, class U>
    void serialize(Archive & ar, boost::numeric::ublas::vector<U> &v, const unsigned int file_version)
    {
      boost::serialization::split_free(ar, v, file_version);
    }
    
  
  } // namespace serialization
} // namespace boost

#endif
