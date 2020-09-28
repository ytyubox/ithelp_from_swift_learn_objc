# [15] 30 天從 Swift 學會 Objective-C：Objective-C 物件的泛型


與泛型的處理
```swift 
// Swift
class Stack<T:Equatable> {
    func push(_:T)
    func pop() -> T
}
```



## Objective-C 如何鎖定泛型
在 Objective-C 2.0 之後，提供了泛型指定的功能，所使用的修飾語法為 `__covariant` 與 `__contravariance`(協變與逆變 [註 1])。

```objectivec
// Objective-C
/* Stack.h */
@interface Stack <__covariant ObjectType> : NSObject
- (void)push:(ObjectType)value;
- (ObjectType) pop;
@end    
```

在 header 檔內，`ObjectType` 是可以取得的，但是在 `.m` 檔中是無法取得的。

```objectivec
// Objective-C
/* Stack.m */
#pragma private property
@interface Stack ()
@property NSMutableArray* list;
@end

@implementation Stack
- (instancetype) init {
    if (self = [super init])
        self.list = [[NSMutableArray alloc] init];
    return  self;
}

- (void)push:(id)value {
    [_list addObject: value];
    return;
}
- (id)pop {
   id object = [_list lastObject];
    [_list removeLastObject];
    return  object;
}
@end
```

最後，我們透過宣告了泛型的型別，一旦後續使用的型別是不一樣的，會有錯誤警告。

```objectivec
// Objective-C
/* main.m */ 
Stack<NSNumber*>* stack = [[Stack alloc] init];
[stack push: @1];
NSString* s =  [stack pop]; // Warning: 1
```
> Incompatible pointer types initializing 'NSString *' with an expression of type 'NSNumber *'


## 註記
1. 協變與逆變: 目前 Objective-C 中文的解釋不多，建議參考： [2015 Objective-C 新特性 · sunnyxx的技术博客] (https://blog.sunnyxx.com/2015/06/12/objc-new-features-in-2015/)

## 簡單測驗
1. 如果你要跟程式新手解釋泛型，你會如何解釋。
2. [進階] 協變與逆變在 Swift 是如何運作的？

