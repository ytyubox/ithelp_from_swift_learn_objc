#  [06] 30 天從 Swift 學會 Objective-C：Objective-C 的基本 C 語言 控制流程 Control flow

在指令式程式語言中，if else 佔有很重要的地位，在很多語言都可以看到。透過 if else ，我們可以將選擇的智慧帶給機器，使程式碼成為智慧的分身。而這樣的智慧我們可以用控制流程(Control flow)來稱呼，控制流程包含了 if else statements、switch、while loops、for loops、goto。

![](https://images.unsplash.com/photo-1532188363366-3a1b2ac4a338?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80)

by @_louisreed on [unsplash.com](https://unsplash.com/photos/zDxlNcdUzxk)


## Swift 的 Control flow

在 Swift 的 Control flow 在 [Swift.org - Control Flow](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html) 有明確的介紹，在此僅提到與  Objective-C 會有相異的部分。

Swift 中，有一個控制的指令是 Objective-C 沒有的，就是 `fallthrough`。`fallthrogh` 的作用域只有在 `switch` 裡面，Swift 的 `switch` 彼此的 case 是不會自動干擾的，而 `fallthrogh` 則是主動強調 case 延續至次一個的 case：
```swift
// Swift
let aNumber:Int = ...
switch true {
    case aNumber > 0:
        reacting(withNumberIsPositive: true)
        fallthrogh
    case someNumber < 0: 
        reacting(withNumberIsPositive: false)
        print(the number is either positive or negetive);
    default: 
        print(The number is neither positive nor negetive) 
}
```

>  其餘基本上沒有特別好說明的，不過  Objective-C 在 CaseIterable 的實作比 Swift 要繁瑣許多。

## C 語言的 Control flow

相對與 Swift，C 語言對於 if 的寫法基本上差不多，只有幾個要注意的： 
```C
//C
if (1 > 0 && randomIntBut0())  // 1, 2, 3
    doSomething();                          // 4
```
1.  在 if 後面的條件必須加上 `( ... )`  的行為。
2.  `( ... )` 是必須可以得到 單一的 Bool 值的，不可以像 Swift 一樣有 `,`。
3. `int` 在 C 語言的定義中，以 `非 0 為真` 的方式處理，也就是說可以有 `while(1)` 的寫法。
4. 如果控制流程後面沒有寫上 `{ ... }`，編譯器會已下一個作為內容，不注意可能會造成無窮迴圈。

C 語言中，常見的 for loop、while loop、 do while loop 在網路上有許多教學，建議參考 其他教學。

>  我的 C 語言是學習自CS50，他們曾說如何讓一個人理解 goto ，就是不要教其如何使用。但是如果你知道 Swift 的 label statement, 或許你會知道怎麼使用。

 

## Objective-C 的 For in loop (Fast Enumeration)


```Objective-C
// Objective-C
NSArray* arr = @[@1, @2, @3];
for (NSNumber* number in arr)
    printf("%d",[number intValue]); // number 可以直接使用
```
只有 符合 `NSFastEnumeration` 的  Object 可以做到 Fast Enumeration，Objective-C  

然而，Objective-C 編譯器是無法檢測出泛型下的型別錯誤，要自己特別注意才行。
```Objective-C
// Objective-C
NSDictionary<NSString*,NSNumber*>* dic = @{@"x":@4, @"2":@5, @"3":@6};
      for (NSURL* number in dic)
          NSLog(@"%@\n",number);
```


## 簡單測驗
1.
2. [進階]請說明 Swift 中的 break label 的用處是什麼？ [參考 Swift.org - ControlFlow](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html#ID135)
 [進階] For loop 在 C 語言可以造成無窮迴圈，我目前已知有 3 種方式：
    1. `for(;;;)` 不定義迴圈狀態
    2. `for(int i = 0; i == 1; i++) i--;` 控制步進方式。
    3. `for(int i = 0; i < arrayLength; i++;) ... ;` 這個跟 array 有關，你知道嗎？
