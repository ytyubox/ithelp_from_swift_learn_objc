# [03] 30 天從 Swift 學會 Objective-C：Objective-C 的基本 C 語言型別

在小孩學邏輯階段的時候，第一次知道 `1 + 1 = 2` 的時候，我們就有型別的觀念。這個世界的很多資訊是由許多基礎型別所建立，像是數字、文字、真的與假的。Swift 語言中有很強烈的型別系統，開發時需要很在意型別的吻合。而 Objective-C 承襲了 C 語言的型別系統，雖然沒有 Swift 的嚴格限制，但是仍然有一定的區分，且 Objective-C 更自訂了許多 NSObject，使得基本型別比 Swift 更來的多樣。

![](https://i.imgur.com/HSQ1f5j.jpg)

Picture by Mirko Blicke @ https://unsplash.com/photos/V_y81v_lI4k




















## 數字，一切都是數字

在 C 語言中，所有型別都是數字，也就是說之所以會有型別的不同，實際上是我們看數字的角度不同。其中最簡單的莫過於 Boolean，數字 `1` 是真，`0` 是假。而我們可以使用 `sizeof(bool)`，來查看 Boolean 的使用二元組數量。

```C

// C
sizeof(bool)  	  // 取得 bool 的使用二元組數量
sizeof(char)  	  // 取得 char 的使用二元組數量
sizeof(short)     // 取得 short 的使用二元組數量
sizeof(int)       // 取得 int 的使用二元組數量
sizeof(long int)  // 取得 long int 的使用二元組數量
sizeof(float)     // 取得 float 的使用二元組數量
sizeof(double)    // 取得 double 的使用二元組數量

// 實際數值與執行程式的裝置處理器而異
```

我們都知道 `3 / 2` 的答案是 `1.5`， 但是如果在 Swift 與 Objective-C 語言中，由於型別系統的關係，會導致程式結果是 `1`，我們可以用 type convention 來 指定使用 float 的運算。

```C
// C
(float) 3 / (float) 2 // 1.5
```
如此一來，就可以完整的使用型別系統了。

## 字串轉數字

在 C 語言中，字串是由一系列字元組合而成的，仔細想想這其實是很有哲理的，當你在看這一段文字的時候，其實會發現文字一個一個組合起來成為句子。而由於 C 語言的字串並不是一個基礎型別，如果要轉換字串成為 int 或是 float，就必須由一定的邏輯轉換。我們可以用 `<stdlib.h>` 內的 `strtol` （[manual](https://linux.die.net/man/3/strtol)） 將字串轉換成 long int 型別。

```Objective-C
// Objective-C
#include <stdlib.h>
char     strSource[1] = "1";
char*   strErrorIndicator = NULL;
int      inputBase = 10;
long int num = strtol(strSource, strErrorIndicator, inputBase);
```

以下是在 macOS 10.15 `usr/include/stdlib.h` 找到的字串轉換函式：
|output|function|input|
|:-|:-|:-|
| `float`                |`strtof`   |`(const char *, char **)`|
| `double`        		 |`strtod`   |`(const char *, char **)`|
| `long double`   		 |`strtold`  |`(const char *, char **)`|
| `long`          		 |`strtol`   |`(const char *, char **, int)`|
| `long long`            |`strtoll`  |`(const char *, char **, int)`|
| `unsigned long`        |`strtoul`  |`(const char *, char **, int)`|
| `unsigned long long`   |`strtoull` |`(const char *, char **, int)`|
| `long long`            |`strtoq`   |`(const char *, char **, int)`|
| `unsigned long long`   |`strtouq`  |`(const char *, char **, int)`|

關於 strErrorIndicator 的用法，請參考 [Stack Overflow: Correct usage of `strtol`](https://stackoverflow.com/questions/14176123/correct-usage-of-strtol)


## 進階的型別轉變

型別所使用的二元組數量代表這個型別的可以容許的數值數量，目前已有相關的世界標準如整數的二補數法，小數的 IEEE 二進位浮點數算術標準（包含半/單/雙精度）。你是否有困惑為什麼學習基礎型別要理解二元組解讀的標準，這是因為在 Objective-C 承襲了 C 語言的 Pointer 開放特性。以下的 Swift 範例是想要以 binary 的表達式建立 Float 變數。

```swift
// Swift
Float(bitPattern: UInt32(0x3f9d70a4))
```

![](https://i.imgur.com/l4LBYvl.png)

IEEE-754 Floating Point Converter @ https://www.h-schmidt.net/FloatConverter/IEEE754.html

而在 C 語言中，可以使用

```C
// C
long   l = 0x3f9d70a4;
long*  lAddress = &l;
float* castingToFloat = (float*) lAddress;
float  f = *castingToFloat;  // f: 1.230000
// 等價於 `f = *((float*)&l);`
```

由於 Objective-C 的 NSInteger 是 `typedef long NSInteger`，我們也可以用同樣的方式來處理。

```Objective-C
//Objective-C
NSInteger i = 0x3f9d70a4;
float f = *((float *) &i);
```


## Objective-C 擴張的只有 NSInteger

接下來，也就是最後，來說說 NSInteger。NSInteger 在 `usr/include/objc/NSObjCRuntime.h`內，明確的定義的 NSInteger 是一個 `typedef`



```C
// usr/include/objc/NSObjCRuntime.h
#if __LP64__ || 0 || NS_BUILD_32_LIKE_64
    typedef long NSInteger;
    typedef unsigned long NSUInteger;
#else
    typedef int NSInteger;
    typedef unsigned int NSUInteger;
#endif
```

如上面所表示的，`NSObjCRuntime.h` 內檢查了執行機器的處理器，依照 32 / 64 位元分別對應到 int / long。這確保在這台機器上編譯成功的程式執行檔，NSInteger 會轉換成指定的 C 型別。

如果你想知道為什麼 Objective-C 只有真對 int / long 實現動態型別，你可以參考這篇 [Stack Overflow: Do NSDouble, NSFloat, or other types than NSInteger exist?](https://stackoverflow.com/a/6703067/10172299)


## 簡單測驗：

1. 請說明 Objective-C 語言的基本型別有那些？
2. 請說明 Objective-C 語言中的 Stirng 轉換成基本型別的方式有哪些？
3. [進階] 請說明  `*((float*) ptr)` 的意思。
