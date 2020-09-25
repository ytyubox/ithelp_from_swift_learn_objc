# [12] 30 天從 Swift 學會 Objective-C：Objective-C 物件的封裝 Encapsulation

很多時候，我們有需要隱藏手法的時候，不論是阿嬤的秘密料理、魔術師的魔術、成功人士的成功方式，都有這只有圈內人士才知道的秘密。而程式設計也是同樣道理的。

![](https://images.unsplash.com/photo-1485622204874-8ee4a42c4969?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2089&q=80)

Photo by [@1walter2](https://unsplash.com/@1walter2) on [Unsplash](https://unsplash.com/photos/BowRurRX5e8)

## 封裝是封裝了什麼？

## C 語言的封裝

```c
// C
/* point.h */
struct point;
typedef struct point point;
point* pointMake(void);
int getx(point*);
int gety(point*);
```

## Objective-C 的封裝

封裝或許在iOS 開發上可能用不太到，但是在 Library/Framework 的部分很值得討論。
首先請先看看下面這的 Public header。

```objectivec
// Objective-C
/* ITPoint.h */
#import <Foundation/Foundation.h>
@interface ITPoint : NSObject

+ (instancetype)make;
- (NSInteger)getx;
- (NSInteger)gety;
@end
```
這代表 Client 端可以呼叫到這三個函式。

而下面這個 header 檔沒有被納入 pubilc header 中

```objectivec
// Objective-C
/* ITPoint+internal.h */
#import "ITPoint.h"
@interface ITPoint ()
@property NSNumber * x;
@property NSNumber * y;
@end

```
也因為`ITPoint.m` 是圈內人士，可以知道所有的 header

```objectivec
// Objective-C
/* ITPoint.m */
#import "ITPoint.h"
#import "ITPoint+internal.h"

@implementation ITPoint
+ (instancetype) make {
    ITPoint* p =  [[self alloc] init];
    return p;
}
- (NSInteger)getx {
    return  [self.x intValue]; // self.x 屬於 internal
}
- (NSInteger)gety {
    return [self.y intValue];  // self.y 屬於 internal
}
@end
```
如此一來，`NSNumber* x` 與 `NSNumber* y` 就會在不知不覺的情況下，進入到 Client 的程式碼內了！

## 簡單測驗
1. 如果你要向程式新手說明什麼是封裝，你會如何解釋？
2. [進階] 說明 C 語言的 `struct point;` 是什麼？ 他的目的是什麼？
