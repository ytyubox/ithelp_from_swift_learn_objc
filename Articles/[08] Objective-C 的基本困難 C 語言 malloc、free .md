#  [08] 30 天從 Swift 學會 Objective-C：Objective-C 的基本困難 C 語言的記憶體管理 malloc、free

在程式語言中，記憶體就相當與一張白紙，這張白紙是一個有限的空間，而這些空間會用來記憶資料，就像是大腦一樣。現今的電腦普遍是使用 范紐曼型架構[註 1]，而這樣的架構下有所謂的記憶體管理問題。

## 關於電腦科學的 Heap 與 Stack
在程式設計中，有所謂的記憶體管理，最常見到的記憶體架構是使用 Heap 與 Stack。關於這個主題並不會講解，詳閱 [Stack based memory allocation - wiki](https://en.wikipedia.org/wiki/Stack-based_memory_allocation) 與 [Memory management: Heap - wiki](https://en.wikipedia.org/wiki/Memory_management#HEAP)。

值得注意的是，Stack 與 Heap 的記憶體管理有相對的差異，下面翻譯來自 [GeeksforGeeks - stack vs heap memory allocation](https://www.geeksforgeeks.org/stack-vs-heap-memory-allocation/)
| PARAMETER |	STACK |	HEAP|
| :-: | :-: | :-: | 
| 概述 | 記憶體取用區段是連續的 |	記憶體取用區段是不連續連續的（隨機） |
| 創建與回收 |	由編譯器自動操作 | 由編撰者手動操作 |
| 資源消耗 |	少 |	多|
| 實作的難度 |	較難 | 較易	|
| 資料取用速度 |	較快	| 較慢 |
| 已知問題 |	記憶體容易不足 |	記憶體使用方式零散 |
|參考區域性 [註 2] |	優化	| 尚可 |
| 記憶體彈性	| 固定	 | 必要時可重整 |
| 資料的分佈架構 |	線型 | 階層型 |

## C 語言的 malloc 與 pointer
在 C 語言中我們可以使用 `malloc` 向系統要求記憶體空間。
```C
// C
#include <stdlib.h>
typedef struct Person {
    int age;
    char gender;
} Person;

Person* PersonMake(int age, char gender) {
    Person* person = malloc(sizeof(Person));
    if (!person) return NULL;
    person->age = age;
    person->gender = gender;
    return person;
}
```
`malloc` 參數使用 `sizeof` 的語法，建立一個記憶體區塊，要注意的是，這個操作有可能失敗，細節請參考 [Should I check if malloc() was successful?](https://stackoverflow.com/a/26844703/10172299)

## Objective-C 的物件
Objective 在 NSObject 的封裝後，使用 `[ObjectClass alloc]` 來使用，這部分會在後續的 Objective-C 物件編寫討論。

## 簡單測驗
1. 使用 `malloc` 需要引入那個 header
2. 在 Swift 語言中，有提到盡量使用 `struct` 的 value type，所以 Objective-C 有 Value type 嗎？

## 註記
1. 范紐曼型架構： 是一種將程式指令記憶體和資料記憶體合併在一起的電腦設計概念架構。 參考 [范紐曼型架構](https://zh.wikipedia.org/wiki/%E5%86%AF%C2%B7%E8%AF%BA%E4%BC%8A%E6%9B%BC%E7%BB%93%E6%9E%84) 與 inside 文章 [【Lynn 寫點科普】你知道你正在用的電腦是 70 年前發明的馮紐曼架構嗎？](https://www.inside.com.tw/article/9507-von-neumann-architecture)
2. 參考區域性 （Locality of reference）： 指的是在計算機科學領域中應用程式在訪問內存的時候，傾向於訪問內存中較為靠近的值。 參考 [Locality of reference - wiki](https://en.wikipedia.org/wiki/Locality_of_reference) (鐵人表示： 我這個目前看沒有很懂，僅附上查找到的資料)