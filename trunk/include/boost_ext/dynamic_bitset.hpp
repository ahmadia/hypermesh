#ifndef _INCLUDED_DYNAMIC_BITSET_HPP_
#define _INCLUDED_DYNAMIC_BITSET_HPP_

/**
 * @file   dynamic_bitset.hpp
 * @author Aron Ahmadia <aron@casiphia.apam.columbia.edu>
 * @date   Tue Jul 10 09:36:57 2007
 * 
 * @brief  extensions to boost serialization for handling dynamic bitset types
 * 
 * 
 */

// TODO: Consider packing the data more carefully into unsigned integers

#include <boost/serialization/list.hpp>
#include <boost/serialization/string.hpp>
#include <boost/serialization/version.hpp>
#include <boost/serialization/split_free.hpp>
#include <boost/dynamic_bitset.hpp>


namespace boost {
  namespace serialization {
    template<class Archive>
    inline void save (Archive &ar, const boost::dynamic_bitset<> &b, const unsigned int) {
      unsigned int count = b.size();
      ar << count;
      for (int i=0; i < count; i++) {
	bool tmp;
	tmp = b[i];
	ar << tmp;
      }
    }
    
    template<class Archive>
    inline void load (Archive &ar,  boost::dynamic_bitset<> &b, const unsigned int) {
      unsigned int count;
      ar >> count;
      b.resize(count);      
      for (int i=0; i < count; i++) {
	bool tmp;
	ar >> tmp;
	b[i] = tmp;
      }
    }
    
    template<class Archive>
    void serialize(Archive & ar, boost::dynamic_bitset<> &b, const unsigned int file_version)
    {
      boost::serialization::split_free(ar, b, file_version);
    };
    
  
  } // namespace serialization
} // namespace boost

#endif
