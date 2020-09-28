# [14] 30 天從 Swift 學會 Objective-C：Objective-C 物件的多型
多型包含了型別的共用、函式的共用、概念的共用。

![](https://images.unsplash.com/photo-1531545514256-b1400bc00f31?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1567&q=80)

Photo by [@mimithian](https://unsplash.com/@mimithian) on [Unsplash](https://unsplash.com/photos/vdXMSiX-n6M)


## Swift 的多型


我們知道 Swift 的多型可以透過型別抹除來使用多型：

```swift
// Swift

class A {}
class B: A{}

let o:A = B()
```


## Objective-C 編譯期沒有辦法阻擋型別錯誤

在 Objective-C 由於是訊息傳遞的關係，而所有型別與指令只要在 header 出現就可以使用，也就是說下面的程式碼只要 pointer 對齊，就可以編譯與執行，但是會顯示警告。
```objectivec
NSArray* a = @1; // 1
NSLog(@"%@",a);
```
> Incompatible pointer types initializing 'NSArray *' with an expression of type 'NSNumber *'
>> 因為這樣的關係，程式都應該注意所有警告。

因此，Swift 的型別抹除基本上在 Objective-C 是沒有什麼用處的，唯一的用處是可以參考編譯警告 `Incompatible pointer`。然而編譯警告並不是說出現就出現的。

## Objective-C id 與 instancetype

在 Swift 有所謂 AnyObject，其對應 Objective-C 的是 id，我們可以使用 id 作為 參數與回傳型別。

```objectivec
// Objective-C
- (id) getSomething:(id) form;
```
然而由於是任意型別的關係，編譯器並沒有辦法透過語法知道對應的資料。而 instancetype 則可以讓編譯器有足夠的資訊推斷後續的指令是不是合法的。這部分請參考 [Would it be beneficial to begin using instancetype instead of id? - StackOverflow
](https://stackoverflow.com/a/8976920/10172299)
>  推薦 wwdc 2013： [404 Advances in Objective-C]( https://developer.apple.com/videos/play/wwdc2013/404/)，相信會有很不錯的收穫。

## 簡單測驗
1. 如果你要跟程式新手解釋多型，你會如何解釋。

