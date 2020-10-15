# [30] 30 天從 Swift 學會 Objective-C：30 天內那些我不懂的部分

這個 30 天我們理解了 C 語言與 Objective-C，然而我其實有不少事情是沒有看懂的，鐵人賽第 30 天是鐵人的終點，卻不是學習的最後一天。

![](https://images.unsplash.com/photo-1583778957124-763fd4826122?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80)

Photo by [@harrisonhargrave](https://unsplash.com/@harrisonhargrave) on [Unsplash](https://unsplash.com/photos/Tmev9UoX00M)

## 我不懂的部分

以下是我沒有理解清楚而在系列文章中沒有特別解釋的部分，我寫到的部分並不是所有的問題，建議讀者持續閱讀與學習。

### C 語言中我不懂的部分

C 語言有一些部分是我在鐵人賽期間看不懂的事情。
1. Memory layout。
2. preprocessor 的紀律，什麼可以用，什麼應該有 `extern` 變數。
3. C 語言編譯器 `clang` 的優化方式。
4. C 語言編譯器縮短編譯時間的練習。
5. C 語言的標準規格書 C99 的閱讀。
6. C 語言對於 object 名詞的定義。(參考 你所不知道的 C 語言:規格書 (PDF) 搜尋 “object”，共出現 735 處 [註 1])
7. C 語言特殊名詞的英文，如 `#include` 不是念 Number sign、hashtag；`&` 不是念 `and`。
8. 記不住 `int*`、`int const *`、`int * const`、`int const * const`，應該是沒有理解 `const int * == int const *`。[註 2]
9. GDB： C 語言的 Debugger(或是 LLDB，有使用過 CLI 介面，但是每次用每次查，我猜是因為 Xcode 用習慣的關係)。
10. 想看完 [「你所不知道的 C 語言」系列講座](https://hackmd.io/@sysprog/c-prog/%2F%40sysprog%2Fc-programming)。
11. 在 pointer 操作如何考慮 Endian [註 3]。


### Objective-C 中我不懂的部分

1. 除了 main 使用 `@autoreleasepool`
2. 不知道如何切換ARC 到 MRC，並了解 MRC 的痛點。
3. 不懂 C++，沒有辦法練習 Objective-C++(嘗試過寫 hello world C++，但是沒有練習到官方解釋的限制)。
4. 不知道如何用 Swift 介紹 `@try`、`@catch`、`@finially`。

### Swift friendly 中我不懂的部分

1. 不知道如何將`@try`、`@catch`、`@finially`作為Swift frinedly。
2. 不知道如何編譯 iOS 的 C 語言靜態函式庫(我原本很天真的用 `clang` + `ar`，但是沒有那麼簡單)。
3. 不知道 modulemap 的語法與使用方式，在引用靜態函式庫時遇到看不懂的錯誤。
4. 不知道如何解釋 swift bridge header 的 recursive include 編譯錯誤 [註 4]。

以上是我不理解與不理解的部分，未來有理解或是有看到不錯的文章，會以留言的方式做補充。

## 註記
1. 你所不知道的 C 語言： https://hackmd.io/@sysprog/c-standards?type=view#ISOIEC-9899-%E7%B0%A1%E7%A8%B1-%E2%80%9CC99%E2%80%9D
2. Clockwise_Spiral Rule - David Anderson 1993： http://c-faq.com/decl/spiral.anderson.html
3. Endianness - Wikipedia：https://en.wikipedia.org/wiki/Endianness
4. 在 Objective-C 的 framework 內使用 Swift bridge header 時，不可以在 umbrella header 內引用 Swift bridge header，否則無法編譯，注意這個錯誤沒有容易理解的錯誤提示。

## 後記

感謝讀者們的閱讀，與 IT 幫提供這次的鐵人賽機會。在 2020 年 COVID-19 肆虐的這個年頭，有許多事情有了全新的進行方式，而這次鐵人賽期間雖然有中秋連假與國慶連假(10/1~10/4, 10/9~10/10)，中間邊放假休息邊掛念鐵人賽的完賽機率，真的感覺到壓力的影響，也因為連假與壓力，體重有不少的提升，這真的是鐵人們在完賽後需要面對的另一個課題。
關於在 Day 1 發下的豪語：
> 透過在 Swift 開發經驗，了解 Objective-C 的語言文法、中心思想及適應 Swift 的方法。
希望閱讀完系列文章的讀者能夠告訴我，這 30 天是否可以滿足你擁有這樣能力。

特別感謝系列文章中有引用到的非官方文章、StackOverflow 上解答的人、為 Open source 留心的人。
