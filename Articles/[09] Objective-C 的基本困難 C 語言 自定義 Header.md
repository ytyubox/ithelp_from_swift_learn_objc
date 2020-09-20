#   [09] 30 天從 Swift 學會 Objective-C：Objective-C 的基本困難 C 語言 自定義 Header

在真實世界中有所謂的呼叫代號，也就是名詞。程式語言也是一樣的，要定義名詞才可以讓子程式互相溝通，如果使用了一個看不懂的名詞，真實世界可能會造成不可彌補的失誤（如：iOS 稱呼為 jOS、|OS），程式設計也是一樣，使用不對的名詞輕則無法使用，重則會造成商業損失。

![](https://images.unsplash.com/photo-1512820790803-83ca734da794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1974&q=80)

Photo by [@epicantus]() on ![Unsplash](https://unsplash.com/photos/xY55bL5mZAM)


## Header 是什麼
C 語言的 Header 檔案是遇到 `Massive main file` [註 1]，要先了解的事情。就如同先前 [day 7：Objective-C 的基本 C 語言 library 使用]() 提到的  `include directive` [註 2]，相對與 Header，C 語言具有預先宣告的方式：
```C
// C
/* main.c */

int functionFromOtherCFile();

int main() {
    int excutedResult = functionFromOtherCFile();
    return excutedResult;
}
```

然而當有多數的 Function、Structure 要使用時，行數也會逐漸變多。因此可以使用 Header 來集中需要的 C 結構。
```C
// C
/* ITHelpFunctions.h */

int functionFromOtherCFile();

/* main.c */

#include "ITHelpFunctions.h"
int main() {
    return functionFromOtherCFile();
}
```

Header 檔案的優勢在  [Include directive - wiki](https://en.wikipedia.org/wiki/Include_directive)，有以下的解釋：

`Include directive` 允許開發函式庫以幫助：

1. 確保每個人在整個程式中都基於使用相同版本的資料架構定義或自定義函式，
1. 在程式的系統中使用各種組件的可以很容易交叉引用，
1. 在需要時輕鬆更改程式碼（僅必須編輯一個主文件，而不需要在每個呼叫 API 的 Clint 修改），
1. 以及無需編寫大量適應作業系統資料架構的程式碼，從而節省了開發時間（較小但實用）。

> Swift 語言是沒有 Header 的概念，取而代之的是 scope，也就是 [Access Control](https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html)，而 C 語言使用 Header 最為 Access Control 的控制元件。
 

## Umbrella Header
Header 內引入其他 Header，縮減引入大量套件程式碼時的所需的時間，這樣的方式 雖然 C 語言沒有特別定義，而 Objective-C 則將其定義為 `Umbrella Header`。編寫的方式如下。

1. 準備多個 `.h` 檔案，以下範例使用 `file1.h`、`file2.h`、`file3.h`，並分別寫入 `void f1();`、`void f2();`、`void f2();`
2. 建立一個 header 檔，以下範例使用 `fileKit.h` 為例：
```C
// C
/* fileKit.h */
#include "file1.h"
#include "file2.h"
#include "file3.h"
```
3. 完成 `.c` 檔案的實作，並在 `main.c` 的使用：
```C
// C
#include "fileKit.h"
int main() {
    f1();
    f2();
    f3();
    return EXIT_SUCCESS;
}
```


## Header 的該與不該
這個部分將針對兩個部分 `include guard` 與 `static inline`，其餘的部分並沒有很明顯的差異，請參考 [How to write your own header file in C? - Geeksforgeeks](https://www.geeksforgeeks.org/write-header-file-c/)

## Include guard 聚集防範
C 語言的編譯有一定的原理，簡單來說，就是將所有引用檔案視為一個檔案，因此不論引用的可視範圍為何，只要有同名的函式或結構，都會導致編譯問題：
```C
// C
/* Family.h */
struct Family {
    int memberCount;
};

/* Father.h */
#include "Family.h"


檔案「Mother.c」
#include "Family.h"
#include "Father.h"
```
#### 造成編譯錯誤 
```
struct Family {
    int memberCount;
};
struct Family {
    int memberCount;
};
```

由於 `Mother.c` 內引用了 `Family.h` 與 `Father.h`，會導致編譯的失敗，因為 `struct Family` 會因此宣告多次。
解決辦法是使用 `#ifndef` 的 Preprocessor，詳細解釋將會在下一篇提到：
```C
// C
/* Family.h */
#ifndef __FAMILY__H
#define __FAMILY__H
struct Family {
    int memberCount;
};
#endif
```

> 值得注意的是由於 C 語言的編譯器會將所有引入檔案視為同一個，因此要特別注意命名的部分，其中 Header 的宣告通俗的習慣是 `__FILENAME__H`，保持通俗的一致可以避免不必要的問題發生。

### `static inline function`  內聯函數

內聯函數有點進階，如果你還不是很了解的話，建議先閱讀 [Inline function - wiki](https://en.wikipedia.org/wiki/Inline_function)。

> 如果你還是看不懂的話，不要看完這個部分並記住：我學會內聯函數之前，Header 不寫 function 定義，只寫 宣告。

在 Swift 語言中，要表示一個內聯函數，是可以的，透過  `@inlinable` 與 `@usableFromInline`，詳細可以參考 [ SE-0193](https://github.com/apple/swift-evolution/blob/master/proposals/0193-cross-module-inlining-and-specialization.md) 

而 C 語言的實作可以這樣使用： 

```C
// C
/* Family.h */
#ifndef __FAMILY__H
#define __FAMILY__H

struct Family {
    int memberCount;
};
static inline struct Family familyMake() {
    struct Family family = {.memberCount = 0};
    return family;
}
#endif
```


> C 語言的 inline 方式可以在 Objective-C 使用，但是 Objective-C 的衍生語法是沒有 inline 的能力的，後續在討論 ` objc_MsgSend` 會提到。

## Objective-C 的 `#import` 與 `@import`

## 簡單測驗
1. Header 內可以定義宣告與實作，但是實作並不推薦編寫在 Header 內，為什麼？
1. 從Header 檔內，可以知道是 C 語言的 `.h` 檔還是 Objective-C 的 `.h` 檔嗎？
1. [進階] 如何在 Header 檔內定義全域變數與全域函式

## 註記：
1. `Massive main file` : 我對於 iOS 開發時會遇到的 `Massive ViewController` 的改編，意思是 `main.c` 的行數超過預期，同理其他 `.c`檔案。關於什麼是預期的行數，可以參考[ How Big Should main() Be, in C? [closed] - StackOverflow](https://stackoverflow.com/a/1967469/10172299) 
2.  `include directive`： 參考維基百科，由於沒有找到合適的翻譯，保留原文。
