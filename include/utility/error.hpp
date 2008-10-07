#ifndef _INCLUDED_ERROR_HPP_
#define _INCLUDED_ERROR_HPP_

#include <stdexcept>

namespace smo {
  class meshError : public std::runtime_error {
  public:
    meshError(const char *s) : std::runtime_error(s) {}
  };
}

#endif
