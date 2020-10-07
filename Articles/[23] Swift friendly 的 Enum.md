# [23] 30 天從 Swift 學會 Objective-C：Swift friendly 的 Enum


![](https://i.imgur.com/u03Xwwy.png)

## Objective-C Enum 與 <Foundation/Foundaion.h>

![](https://i.imgur.com/5wZneSE.png)
![](https://i.imgur.com/wIREfoA.png)

Bitmasks
```objectivec=
typedef NS_OPTIONS(NSUInteger, <#MyEnum#>) {
    <#MyEnumValueA#> = 1 << 0,
    <#MyEnumValueB#> = 1 << 1,
    <#MyEnumValueC#> = 1 << 2,
};

```

## 簡單測驗
1. Swift 有所謂的 Associate value，請問是什麼？
2. Swift 有 indirect value，請問是什麼？
3. [進階] 你知道 C 語言的 Bit-filed 嗎？這個型別有機會讓 Swift 對接嗎？
