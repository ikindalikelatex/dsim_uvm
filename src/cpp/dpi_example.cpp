#include <iostream>
#include <cstdio>
#include <svdpi.h>

using namespace std;

extern "C" {

  uint64_t dpi_get_sum(uint64_t a, uint64_t b) {
    return uint64_t(a + b);
  }

}