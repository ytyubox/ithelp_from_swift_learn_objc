# [22] 30 天從 Swift 學會 Objective-C：Swift friendly 的基本型別

在 Swift 的程式語言設計初衷裡，與 Objective-C 相容是一個非常重視的設計概念，我們將了解 Objective-C 中，有什麼是可以不需要修正就可以直接被 Swift 使用。

![](https://images.unsplash.com/photo-1582089319119-a788d9f9d976?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80)

Photo by [@daveballew](https://unsplash.com/@daveballew) on [Unsplash](https://unsplash.com/photos/IotATrNf1aA)


## iOS 7 與 macOS 10.9

Swift 在 2014 年 6 月的 WWDC 開發者大會上發布了，Swift 在發表的時候用的介紹詞是這樣的：
> Programming language from Objective-C but without the C.

[![](https://i.imgur.com/N7EMUyA.png)](https://www.youtube.com/watch?v=MO7Ta0DvEWA&ab_channel=theunofficialAppleKeynoteschannel)

在當時，是非常轟動的事情，C 語言在 Objective-C 佔有很大的地位，而 Swift 吸取了 Objective-C 物件導向的經驗，去除了 C 語言容易出錯的部分，這在當時是難以想像的。

> 在 [Swift (programming language)： Comparisons to other languages - Wikipedia](https://en.wikipedia.org/wiki/Swift_(programming_language)#Comparisons_to_other_languages) 這個章節中，詳細解釋了 Swift 與 C 語言/Objective-C 的異同，十分有趣！

## Swift 中與 C 語言相似的型別

在電腦科學中，關於資料的表達有一定的理論，而 Swift 沿用 C 語言的方式，使得 Swift 與 C 語言的基本型別有很大程度的共用。

我們知道 Swift 有 Int, Int8, Int16... 型別，而 C 語言則是 long, char, short...型別。



| Swift | Objective |
| -------- | -------- |
| Int8     | char <br> signed char|
| UInt8    | unsigned char <br>short|
| Int16    | short int<br>signed short<br>signed short int|
|UInt16 | unsigned short<br>unsigned short int|
| Int32 |int<br>signed<br>signed int|
|UInt32|unsigned<br>unsigned int|
|Int/Int64|long<br>long int<br>signed long<br>signed long int	|
|UInt/Int64|unsigned long<br>unsigned long int	|
|Int|long long<br>long long int<br>signed long long<br>signed long long int|
|UInt/UInt64|unsigned long long<br>unsigned long long int|
|Float|float	|
|Double|double	|
|Float80|long double|

> long double 有特別的定義，跟 IEEE 有關，建議閱讀 [long double - Wikipedia](https://en.wikipedia.org/wiki/Long_double)

## 簡單測驗
1. NSInteger 在 Objective-C 是一個封裝，這個型別在 Swift 直接對應的是什麼？
2. UInt 在 Swift 的使用率很低，有很多認為與其使用 UInt 限制，不如使用 precondition，你覺得呢？
3. [進階] 請研究 C 語言與 Objective-C 的 overflow 如何控制，與 Swift 的 Foundation 有什麼區別
