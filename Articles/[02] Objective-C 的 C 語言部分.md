# [02] 30 天從 Swift 學會 Objective-C： Objective-C 的 C 語言部分

Swift 有獨立使用的編譯器，透過 `swiftc main.swift` 可以很直接的編譯 Swift 程式碼，更可以使用 Swift Package 來作為 executable 的專案管理，但是 Objective-C 的編譯方法卻與 Swift 大不一樣，在開始學習 Objective-C 語法之前，我們先拿好釣竿，練習如何自己編譯並執行 Objective–C 程式碼！

![](https://i.imgur.com/NDrSXh5.png)

By Johannes Plenio @ https://unsplash.com/photos/NYDTneTcSdo

## 編譯器使用方法

Objective-C 實際上是 C 語言的衍生語言，所以我們可以用與 C 語言相似的編譯器 `gcc` 來編譯 Objective-C 的 `.m` 檔。

在 C 語言中，可以使用 `clang` 作為編譯程式，並提供相關的 `.c` 檔作為程式碼來源，而使用 `-o` 的 flag 作為產出程式的指定名稱。而產出的檔案則自動成為 execuable 的二進制執行檔 ( u+x )，可以加入到 `usr\bin` 作為一個可以在 Command line 呼叫的指令。

```bash
# C 語言編譯指令，會在指定路徑(./main)複寫執行檔
clang main.c -o ./main

# 該執行檔會直接加上 u+x 的權限，可以直接使用
./main
```

而在 C 語言的專案中，像 Xcode 的 `.xcodeproj` 的專案檔是由 `Makefile` 所管理的，你可以在 [GitHub](https://github.com/ytyubox/ithelp_from_swift_learn_objc) 的 `Basic C main` 資料夾內找到該檔案，該檔案內的編譯指令是針對 Objective–C。

由於是與 C 語言使用同一個編譯程式，我需要特別小心處理，透過 `-lobjc` 指定程式語言是 Objective–C；由於 Objective-C 的許多物件導向工具都需要使用 `Foundation`，因此需要指定引入 Objective-C runtime 的 Foundation framework，其他設定基本上與 C 語言無異。

```bash
clang \
    #  指定要編譯的程式語言是 Objective-C
    -lobjc \
    # 指定引入 Objective-C runtime 的 Foundation
    -framework Foundation \ 
    main.m \
    -o ./main
```

## Hello world 與 stdout / stderr

使用 Command line 都會知道 stdout 與 stderr 的概念。stdio 是在 Unix 的標準串流，其中包含了 stdin、stdout、stderr。

![](https://i.imgur.com/X8rlw0w.png)

圖片來自 https://en.wikipedia.org/wiki/Standard_streams

Objective-C 中，打印分別有 printf 與 NSLog，各自對應的是 `char*` 與 `NSString`，我們會在接下來的幾天詳細介紹 String。首先，我們可以建立一個檔案為 `main.m`，並開始編寫程式！

```Objective-C
main() {
    printf("Hello world\n");
}
```
或許學過 C 語言的讀者會發現，這不就是 C 語言的經典程式碼！

![](https://i.imgur.com/A3bbQD9.png)

"Hello, World!" program by Brian Kernighan (1978)


是的沒錯，Objective-C 是 C 語言的 Superset（超集），Objective-C 甚至可以直接引入 C 語言的檔案 （不是 C++）。接下來，我們嘗試用 Objective-C 的打印指令 `NSLog` 。

```Objective-C
#import <Foundation/Foundation.h>

main() {
    NSLog(@"Hello world");
}
```
由於 NSLog 是在 Foundation 的函式庫裡面，使用 `#import` 引入 Foundation/Foundation.h；NSLog 只支援 NSString，所以我們使用 `@""` 而 不是 `""` （沒有 `@` 符號）。

在 Swift 中，在字串內加入變數是很簡單的，我們只要使用 `"\()"`就可以將任意變數加到字串裡面，但是在 C 與 Objective-C 則需要使用 format 的方式。

```Objective-C
NSString* name = @"ithelp";
NSLog(@"Hello %@", name);
```

## 簡單測驗

1. Objective-C 的副檔名是什麼？
2. 如何編譯 Objective-C 的程式碼？
3. 在 Objective-C 語言的 String 是主要什麼型別？
