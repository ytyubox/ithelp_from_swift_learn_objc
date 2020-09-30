# [16] 30 天從 Swift 學會 Objective-C：Objective-C 物件的 Optional chaining

在現實生活中，我們可以用是否來判斷真理，甚至可以用有沒有判斷事物的存在，並更進一步的查看已存在的事物。

![](https://images.unsplash.com/photo-1587664289285-e6fb47cbe370?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80)

Photo [@beccatapert](https://unsplash.com/@beccatapert) by on [Unsplash](https://unsplash.com/photos/eAfrl7A6gBs)

## Swift 的 Optional

在 Swift 中，有 `enum Optional` 作為可有可無的抽象概念

```swift
// Swift
/* Swift.Optional */

enum Optional<Wrapped> {

    /// The absence of a value.
    case none

    /// The presence of a value, stored as `Wrapped`.
    case some(Wrapped)
    }
```

> 關於 Swift 的 Optional chaining 請參考： [Optional Chaining - Swift.org](https://docs.swift.org/swift-book/LanguageGuide/OptionalChaining.html)

## Objective-C 的 Optional

Objective-C 有所謂的 nil、Nil、NULL，如果不了解的話，請先閱讀由 zonble 撰寫的 [NULL、nil、Nil… · KKBOX iOS_Mac OS X 基本開發教材](https://zonble.gitbooks.io/kkbox-ios-dev/content/uncategorized/nil.html)

## Objective-C 空訊息

之間我們有提到，Objective-C 是使用訊息傳遞的方式，作為物件 Method 的呼叫。

```Objectivec
// Objective-C
[[[NSObject alloc] init] description];
```

我們使用的 3 個 method 呼叫，分別為：
1. NSObject static member: `alloc`
2. NSObject object member: `init`
3. NSObject object member: `description`

然而我們知道，alloc 是有可能在記憶體不夠的時候，回傳 `NULL` 的，當這個情形發生的時候，而接下來的程式碼(init, description)會直接忽略。

而為了避免程式碼直接被忽略，我們可以在使用之前判斷 object 是不是真的存在：

```Objectivec
// Objective-C
NSObject* object = [NSObjct alloc];
if (object) object = [object init];
else NSLog(@"object fail alloc");
if (object) [object description];
else NSLog(@"object fail init");
```

> 檢查物件是否存在有另一個效能考量，詳細請參考 [Objective-C: Why check nil before respondsToSelector:?](https://stackoverflow.com/questions/6479267/objective-c-why-check-nil-before-respondstoselector)

## 簡單測驗
1. 如果你要向程式新手解釋 Optional chaining，你會如何解釋
