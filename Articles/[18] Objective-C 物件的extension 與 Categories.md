# [18] 30 天從 Swift 學會 Objective-C：Objective-C 物件的 extension 與 Categories

對現成的事物做延伸是人類獨有的能力，像是水可以載舟，同時也能煮粥。而程式語言也能透過延伸來替現存的物件提供拓展。

![](https://images.unsplash.com/photo-1596464716127-f2a82984de30?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80)
Photo by [@sigmund](https://unsplash.com/@sigmund) on [Unsplash](https://unsplash.com/photos/OV44gxH71DU)

## Swift 的 extension 

在 Swift 中，我們可以根據 [Extension - Swift.org](https://docs.swift.org/swift-book/LanguageGuide/Extensions.html) 的開頭引言，我們可以知道 Extension 可以為現存的類別拓展，尤其是當類別沒有編輯權限的時候。

> Extensions add new functionality to an existing class, structure, enumeration, or protocol type. This includes the ability to extend types for which you do not have access to the original source code (known as retroactive modeling).

## Objective—C 的 Extension 不是 Swift 的 Extension
在 Objective-C 有所謂的 Category 和 Extension，在這裏我們要先告訴讀者：

> Objective—C 的 Extension 不是 Swift 的 Extension

在  [Extension - Swift.org](https://docs.swift.org/swift-book/LanguageGuide/Extensions.html) 同時提到了 Swift 的 Extension 是與 Objective-C 的 Category 相似的：

> Extensions are similar to categories in Objective-C. (Unlike Objective-C categories, Swift extensions do not have names.)

https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/CustomizingExistingClasses/CustomizingExistingClasses.html

也因此我們可以知道 Category 的目的是：
> 提供現有的類別更多的 function。

```objectivec
// Objective-C
/* NSNumber+abs.h */
@interface NSNumber (abs)
- (int) absIntValue;
```

在 interface 後面我們為這個 category 定義一點標籤 `abs`，這個標籤在使用上幾乎是沒有作用的，詳細可以參考 [Do Objective-C Category names do anything? - StackOverflow](https://stackoverflow.com/a/5689130/10172299)。
然而在 Objective-C 有所謂的 extension, 這部分我們在 day 12 的時候其實在 `/* ITPoint+internal.h */` 有用到。值得注意的是，根據 [Apple 官方文件 Customizing Existing Classes](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/CustomizingExistingClasses/CustomizingExistingClasses.html)，我們可以知道 category 與 extension 的使用目的：
1. Category 為現存的類別增加 Method
2. Category 的同名函式會導致不可預期的行為，但是不會有執行錯誤
3. Extension 可以作為 internal 的擴展定義
4. Extension 可以實現 Private 實作。


## [進階] 為類別增加額外的 property
我們知道在 Swift 與 Objective-C 都不能直接在 Extension/Category 增加額外的 property，但是在 Objective-C 有所謂的 `objc_setAssociatedObject` 與 `getAssociatedObject` 可以得到。相關說明可以在 [Category 是否可以增加新的成員變數或屬性？ · KKBOX iOS_Mac OS X 基礎開發教材](https://kkbox.github.io/kkbox-ios-dev/category/member_variables_and_categories.html) 理解。

在 Swift 我們可以這麼處理：

```swift
// Swift
import class Foundation.NSCache

class AssociateObject {
    static let shared: AssociateObject = AssociateObject()
    
    static func `default`() -> AssociateObject {
        AssociateObject()
    }
    private var cache = NSCache<AnyObject, AnyObject>()
    
    func set(_ target: AnyObject, with associateObject: AnyObject) {
        cache.setObject(target, forKey: associateObject)
    }
    func get(_ target: AnyObject) -> AnyObject {
        cache.object(forKey: target)!
    }
    private class Inner {
        internal init(_ any: Any) {
            self.any = any
        }
        var any: Any
    }
}

```
拖過這樣的思想，我們可以理解 Objective-C runtime 如何達成讓類別感覺起來有新的 property。

## 簡單測驗
1. 幾乎所有的 Extension 都可以使用 Delegattion 達成，請說明你有什麼程式碼使用了 Extension 而不是使用 Delegation？
2. [進階] 請說明使用 Extension 與 Delegation 的出發點(目的)是什麼？
