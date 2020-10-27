#include "lib.h"
void hoge1(void) {
  test();
}
#ifdef USE_PIE
int main(void) { }
#endif
