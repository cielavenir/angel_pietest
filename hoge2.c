#include "lib.h"
void hoge2(void) {
  test();
}
#ifdef USE_PIE
int main(void) { }
#endif

