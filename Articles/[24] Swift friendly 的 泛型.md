# [24] 30 天從 Swift 學會 Objective-C：Swift friendly 的 泛型
泛型是支撐 Swift 能夠實現 Protocol-oriented Programming 的基礎，Objective-C 在如此的功能是可以支援的。

![](https://images.unsplash.com/photo-1484480974693-6ca0a78fb36b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1052&q=80)

Photo by [@glenncarstenspeters](https://unsplash.com/@glenncarstenspeters) on [Unsplash](https://unsplash.com/photos/RLw-UC03Gwc)


![](https://i.imgur.com/yzYF47C.png)


在 Day 15 的時候，我們討論過如何使用 Objective-C type。

```objectivec
//Objective-C
@interface OCBox1 <__contravariant ObjectType> : NSObject
- (_Nullable ObjectType) some;

@end
@interface OCBox2 <__covariant ObjectType> : NSObject
- (_Nullable ObjectType) some;

@end
```


## Objective-C 不能限制 generic 型別

在 Swift 我們可以使用 `where` 限制泛型的約束

```Swift
// Swift
class Box<T> where T: Comparable {

}
```

然而 Objective-C 目前是沒有提供這樣的語法。我們能做的，只有透過 extension 實作。

```Swift
// swift
/* OCBox+Compareable */
extension OCBox where ObjectType: Comparable {

}
```

## 簡單測驗
1. extension 可以用 adopter 改寫嗎？
