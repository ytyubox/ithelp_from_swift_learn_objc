# [07] 30 天從 Swift 學會 Objective-C：Objective-C 的基本 C 語言 library 使用

在任何產業中，都會有工具重複使用的機制，當一個概念時常需要被使用的時候，就是一個工具的誕生。透過使用過去的經驗，我們可以站在巨人的肩膀上，完成更加困難的挑戰。

![](https://images.unsplash.com/photo-1495741545814-2d7f4d75ea09?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1654&q=80)

Photo by [@jzamora](https://unsplash.com/@jzamora) on [Unsplash](https://unsplash.com/photos/GWOTvo3qq7U)

## Swift  的 import
在 swift 語言，工具是以 Module 的形式存在，而引用 Module 的方式是使用 `import` 的方式，以 Foundation 為例，詳細 import 的 方式請參閱 [Swift.org - grammar: import declaration](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#grammar_import-declaration)

值得注意的是 Swift 具有 Namespace 的感念，也就是說 可以區別在不同 Module 的同名函式。

```swift
// Swift
import UIKit
class UIView { // same name of UIKit.UIView
	/* ... */
}
let myUIView: UIView = ...
let uikitUIView: UIKit.UIView = ...
```
然而 Objective-C 是沒有這個 Namespace 的概念的。

### Foundation 與 CoreFoundation 是不一樣的
在 Swift 的函式庫中，我們最常引用的是 Foundation，然而 Swift 有 CoreFoundation (CF) 作為 C 語言的相關函式庫，關於 CoreFoundation 的部分不會講解，詳閱 [CoreFoundation - wiki](https://en.wikipedia.org/wiki/Core_Foundation)

## Header 就是介面 (interface)

在程式設計中，工具的概念時常用介面來表示，根據 [Include directive - wiki](https://en.wikipedia.org/wiki/Include_directive):

> Header files often used to define the physical layout of program data, pieces of procedural code and/or forward declarations while promoting encapsulation and the reuse of code.
> 標頭檔(header file, `.h`) 通常用於定義子程式的物理架構，片段的程式碼碼與預先聲明，並同時加強程式碼的封裝和覆用。

就如同 Swift 的 Protocol 一樣，Header 可以做到藍圖 (Blueprint)的概念，關於 Swift 的 `protocol` 詳閱 [Swift.org - Protocol](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html)

而相對與沒有物件導向的 C 語言，Header file 可以視為 Swift 的 Access control中的 `pubilc` 與 `private`，關於 Swift 的 Access Control， 詳閱 [Swift.org: Access Control](https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html)

在開始之前，我們先簡單說明 Public 與 Private 在 C 語言的概念。

| header (ITHelpMath.h)  | includer (main.c) | implementor (ITHelpMath.c) |
| :---------------------:| :---------------: | :------------------------: |
|   Public 		         | private  		 | public / private 		  |

在 C 語言中，header file 可以定義也可以實作，但是建議只有實作。

```C
// C 
/* ITHelpMath.h */
#ifndef __ITHELPMATH__
#define __ITHELPMATH__
extern double PI;

short IMAdd(short l, short r);
#endif
```

```c
// C 
/* ITHelpMath.c */
// private
short _addOverflow(short* result, short a, short b)  
{  
    *result = a + b;  
    if(a > 0 && b > 0 && *result < 0)  
        return -1;  
    if(a < 0 && b < 0 && *result > 0)  
        return -1;  
    return 0;  
}  
// public 
double PI = 3.1415926;

short IMAdd(short l, short r) {
	short sum = 0;
	return _addOverflow(&sum, l, r);
}
```

我們定義的兩個檔案，`ITHelpMath.h` 與 `ITHelpMath.c` 這兩個檔案必須要同名，副檔名為 h 與 c 的兩兩成對。其中 header 定義了兩個name tag： `PI` 與 `IMAdd(_,_)`，這兩個可以視為公開介面(public interface)。相對的 `_addOverflow(_,_,_)` 因為沒有在 header 檔內宣告，因此是屬於非公開介面(私有介面 private)。
在 main.c 中，我們可以使用 `#include "IThelpMath.h"` 來引用這個工具。

```c
// C
/* main.c */
#include "IThelpMath.h"
int main () {
	short sum = IMAdd(100, 100);
	printf("sum is %d\n", sum); // sum is 0; because short is range between -128...127
	return EXIT_SUCCESS;
}
```


## C 語言的內建 Library 與第三方 Library
在 C 語言中，引用 header 有兩種方式，分別如下
1. `#include <HEADER.h>` 
2. `#include "HEADER.h"`

這兩種方式在 StackOverflow 已經有完成的討論，詳閱 [What is the difference between #include <filename> and #include “filename”?](https://stackoverflow.com/questions/21593/what-is-the-difference-between-include-filename-and-include-filename)


## Objective-C 的 `import <FRAMEWORK/FRAMEWORK.h>` 


最後但並非最不重要的(Last but not least)，Objective-C 承襲了 C 語言的 Header 方式，可以直接使用 `include <CHEADER.h>` 的方式直接引用 C 語言的 header，更進一步的可以使用同樣的方式引用 Objective-C 的檔案 (`.m` 檔)。由於 C 語言有所謂的 Umbrella header(註 1)，在 Objective-C 引用系統 header 時會有稍微不同，以 Foundation 為例：

```objectivec
// Objective-C
#include <Foundation/Foundation.h>  // include everything under Foundation
#include <Foundation/NSObject.h>    // include only NSObject in Foundation
```

### [進階] 關於 `#include` 與 `#import`
而如果讀者有使用 Xcode 的 Cocoa class file template 的話，會看到 `#import 與 @import`，說明如下：
1. `#import`, `@import` 是 Objective-C 語言的特性，C 語言沒有
2. `#import` 會避免 recursive include, 詳閱 [SO: What is the difference between #import and #include in Objective-C?
](https://stackoverflow.com/a/439691/10172299)
3. `@import` 會在後續的 Objective-C 的 framework 提到，前情提要： [WWDC 2013 - What's New in Cocoa](https://developer.apple.com/videos/play/wwdc2013/205/)、[WWDC 2013 - Advances in Objective-C](https://developer.apple.com/videos/play/wwdc2013/404/)

## 簡單測驗
1. 說明 `extern double PI` 的宣告語意是什麼
1. 說明 Objective-C 在使用 C 語言的標準函式庫的語法是不是完全一模一樣的
1. [進階] 說明 static、shared與dynamically loaded 這些 Library 有什麼區別
