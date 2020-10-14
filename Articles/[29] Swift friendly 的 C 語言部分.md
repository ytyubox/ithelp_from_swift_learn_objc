# [29] 30 天從 Swift 學會 Objective-C：Swift friendly 的 進階 C 語言部分與 modulemap

在理解完 Objective-C 之後，我們要來面對 C 語言的引用，不得不說 Swift 十分不信任 C 語言，看看那個`UnsafePointer` 就知道了。


![](https://images.unsplash.com/photo-1509021504421-0c2012733419?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80)
Photo by [@filipz](https://unsplash.com/@filipz) on [Unsplash](https://unsplash.com/photos/ZpbsuvT77Jk)

## C 語言程式碼匯入到 Swift project
當我們使用 Xcode 在 Swift projcet 建立 C/Objective-C 檔案時，Xcode 會提示我們 Xcode 可以自動建立需要的 bridge header
![](https://i.imgur.com/TsVRhVE.png)

在 [Importing Objective-C into Swift - Apple Developer Documentation](https://developer.apple.com/documentation/swift/imported_c_and_objective-c_apis/importing_objective-c_into_swift)
中有這麼一張圖： 
![](https://docs-assets.developer.apple.com/published/ac0dfb7915/96b6ab28-845f-4546-be71-16e5298b244c.png)
> 圖片來自 [Importing Objective-C into Swift - Apple Developer Documentation](https://developer.apple.com/documentation/swift/imported_c_and_objective-c_apis/importing_objective-c_into_swift)


我們可以知道在 C/Objective-C 都是使用 `.h` 作為 header 的副檔名，透過在 bridge Header 內引用相關的Header， Swift 編譯器可以確認納入編譯來源的檔案。
![](https://i.imgur.com/eVPrsYY.png)

## [進階] 只有 C 語言的 .h 與 .a 

在 C 語言的編譯過程中有所謂的 linker 階段，在 clang 可以將單個 `.c` 檔案編譯為 `.o` 檔案。

```bash
 clang -c CFunctions.c -o CFunctions.o
```

透過使用 `-c` 的參數指定 compile 成 obj 檔案，而這個 Obj 檔案可以保留作為節省編譯資源的方式(時間與電量)。
![](https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Linker.svg/220px-Linker.svg.png)

而 `.a` 是透過 `ar` 指令將指定的 obj 檔案建立為靜態函式庫。
> 關於 靜態函式庫與共享函式庫，參考 [Static library - Wikipedia](https://en.wikipedia.org/wiki/Static_library)

### [我看不懂的部分] 在 Swift 引入靜態函式庫

在使用 C 的靜態函式庫時，我們可以用 Framework, Libaraies, and Embedded Content 來使用，目前我實作了
[rderik/Csqlite3 - GitHub](https://github.com/rderik/Csqlite3) 是可以使用的，其中 `Sources/module.modulemap` 內使用的是來自系統的 header。

![](https://i.imgur.com/R6dVMBw.png)
> 範例來自 [rderik/Csqlite3 - GitHub](https://github.com/rderik/Csqlite3)

然而我嘗試透過 `ar` 建立靜態函式庫並應用進來 modulemap 時，header 的 obj 卻遺失導致無法編譯成功。由於截稿壓力無法完成研究。

## 關於 Swift 不信任 C 語言這件事

在使用 bridge header 引入 C 語言的程式碼後，使用 `char*` 會遇到 `UnsafeMutablePointer<Int8>!`
![](https://i.imgur.com/EytA57N.png)

這部分我使用的方式時拖過 adapter 的方式，藉由 Swift package 來處理。

![](https://i.imgur.com/RvR3wik.png)
> 程式碼範例於 [ytyubox/lib_mylib - GitHub](https://github.com/ytyubox/lib_mylib)

關於這部分的詳細解釋，我推薦 [Cecilia Humlelu](https://twitter.com/Humlelu) 在 App Builders 2019 的介紹

[![](https://i.ytimg.com/an_webp/jcNxtM_yTfk/mqdefault_6s.webp?du=3000&sqp=CJG1mvwF&rs=AOn4CLDh2EIT0GnENN_HW0HJrum_uUy2Lg)](https://www.youtube.com/watch?v=jcNxtM_yTfk&ab_channel=SwissMobileDevelopersAssociation)
> Use C, C++ and Objective C Libraries in a Swift Project - Cecilia Humlelu - App Builders 2019 On [Youtube](https://www.youtube.com/watch?v=jcNxtM_yTfk&ab_channel=SwissMobileDevelopersAssociation) 


## 簡單測驗
1. 在 C 語言中，如何判讀一個 `char*` 的長度 (length)? 這與 Swift 的 String count 有區別，那區別是什麼？
