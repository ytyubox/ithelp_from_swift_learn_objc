# [23] 30 天從 Swift 學會 Objective-C：Swift friendly 的 Enum

Enum 是 Swift 開發者覺得很友善的型別，Objective-C 的程式碼如果可以提供 Enum，將會得到很多好朋友。


![](https://images.unsplash.com/photo-1560242252-9d4dd1b8337c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1342&q=80)
Photo by [@brett_jordan](https://unsplash.com/@brett_jordan) on [Unsplash](https://unsplash.com/photos/dwlAdWdSieI)


## C 語言的 Enum 與 Union

在 C 語言中，有 Struct/Enum/Union 這三個資料聚合的方式，而其中 Enum 是一種 `int` 名詞的定義，所有 Enum 的 case 會有一定的 int 數值。

```c
// C
enum direction {
    North,
    South,
    East,
    West
};

enum direction d = North; 
```

然而 enum 在 C 語言只有數值別名的概念，其中 North 為 0 的別名，South 為 1 的別名，以此類推。

也就是說以下的程式碼是可以編譯的：
```c
enum direction d6 = 6; 
```
而 這樣的 enum 在 Swift interface 可以參考下圖(包含進階的 `union`)。
![](https://i.imgur.com/u03Xwwy.png)

## Objective-C Enum 與 <Foundation/Foundaion.h>

![](https://i.imgur.com/wIREfoA.png)
Objective-C 有提供 NS_ENUM 作為方便 Swift 的對接，而這個 功能必須 `#import "<Foundation/Foundtion.h>"` 可以看到在之前的ENUM 編寫是沒有效果的。
`NS_CLOSE_ENUM`，是 Objective-C 針對前一個段落中 C 語言沒有辦法阻擋宣告 enum 集合外的值，其會警告 enum 的使用必定在集合內。而 NS_ENUM 在 Swift 的對接會在 switch case 出現 `@unkown default`。

### 程式設計的 Bitmasks 與 Swift OptionSet
上面範例中 `NS_OPTIONS` 是 Objective-C 針對 Bitmasks 的拓展。

> 在電腦科學中，Bit operation 是很常見的事情，而 Bitmasks 是一個有趣的技巧。關於 Bitmasks 我印象最深刻的就是 linux 的 chmod 參數。詳細請參考 [chmod - Wikipedia](https://en.wikipedia.org/wiki/Chmod)


```objectivec=
typedef NS_OPTIONS(NSInteger, MOD) {
    MODRead = 1 << 0,
    MODWrite = 1 << 1,
    MODExecute = 1 << 2,
};
```

## 簡單測驗
1. Swift 的 enum 可以改寫為static var，例如 `struct HTTPMethod {let rawValue:String}`，請問當使用這樣的方式時，switch case 會有影響嗎？
2. Swift 的 @frozen 型別宣告是什麼意思？
3. [進階] 你知道 C 語言的 Bit-filed 嗎？這個型別有機會讓 Swift 對接嗎？
