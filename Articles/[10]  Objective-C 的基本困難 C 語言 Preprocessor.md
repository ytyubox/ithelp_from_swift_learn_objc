#  [10] 30 天從 Swift 學會 Objective-C：Objective-C 的基本困難 C 語言 Preprocessor

程式設計有時候可以利用自動化大大節省事情的處理時間，但有時候如果對於語言的不熟悉，可能會造成程式碼不如預期，而這件事常常出現在 C 語言的預處理部分！

![](https://images.unsplash.com/photo-1563673244345-bc2fcd20f88e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80)

Photo by [@nathangbingle](https://unsplash.com/@nathangbingle) on  [Unsplash](https://unsplash.com/photos/K9MaGDSbOTg)

## 【重要擋修】什麼是預處理部分？

在 C 語言中有所謂的前 4 步驟，詳閱 [C preprocessor: Phases - wiki](https://en.wikipedia.org/wiki/C_preprocessor#Phases)

我們將從 3 個方面切入：
1. 引用檔案 include file
2. 條件編譯 Conditional compilation
3. 巨集定義與擴展 Macro definition and expansion

## Swift 的預處理
```swift
#if DEBUG
#endif
```
```swift
if @avaliable() {

}
@avaliable(...)
func
#filepath, #line, #function
typealias
// comment
/* comment */
```

## C 語言的預處理

其實你已經在用預處理了，#include <HEADER.h>

if ndefine
define REPLEASEDTEXT TARGETTEXT

### define https://www.tutorialspoint.com/objective_c/objective_c_preprocessors.htm
1    __DATE__ The current date as a character literal in "MMM DD YYYY" format

2    __TIME__ The current time as a character literal in "HH:MM:SS" format

3     __FILE__ This contains the current filename as a string literal.

4    __LINE__ This contains the current line number as a decimal constant.

5    __STDC__  Defined as 1 when the compiler complies with the ANSI standard.

```c
#if define
#else
#endif
```

### typedefine

## Objective-C 的預設定義

Null、NULL、null

## 簡單問題
1. 說明 `#define square(x) x * x` 會造成什麼問題
2. 
