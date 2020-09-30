# [17] 30 天從 Swift 學會 Objective-C：Objective-C 物件的 Protocol 與 type casting

在 Day 13 的時候，我們了解的 Objective-C 的繼承，現在學會繼承的你，很適合來理解 Protocol。

![](https://images.unsplash.com/photo-1483706571191-85c0c76b1947?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80)

Photo by [@jamesponddotco](https://unsplash.com/@jamesponddotco) on [Unsplash](https://unsplash.com/photos/1qkyck-UL3g)


## Swift 的 Protocol Oriented Programming (POP)
在 Swift 中，Protocol 可以是完全沒有內容的，我們可以將其想像為標籤，不改變物件的內容與實作，單純給予型別。

```swift
// Swift
class Person {}
protocol VIP {}
class Shopkeeper:Person, VIP {}

let r: Person = ShopKeeper()
r is VIP             // true
```

## Objective-C Protocol 引用必須要改寫 Header 檔

首先，我們編寫 `Shopkeeper` 的 Objective-C 類別

```objectivec
// Objective-C
/* Shopkeeper.h */
@interface Shopkeeper : NSObject

@end
```

為了實現 Swift 的 `class Shopkeeper: VIP` 我們必須要改寫 `@interface Shopkeeper`。


```diff
// Objective-C
/* Shopkeeper.h */ 
- @interface Shopkeeper : NSObject
+ @interface Shopkeeper : NSObject <VIP>
@end
```

Swift 的 `is` 運算子，Objective-C 相似於使用 `isKindOfClass:`、`isMemberOfClass:`、`conformsToProtocol:`，而 `conformsToProtocol:` 是其中用來檢查 Protocol 的套用。

```Objectivec

// Objective-C
N* n = [N alloc];

[n conformsToProtocol: @protocol(VIP)]; // true
```

------

如果你向讓一個不可以編寫 header 檔的類別套用 Protocol，你可以使用 override 的方式

```objectivec
// Objective-C
/* Shopkeeper.m */

@implementation Shopkeeper (vip)
- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    return [super conformsToProtocol:aProtocol] ||
     aProtocol == @protocol(VIP);
}
@end
```

## 簡單測驗
1. 很多人常說使用 Protocol 可以降低耦合，請問什麼是耦合？
