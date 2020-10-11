# [27] 30 天從 Swift 學會 Objective-C：Swift friendly 的 Unavailable  convenience init

物件導向的設計中，關於建構物件的方式我們成為建構器(constructor)，這關係到物件使用的方式，是很重要的事情。
![](https://images.unsplash.com/photo-1542644384-49f9febd8443?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1655&q=80)

Photo by [@kellysikkema](https://unsplash.com/@kellysikkema) on [Unsplash](https://unsplash.com/photos/V106bb1a9BY)

## 
而 Objective-C 的物件因為都是繼承自 NSObject，這代表所有的 物件將會自帶有 `init()` 的建構器。在我們可以透過 `@available(*, unavailable)` 的方式透過編譯器的阻擋來限制
```swift
// Swift
class Base { init() {}}

class Sub: Base {
    @available(*, unavailable, message: "please using init(name:)")
    override init() {fatalError("Will never perform")}
    init(name:String) {
        super.init()
        ...
    }
}

let sub = Sub() // 'init()' is unavailable: please using init(name:)
```

> 關於 `@avaliable`，請參考 [Attributes — The Swift Programming Language](https://docs.swift.org/swift-book/ReferenceManual/Attributes.html#ID348)

### Objective-C 是使用 `NS_UNAVAILABLE`

在 Objective-C 我們可以使用同樣的方式來表達 `unavailable`，透過 `NS_UNAVAILABLE`，而 Swift interface 則可以透過這個關鍵字提供錯誤呼叫的提示。

```objectivec
// Objective-C
@interface OCSub: NSObject
-(instancetype) init NS_UNAVAILABLE;
@end

OCSub* sub = [[OCSub alloc] init]; // 'init' is unavailable
```
## 複習 convenience init


Swift 很強調關於 init 的可讀性，`convenience init` 是在 class 提供多種建構器時必須要有的語法提示。在 Objective-C 並沒有這樣強制的語法，然而對於 Swift 開發者理解的部分我們可以使用 `NS_DESIGNATED_INITIALIZER` 來提供 Swift interface 關鍵字。

![](https://i.imgur.com/5kUvz8p.png)


## 簡單測驗
1. `@available(*, unavailable) init()` 與 `init() {fatalError()}` 在開發者的角度上，你比較偏好哪個？
