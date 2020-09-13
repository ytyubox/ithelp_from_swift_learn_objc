# [05] 30 天從 Swift 學會 Objective-C：Objective-C 的基本 C 語言 Function

程式語言中，我們時常使用的 Function，其實是 Subroutine，又稱子程式，根據 [Subroutine - wiki](https://en.wikipedia.org/wiki/Subroutine) 中所定義的，子程式是一個大型程式中的某部份程式碼，由一個或多個語句塊組成。它負責完成某項特定工作，而且相較於其他程式碼，具備相對的獨立性。因此，Function 在 object-oriented programming 中，是屬於全域範疇的。

![](https://images.unsplash.com/photo-1545476745-9211a9e7cca8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2250&q=80)

Axe wood chopping block by @jabdilla_creative on [unsplash.com](https://unsplash.com/photos/jZWmw6007EY)

## Swift 中的 Function
Swift 語言中，Function 與 method 並沒有明顯的語法差異，只有透過上下文的不同來判斷。一下是 Swift 的 function 語法：
```swift
// Swift

/// 這是一個 Function
func aFunction() -> Bool {
    return true
}

class Object {
    ...
    
    /// 這是一個 method, 由  Object 管轄
    func aFunction() -> Bool {
        return true
    }
}
```

熟悉 Swift 的朋友可是嘗試理解以下的程式碼：
```swift
// Swift
let object: Object = ...
let aFunctionResult = Object.aFunction(object)()
```

## C 語言的 Function
在 C 語言 的 Function 的語法有許多介紹可以知道，詳細可以看 [C - "Hello, world" example - wiki ](https://en.wikipedia.org/wiki/C_(programming_language)#%22Hello,_world%22_example)

> pass by address 是不存在於  Objective-C 的

在 C 語言中， Function 是可以透過不同的檔案實作的，例如我們有兩個檔案，`main.c` 與 `hello.c`, 透過 compile 是可以將這兩個檔案結合的
```bash
//bash 
clang main.c hello.c -o main
```

然而 C 語言存在單檔 scope 檢查的限制，如果有不在該檔案內可以識別的指令出現，C 語言會將其理解為 `未定義行為`


```C
// C 

// hello.c
sayHello() {
    printf("Hello, world");
}

// main.c
main () {
    sayHello(); // sayHello 是未定義行為
}
```

這個問題可以有許多辦法解決，其中最直接的作法是預先宣告 (predefined function)：
```C
// C
// main.c
sayHello(); // sayHello 已被宣告 [1]

main () {
    sayHello();
}

/*
 * [1] 宣告並不是定義。如果只有編譯 clang main.c -o main 的話，會導致 error：
 *     Undefined symbols: "_sayHello"
 * [2] 使用 clang main.c hello.c -o hello 可以正確編譯與執行
 */
```

值得注意的是，C 語言的 有所謂的 function pointer, 可以將  function 作為參數傳到入 function，以下是一個 Array reduce function:

```c
// C 

int reduce(int *arr, size_t size, int (*f)(int a, int b))
{
    int start;
    size_t i;

    if(size <= 0) return 0;
    start = arr[0];
    i = 1;
    while (i < size)
    {
        start = f(start, arr[i]);
        i++;
    }
    return (start);
}

int min(int a,int b) {
    return a > b ? b : a;
}

// how to call reduce

int array[] = {0, 1, 2, 3};
int length = sizeof(array) / sizeof(array[0]);
int minNumber = reduce(array, length, min); 
```

而在  Objective-C 所應用的 c99 標準中，function pointer 是不可以透過 assign 定義的。
```C
// C
int aFunction(void) {...}
int* func_ptr(void) = &aFunction; // illegal initializer (only variables can be initialized)
```
> 因為 function pointer 是不能透過 assign 的方式定義，我們可以知道 function pointer 是個被 `傂奪公權` 的成員（少了動態生成的權利），也就是說： C 語言不是一個 first-class function 程式語言。 

>> 但是 Objective-C 可以使用 Block 作為替代品，讓 Block 化身為  first-class function。

##  Objective-C 的 Block
在 Swift 中，我們可以使用 closure 作為 作為一次性 function 的使用，像是 `array.map{$0}`，其中的 `{$0}` 就是一個 closure，這個功能在 C 語言一般是無法做到的，而 Objective-C 是透過 Block 在達到：

```Objective-C
// Objective-C
int reduceByBlock(int *arr, size_t size, int (^f)(int a, int b)){ 
    ... // 步驟同 reduce(_,_,_)
}
int array[] = {0, 1, 2, 3};
int length = sizeof(array) / sizeof(array[0]);
int minNumber = reduce(array, length, min);
int minNumber = reduceByBlock(array, length, ^(int a, int b) {
    return a > b ? b : a;
});
```

> 值得注意的是，是無法將 block 視為  function pointer 的，由於型別的不同會導致無法編譯，也沒有已知的 api 可以將其變換。




## 簡單挑戰

1. 如果你要向剛學程式語言的朋友解釋 Function，你會怎麼解釋？
2. 如果你要向剛學程式語言的朋友解釋  pass by value, pass by referance，你會怎麼解釋？
3. 說明  Objective-C 有哪些方法可以將 Function 作為另一個 Function 的參數。 
4. [進階] 請解釋文內 Swift 的 `Object.aFunction(object)()`。

