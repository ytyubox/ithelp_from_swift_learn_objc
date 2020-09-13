#   [09] Objective-C 的基本困難 C 語言 自定義 Header

在真實世界中有所謂的呼叫代號，也就是名詞。程式語言也是一樣的，要定義名詞才可以讓子程式互相溝通。

![](https://images.unsplash.com/photo-1512820790803-83ca734da794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1974&q=80)

Photo by [@epicantus]() on ![Unsplash](https://unsplash.com/photos/xY55bL5mZAM)


## Header 是什麼
 Swift 語言是沒有 Header 的概念，取而代之的是 scope，也就是 [Access Control](https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html)，而 C 語言使用 Header 最為 Access Control 的控制元件。

## Umbrella Header
header 內引入其他 Header，使其可以調用。

## Header 的該與不該
Header 就是 interface/protocol，只定義介面，沒有實作。
## Objective-C 的 `#import` 與 `@import`

## 簡單測驗
1. Header 內可以定義宣告與實作，但是實作並不推薦編寫與Header 內，為什麼？
1. 如何在 Header 檔內定義全域變數與全域函式
1. [進階] 從Header 檔內，可以知道是 C 語言的 `.h` 檔還是 Objective-C 的 `.h` 檔嗎？
