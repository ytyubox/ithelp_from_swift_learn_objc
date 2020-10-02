# [19] 30 天從 Swift 學會 Objective-C：Objective-C 的特殊  Block a.k.a. Lambda

三國演義中，有那麼一段故事： 
> 孔明曰：「吾已定下三條計策，非子龍不可行也。」遂喚趙雲近前，附耳言曰：「汝保主公入吳，當領此三個錦囊。囊中有三條妙計，依次而行。」即將三個錦囊，與雲貼肉收藏。 <三國演義．第五四回>

這 3 個錦囊對與趙雲(client)，是完全不知道內容是什麼的，這與程式設計的函式指標(Function pointer)有異曲同工之妙！


![](https://images.unsplash.com/photo-1589621317313-38f7fbf010cd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80)

Photo by [@markuswinkler](https://unsplash.com/@markuswinkler) on [Unsplash](https://unsplash.com/photos/GlcLJYx4KVI)

## Lambda 匿名函式

首先，請確認你對於以下的名詞至少有一個是理解的：
1. Swift closure
2. C function pointer
3. Anonymous function
4. Lambda expression

雖然這 4 個有些微的差異，不過都明確的表示可以將 function 轉變為變數。

> 在 [Object-Oriented Programming With ANSI-C： Chapter 2](https://www.cs.rit.edu/~ats/books/ooc.pdf) 有完整介紹如何使用 function pointer 使 function 成為 struct 的 member。

## Objective-C 的 Block 

Block 的宣告語法與 C 語言的 function pointer 想法非常接近，但是還是不一樣。
在 C 語言我們使用
```C
// C
RETURN* FUNCTIONNAME(INPUT1, INPUT2);
```
而 Objective-C 則是
```ObjectiveC
//Objective-C
RETURN (^ FUNCTIONNAME)(INPUT1, INPUT2);
```
相較於 Swift 的則是
```Swift
// Swift
FUTCTIONNAME: (INPUT1, INPUT2) -> RETURN
```

## Block 的 capture object

在 Swift 編寫 closure的時候，我們可以使用 capture list 作為引用物件的記憶體管理。

```swift
// Swift
let (object1, object2, object3) = (NSObject(),NSObject(),NSObject())
let aClosure:() -> Void = { [object1, weak object2, unowned object3] in

}
```

而在 Objective-C 則是使用了 `__weak` 作為 ARC 的記憶體管理。

```Objectivec
// Objective-C

NSObject* object = [[NSObject alloc] init];
__weak NSObject* weakObject = object;
void ^(aBlock) = ^{
    NSLog(@"%@",weakObject);
}
```

關於 Objective-C 的 `__weak` 與 `__unsafe_unretained` 與 Swift 的 `weak` 與 `unowned(safe)/ unowned(unsafe)`，可以參考 [Unowned or Weak_ Lifetime and Performance - uraimo.com](https://www.uraimo.com/2016/10/27/unowned-or-weak-lifetime-and-performance/)。


## 簡單測驗
1. 如果你要向程式新手解釋 Block，你會如何解釋？
2. 使用 Block/Closure 的目的都可以透過 Delegation 達成，你認同嗎？
3. [進階] 請說明使用 Block 的時機。
