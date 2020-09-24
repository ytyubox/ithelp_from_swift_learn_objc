#  [10] 30 天從 Swift 學會 Objective-C：Objective-C 的基本困難 C 語言 Preprocessor

程式設計有時候可以利用自動化大大節省事情的處理時間，但有時候如果對於語言的不熟悉，可能會造成程式碼不如預期，而這件事常常出現在 C 語言的預處理部分！

![](https://images.unsplash.com/photo-1563673244345-bc2fcd20f88e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80)

Photo by [@nathangbingle](https://unsplash.com/@nathangbingle) on  [Unsplash](https://unsplash.com/photos/K9MaGDSbOTg)

## 【重要擋修】什麼是預處理部分？

在 C 語言中有所謂的前 4 步驟，詳閱 [C preprocessor: Phases - wiki](https://en.wikipedia.org/wiki/C_preprocessor#Phases)
在開始之前，請你回答，註解(comment)，是不是預處理要處理的項目之一？答案是： 是的，是預處理的項目。

我們將從 3 個方面切入：
1. 引用檔案 include file
2. 條件編譯 Conditional compilation
3. 巨集定義與擴展 Macro definition and expansion

## Swift 的預處理
是的沒錯， Swift 也有預處理的環節。分別如下：

1. 引用檔案： `import`，透過這個指令，我們可以使用 其他 module 的程式碼。
2. 條件編譯： 
    * `#if (MYFLAG && DEBUG)`，在 Swift 的編譯指令 `swift build -Xswiftc "-DMYFLAG" -Xswiftc "-DDEBUG"` 加入自己的編譯變數。
    * `#if canImport(MODULE)`、`#if os(OSNAME)`、`#if arch(ARCH` 針對作業系統的設定編譯
    * `@available(iOS 13, *)` 與 `if #available(iOS 13, *)`，針對 OS版本的條件編譯
3. 巨集定義(無擴展)：`#filepath`、`#function`、`#line`、`typealias`

> 以上是我濃縮的 Swift preprocessor，主要希望可以引起讀者回憶，因此相對簡略很多。

## Objective-C 與 C 語言的預處理

在 C 語言與 Objective-C 使用的預處理幾乎是一模一樣的，同樣的，我們從三個面向處理：

1. 引用檔案：`#include`
早在系列開始的前期 `#include <HEADER.h>`，一直圍繞在 C 語言的範例中，詳細可以看第 9 天的文章，值得提醒的是 Objective-C 在檔案引用多了 `#import` 與 `@import`，還有在後續的Objective-C 物件導向會提到 `@class`

2. 條件編譯： `#ifdef` 與 `#ifndef`
在上一個文章中，我們有提到 `Include guard`，就是使用了條件編譯。而且由於 Swift 在預處理部分絕大多數承襲了 Objective-C，因此在 Flag 的定義也是如此。
```c
// C
#define DEBUG 1
#if DEBUG
log(_SOMETHING_TO_LOG_);
#endif
```

OS版本的檢查也與 Swift 相似
```Objectivec
// Objective-C
if (@available(macOS 20, *)) {
    printf("macOS above 20\n");
}
```
3. 巨集定義與擴展：
這應該是最難懂的部分了。
### builtin macros 預定義巨集
首先，我們可以先從 Swift 相似的 `#filepath`、`#function`、`#line` 開始，C 語言已經有支援，Objective-C 可以使用。
| 巨集 | 解釋|
|:--:|:--:| 
| __DATE__ | 目前的日期字串，固定格式為 "MMM DD YYYY" |
| __TIME__ | 目前的時間字串，固定格式為 "HH:MM:SS" |
| __FILE__ | 當前行所在的 source code 檔案名稱 |
| __LINE__ |當前行所在的 source code 行數，以十進位表示 |
| __OBJC__ | 當前編譯是否有採用 -objC     |

> 更多預先定義到了巨集可以參考 [Clang Language Extensions — Clang 12 documentation](https://clang.llvm.org/docs/LanguageExtensions.html#builtin-macros)

### 自定義巨集

在 C 語言中，自定義巨集基本上就是沒有邏輯的文字代換，也就是說可以將向替換的文字替換成自定義文字，請參考下面的 `main.c`:
```c
// C
#define NUMBER int
#define BEGIN {
#define END }
#define EXIT_SUCCESS 0

NUMBER main()
BEGIN
    return EXIT_SUCCESS;
END
```
相信讀者可以感受到一絲絲苦難了，如果沒有可以嘗試看看 [這個](https://github.com/eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee/eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee) GitHub 專案，找找看 `e.c` 檔案。

但是 `#define` 用的好，有時候會大大幫助開發時間，這部分在歷屆的鐵人賽已經有針對 C 語言的介紹，很實用。
1.  [30 Days 如何把 C 語言偽裝成高階語言 OWO /系列 - Day 21：重溫前置處理器、巨集( #, ## )、預先定義的巨集](https://ithelp.ithome.com.tw/articles/10207697)
2. [30 Days 如何把 C 語言偽裝成高階語言 OWO /系列 - Day 28： 例外處理系列：研究結束中 ：finally() 、進行封裝、巨集優化](https://ithelp.ithome.com.tw/articles/10209571)
3. [30 Days 如何把 C 語言偽裝成高階語言 OWO /系列 - Day 28： 例外處理系列：研究結束中 ：finally() 、進行封裝、巨集優化](https://ithelp.ithome.com.tw/articles/10209571)

## Objective-C 特別的定義

在 Objective-C 有所謂的強調型別，透過 `objc.h` 的定義，可以看到很特別的處理。
> 這部分我推薦 [bool 與 BOOL · KKBOX iOS_Mac OS X 基本開發教材](https://zonble.gitbooks.io/kkbox-ios-dev/content/uncategorized/boolean.html)，該文說明十分清楚。

```Objectivec
// Objective-C
/* objc.h */
#define YES __objc_yes
#define NO  __objc_no
...
#   define Nil __DARWIN_NULL
...
#   define nil __DARWIN_NULL
...
```
> 建議讀者打開電腦查找 `objc.h`, 自己瀏覽一遍。

## 簡單問題
1. 說明 `#define square(x) x * x` 會造成什麼問題
2. 找找看 `io.ccc` 與 preprocessor 有關的得獎程式，嘗試分享你看懂多少。
