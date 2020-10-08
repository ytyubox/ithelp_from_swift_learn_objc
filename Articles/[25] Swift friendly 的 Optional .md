# [25] 30 天從 Swift 學會 Objective-C：Swift friendly 的 Optional 

Swift 的 optional 是一個很有趣的概念，因為在 Objective-C 與 C 語言，相關的概念是使用 0 代稱。

![](https://images.unsplash.com/photo-1520853504280-249b72dc947c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80)


## 複習 Swift 的 Optional syntax

在開始了解之前，我們先複習以下 [Swift Optionals - Swift.org](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html#ID330)
我們要了解的目標是 `MyClass?` 與 `MyClass!`


## 處理 C 語言的 Pointer NULL
 
我們知道 Class 在 C 語言是 Pointer，而 Pointer 為了提供記憶體管理使得 Pointer 是可以為 NULL，在 Swift 因為 ARC 的關係而可以使用

在我們透過 Xcode 建立一個 Cocoa Touch class 時，Xcode 給了我們一個 template file，這個 template 檔案內建有 `NS_ASSUME_NONNULL_BEGIN`、`NS_ASSUME_NONNULL_END`

![](https://i.imgur.com/xcCKdU9.png)
> 這兩個代表在其行數間的物件如果沒有其他定義，則預設不可以有 NULL Pointer。


## Class? 與 Class!


|imports into Swift as | Methods and properties| Any Pointer |
|MyClass|nonnull| _Nonnull |
|MyClass?| nullable| _Nullable |
|MyClass!| null_unspecified | _Null_unspecified|

> 表格來自 WWDC 2020 - [Refine Objective-C frameworks for Swift](https://developer.apple.com/videos/play/wwdc2020/10680/) 



@property(nullable) NSString* name;
-(nonnull instancetype) initWithName(nullable NSString*)name;

## 簡單測驗
1. 請說明使用 MYClass! 的時機是什麼？
