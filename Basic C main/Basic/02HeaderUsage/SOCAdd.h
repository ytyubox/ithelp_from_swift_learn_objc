#ifndef __ADD__
#define __ADD__
int SOCAdd(int l, int r);
static inline int foo() {
  return 2 + 1;
}

struct Family {
    int memberCount;
};
static inline struct Family familyMake() {
    struct Family family = {.memberCount = 0};
    return family;
}
#endif
