# [20] 30 天從 Swift 學會 Objective-C：Objective-C 的特殊 Selector

Objective-C 編譯器提供的角色在Objective-C 程式設計中，沒有 Swift 的編譯器來的萬能，在 Swift 編譯時期我們可以透過編譯錯誤提前知道程式的缺陷，然而 Objective-C 並沒有在這方面有明顯能力。


![](https://images.unsplash.com/photo-1582648373212-d5bd3015d35c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1642&q=80)


Photo by [@fantin](https://unsplash.com/@fantin) on [Unsplash](https://unsplash.com/photos/W8BNwvOvW4M)

## Swift 的 struct Selector

在 Swift 中，我們在面對 UIKit 的target action 設計模式時，時常使用到 `#selector`。

```swift
// Swift
let button: UIButton = ...
let target: AnyObject = ...
button.addTarget(
    target,
    action: #selector(AnyObject.ANYFUNCTION),
    for: .touchUpInside)
```

其中，我們知道 `AnyObject.ANYFUNCTION` 是一個 namespace，而Swift 編譯器會檢查 ANYFUCTION 是否有 `@objc` 的標籤

> 要注意 Swift 語言的 `@objc` 與 `dynamic` 是意義上不同的。

## Objective-C selector 與 objc_msgSend

在 Objective-C 中，使用 Method 的完全是透過 objc_msgSend 這個實作的。也就是說，所有的 Objective-C method call 都是可以改寫為 objc_msgSend

```objectivec
// Objective-C

NSString* description = [self description];

#import <objc/objc-runtime.h>
NSString* description = objc_msgSend(self, @selector(description));
```

 > 如果你在 XCode 編譯錯誤，可以將 build setting 的 `Enable strict checking of objc_msgSend Calls` 取消。詳細請參考 [Too many arguments to function call, expected 0, have 3 - StacKOverflow
](https://stackoverflow.com/questions/24922913/too-many-arguments-to-function-call-expected-0-have-3)

## 開始理解 call method 與 send message

在學習程式語言的時候，我們會稱呼使用函式為 `call function` [註 1]，而理所當然的，在物件導向程式設計中我們會說使用物件的 method 為 `call method`，然而在 Objective-C 的消息傳遞架構下，我們需要認知什麼是 message send。

> 這個段落有很大的部分是我閱讀完 ['Calling a method' OR 'sending a message' in Objective C - StackOverflow](https://stackoverflow.com/questions/2852381/calling-a-method-or-sending-a-message-in-objective-c) 的理解，該編十分有趣，推薦閱讀。

Objective-C 的編譯器在檢查可用指令的方式，是在完成 preprocessor 整合後，檢查是否有出現沒有在程式碼或 header 檔出現的定義。也就是說只要是出現過，且 pointer 對齊，就可以編譯成功。雖然大部分都有編譯器的警告通知，但是在少部分是不會有的。

```objectivec
// objective-C
NSArray <NSString*>* arrayStr = @[@"a", @"b"];
for (NSURL* n in arrayStr) {
    NSLog(@"%@",[n absoluteURL]);
}
```

上面這個程式碼在編譯完成之後，是完全不會有警告的，但是在執行時期會得到執行例外：
> unrecognized selector sent to instance 0x1000001234'

所以我們可以知道： Selector 是完全沒有編譯幫助的，Selector 是一個實際上的資料，代表想要指定的 method，也就是真真實實的raw string。

> Selector 在 Objective-C 的真實型別是 `SEL`，詳細請參考 [SEL - Apple Developer Documentation](https://developer.apple.com/documentation/objectivec/sel)

## 註記
1. call function: 實際上我沒有找到為什麼會有 call function 的出處，這部分是根據我學程式最初的印象。


## 簡單測驗

1. 請說明 Objective-C 的消息傳遞架構是什麼。
2. 請說明 Selector 背後封裝的資料是什麼。
3. [進階] 請說明 Objective-C 的消息傳遞架構運作原理是什麼
