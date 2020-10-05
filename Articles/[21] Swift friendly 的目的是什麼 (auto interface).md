# [21] 30 天從 Swift 學會 Objective-C：Swift friendly 的目的是什麼 (auto interface)

當我們學會了 Swift 之後，可以使用 Objective-C 的程式碼，完全感謝 Swift 編譯器的強大，這篇文章將介紹 Xcode 內如何快速檢查如何使用 Objective-C 程式碼。

![](https://images.unsplash.com/photo-1485827404703-89b55fcc595e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80)

Photo by [@agkdesign](https://unsplash.com/@agkdesign) on [Unsplash](https://unsplash.com/photos/2EJCSULRwC8)

## Xcode 的 CounterPart

在 Xcode 有所謂的自動產生的程式碼，這個功能在 Swift 使用，這個功能尤其在 Access Control 有需要做 micro management 的時候最為需要，但是似乎並沒有被很多人知道。

而在 Objective-C 與 C 語言，Xcode 可以透過Counterparts 的 Swift interface 幫助我們了解我們編寫的程式碼可以如何被 Swift 呼叫。 

![](https://i.imgur.com/7pzSE6O.png)
## 如何呼叫出 Counterparts - Swift interface
 
 ![](https://i.imgur.com/XYAIbTu.png)
以 `class OCPoint` 為例：
1. 開啟 `OCPoint.h`
2. 點擊上方的 ![](https://i.imgur.com/caxJiGM.png)
3. 選取 `Counterparts`
4. 選取 `OCPoint.h (Swift 5 interface)`

![](https://i.imgur.com/uf4pexu.png)

## Swift 也可以對 C 語言建立 interface
同樣道理，我們可以對 C 語言查看 Swift 的 interface：

![](https://i.imgur.com/8hmSzbt.png)


## 簡單測驗
1. Swift Int 需要 對應到 Objective-C 的哪個型別？
2. Swift Int 需要 對應到 C 語言的哪個型別？
3. [進階] Xcode 有機會對 C++ 的程式碼產生 Swift interface 嗎？
