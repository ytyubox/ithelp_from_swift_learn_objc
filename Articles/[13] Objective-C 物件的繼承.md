# [13] 30 天從 Swift 學會 Objective-C：Objective-C 物件的繼承 Inheritance, Protocol

繼承，是資料的延伸、是行為的改寫、是框架的客製化。在程式語言中，interface 可以是抽象的化身，也可以是物件的標籤。

![](https://images.unsplash.com/photo-1570056883545-5d7508d08de5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80)

Photo by [@oteb](https://unsplash.com/@oteb) on [Unsplash](https://unsplash.com/photos/ySqu4QK37rQ)

## 說到繼承，我想先建立一個故事

在物件導向中，簡單的情境可以透過很直覺的手法化成資料結構，然而隨著時間演進情境越來越複雜，資料結構往往會開始跟著特例而越來越複雜。我們現在要處理集合論的抽象編寫[註 1]。

為了方便閱讀，我們使用 [各式各樣的數 - wiki](https://zh.wikipedia.org/wiki/%E6%95%B0)中的實數集合，並將所有的數字視為獨立的 Object。我們可以知道以下觀念：
> ![](https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/Number-systems.svg/440px-Number-systems.svg.png)
> 實數（ℝ）包括有理數（ℚ），其中包括整數（ℤ），其中包括自然數（ℕ）
1. 實數（ℝ）有子集合：有理數（ℚ）
2. 有理數（ℚ）有子集合：整數（ℤ）
3. 整數（ℤ）有子集合：自然數（ℕ）

套用 Swift 的物件編寫方式，我們可以得到下面的程式碼：
```swift
// Swift
class ℝ {}
class ℚ: ℝ {}
class ℤ: ℚ {}
class ℕ: ℤ {}
```

基於這樣的故事，我們繼續來看看。

## C 語言也有繼承，是真的

在 [Object-Oriented Programming With ANSI-C](https://www.cs.rit.edu/~ats/books/ooc.pdf) 一書中，第 4 章節有提到，強烈建議讀者對[這個 StackoverFlow 問題](https://stackoverflow.com/a/415536/10172299) 有興趣可以看看。




## Objective-C 繼承

```objectivec
// Objectiv-C

@interface R : NSObject
- (int) decimal;
@end

@interface Q : R
@end

@interface Z : Q
@end

@interface N : Z
@end
```

而在 Objective-C 的因為是屬於響應與否的程式設計，不像 Swift 必須要型別確定才可以順利執行。也由於這個關係，Objective-C 認為對 Object 呼叫不可響應的指令，是屬於 Design fault(程式設計錯誤)，是需要我們自己調適的。

```objectivec
// Objective-C

R* r = [R alloc];
Q* q = [Q alloc];
Z* z = [Z alloc];
N* n = [N alloc];
[n isKindOfClass:   [R class]];             // YES
[n isMemberOfClass: [R class]];             // NO
[n respondsToSelector: @selector(decimal)]; // YES
```
## Swift 的 Protocol Oriented Programming (POP)
在 Swift 中，Protocol 可以是完全沒有內容的，我們可以將其想像為標籤，不改變物件的內容與實作，單純給予型別。

```swift
// Swift
protocol VIP {}
extension ℕ: VIP {}

let r: ℝ = ℕ()
r is VIP             // true
```

## Objective-C Protocol 必須要改寫 Header 檔


為了實現 Swift 的 `class ℕ: VIP` 我們必須要改寫 `@interface N`

```diff
// Objective-C
/* N.h */ 
- @interface N : Z
+ @interface N : Z <VIP>
@end
```

而可以使用 `conformsToProtocol` 實現 `is`
```Objectivec

// Objective-C
N* n = [N alloc];

[n conformsToProtocol: @protocol(VIP)]; // true
```

或是，你可以使用 override 的方式，不過我不喜歡這個方式
```objectivec
// Objective-C
/* N.m */

@implementation N
- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    return aProtocol == @protocol(VIP);
}
@end
```


## 簡單測驗
1. 如果你要向程式新手解釋繼承，你會怎麼解釋？
