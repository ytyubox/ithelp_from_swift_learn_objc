# [11] 30 天從 Swift 學會 Objective-C：Objective-C 物件的編寫

物件導向在人類思想上是自然而然的思考方式，而程式語言透過演進的方式，漸漸的視狀態為獨一無二的物件。

![](https://images.unsplash.com/photo-1493243391685-aa64043dfd41?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1580&q=80)

Photo by [@alex_andrews](https://unsplash.com/@alex_andrews) on [Unsplash](https://unsplash.com/photos/bbFeL3YNnl8)











## 物件導向開始之前

我們都知道，物件導向有 3 大特性，繼承、封裝、多型。這 3 大特性的目的很大一部分是為了提高程式碼的重用率：
透過繼承，我們可以共用型別；
透過封裝，可以將內部重覆的程式碼重用；
透過多型，可以避免因為型別不同而需要重複編寫邏輯的程式。

然而仔細想想，我們如果沒有物件導向的語法，是否也可以做到相同的程式碼重用？這個問題，我推薦 [你所不知道的 C 語言：物件導向程式設計篇 - jserv](https://hackmd.io/@sysprog/c-oop) 系列文，很值得花時間閱讀。

> 物件導向是一種態度。 - jserv

## Objective-C Class 宣告
首先，我們必須認知一點，`struct` 是 Data， `struct *` 是 Object。這很重要，因為這定義的物件導向很基本的概念：

> Object 集合了 `狀態` 與 `行為`，將其聚合在一起、集合在一起、Bundle 在一起。

### 定義一個物件

```Objectivec
// Objective-C
/* Object.h */
#import <Foundation/Foundation.h>
@interface Rectangle: NSObject {
    int length;
    @public 
    int width;
}

@end
```

在這裏，我們定義了一個型別 `Rectangle`，由於語法的關係，所有的型別都必須有 Super class，而 Foundation 內設計了 NSObject 作為 plian class，可以作為 所有 class 的 template class。

這個 `Rectangle` 有兩個 Property，由於我們強制宣告了 width `@public`，所以我們可以使用 `->`的方式直接存取 width。

```objectivec
// Objective-C
/* main.c */
Rectangle* rect = [Rectangle alloc]; // 來自 NSObject 的程式碼
int width = rect->width; 
int length = rect->length;  // 🔴 Instance variable 'length' is protected
```

### @property 語法糖

```Objectivec
// Objective-C
/* Object.h */
@interface Rectangle : NSObject

@property int length;
@property int width;

@end
```

`@property` 是很有趣的語法，透過這個語法，我們的 client 的呼叫必須要改寫。

 ```objectivec
// Objective-C
/* main.c */
Rectangle* rect = [Rectangle alloc]; // 來自 NSObject 的程式碼
int width = rect.width; 
int alsoWidth = [rect width]; 
// rect->width; 變成不合法的呼叫 
// 🔴 Property 'width' found on object of type 'Rectangle *'; did you mean to access it with the "." operator?
```
> 關於 `語法糖`，我的定義是不用的話，可以用其他語法達到同樣的效果。

當我們使用了 `@property` 之後，Objective-C 會自動幫你編寫 setter 與 getter。
```Objectivec
// Objective-C
/* Object.h */
@interface Rectangle : NSObject

@property int length;
@property int width;

-(void)setLength(int)length;
-(int)length;
-(void)setWidth(int)width;
-(int)width;

@end
```



然而在實作檔(`.m`)，我們實際上取用 `self.width`，會是取用自動產生的程式碼。
```objectivec
// Objective-C
/* Rectangle.m */
@implementation Rectangle
-(void)setLength:(int)length { // 🔴 Thread 1: EXC_BAD_ACCESS (code=2, address=0x7ffeef3ffffc)
    self.length = length; 
}
@end
```
這是一個**無限迴圈**，原因是 `self.length =` 是一個語法糖，他代表的就是 `-(void)setLength:(int)length` 這個函式。實際上的語法是：

```objectivec
// Objective-C
/* Rectangle.m */
@implementation Rectangle
-(void)setLength:(int)length { // 🔴 Thread 1: EXC_BAD_ACCESS (code=2, address=0x7ffeef3ffffc)
    self->_length = length; 
}
@end
```
> 是不是不知道我再說什麼？ 我建議你實際編寫一遍，會比較能夠理解。

## Objective C 沒有 Nested class 與 `@class`

在 Objective-C 是沒有辦法想 Swift 做到一下的定義：
```swift
// Swift
class Rectangle {
    class Square {
    
    }
}
```
推薦作法是不要用 nested class，但是如果真的要用，建議使用 Prefix處理
```objectivec=
// Objective-C
/* Rectangle.h */ 
@class RectangleSquare; // 前置宣告 class 的語法，但是不推薦
@interface Rectangle : NSObject  {
}

@property (nonatomic) int length;
@property int width;
-(RectangleSquare*)innerSquare;
-(RectangleSquare*)outterSquare;

@end

@interface RectangleSquare : NSObject

@end
```
其中，由於 Objective-C 與 C 語言一樣會從上而下理解宣告，我們可以使用前置宣告的方式處理，但是不推薦，建議使用 Header。

## Swift 的 static member 與 object member
在 Swift 中，我們可以使用 `static` 區分 定義的區別，而 Objective-C 同樣也可以。


```Objectivec
// Objective-C
@interface Rectangle : NSObject

@property int length;
@property int width;
+(Rectangle)prototype; // static member
-(int)area;            // object member
@end
```

如上，舉凡 `+` 開頭，是 static member；`-` 則是 object member;

## 簡單測驗
1. Objective-C 與 Swift 一樣有 [Function Argument Labels and Parameter Names](https://docs.swift.org/swift-book/LanguageGuide/Functions.html#ID166)，請問文內相關語法在 Objective-C 如何實作？
2. 請將文末的 `+(Rectangle) prototype` 作為一個 singleton 實作在 Rectangle.h 內。
