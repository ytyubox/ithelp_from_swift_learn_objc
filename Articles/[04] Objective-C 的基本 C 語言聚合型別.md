# [04] 30 天從 Swift 學會 Objective-C：Objective-C 的基本 C 語言聚合型別

在生活中，我們將一系列的資料聚集在一起，如果這些資料需要有先後順序（如日記），我們可以用有序的方式紀錄；如果這些資料沒有順序（如個人資料），我們可以用聚合的方式紀錄。在 Swift 中我們可以使用`Array`、`Tuple`、`struct` 等方式來將基本型別同捆 (Bundle) 起來，Objective-C 也有同樣的行為。

![](https://i.imgur.com/CcFhvYQ.png)

Photo by Jessica Lee @ unsplash.com/photos/o5GGlwHfff8

## 衍生型別

在程式語言中，自定義型別必定是基本型別的衍生。在 C 語言中有 4 大基本衍生型別：
| | name       | type         |
|-| -          |  -   |
|1| Arrays     |聚合資料型別       |
|2| Structures |聚合資料型別       |
|3| Pointers   |複雜難懂型別       |
|4| Unions     |複雜難懂型別       |
|x| typedef | 型別別名(非自定義型別) |

> Unions、typedef 不會解釋到，詳閱 [GNU C manual](https://www.gnu.org/software/gnu-c-manual/gnu-c-manual.html)
# Array

在介紹 C 語言的 Array，有個很重要的事情要事先請讀者理解：

> Arrays are not pointers. 《Modern C takeaway 1.6.1.1》 

Array 與 Pointer 在 C 語言是不同概念的，請務必有這個認知，而 Objective-C 雖然大部分都是使用 NSArray，但是這仍然是很重要的觀念。

在 C 語言中與兩種 Array，分別是 `fixed length arrays` (FLAs) 與 `variable-length arrays` (VLAs)，這兩種宣告方式分別如下：
```C
// C
int FLAs[3];
int VLAs[int]; // 根據 int 而決定長度
```

> VLAs 有不少限制，詳閱 [[Variable-length array - wiki]](https://en.wikipedia.org/wiki/Variable-length_array)。

定義 array 的方式有一定的方式：
```C
// C
// 1 直接定義的方式
int FLAs = {1, 0, 2,}; 
// 2 忽略定義，沒有定義預設為 0
int FLAs = {1,};
// 3 指定定義
int FLAs = {
    [0] = 1,
    [2] = 2,
    };
```

在 C 語言中 pointer 的 size 必定是處理器的位元數量，然而 Array 卻不是，因此可以使用 sizeof 的方式知道 Array 的長度。

```C
// C
const int FLAs[3] = {1,2,3};
lu length = sizeof(FLAs) / sizeof(FLAs[0]); // length = 3
```

### String also Array

> A String is a `0`-terminated array of `char`.
> 

```C
\\C
char jay0[] = "jay";
char jay1[] = { "jay" };
char jay2[] = { 'j', 'a', 'y', 0, };
char jay3[4] = { 'j', 'a', 'y', };

// not a String
char jay4[3] = { 'j', 'a', 'y', }; 
char jay5[3] = "jay";
```

## 來說說 Structure

在 Swift 的 `struct` 是 Value type，與 C 語言的一樣是的。

```C
// C
struct Person{
    int age;
    char gender;
};

struct Person person = {
    .age = 18,
    .gender = 'm',
};

struct Person* personAddress = &person;
int age = personAddress->age;
```
值得注意的是 struct 的 size 並不是所有聚合資料 size 的加總，詳閱 [Stack Overflow: Why isn't sizeof for a struct equal to the sum of sizeof of each member?
](https://stackoverflow.com/questions/119123/why-isnt-sizeof-for-a-struct-equal-to-the-sum-of-sizeof-of-each-member)


## NSArray 與 NSString
在 Objective-C 語言將一些特別的資料結構作了基本實作，如 Set、Hash Map、dynamic length array 等等，如 `NSArray` 就是一個例子。Objective-C 提供了快速定義的方式。

```Objective-C
// Objective-C
// Array
NSArray<NSNumber*>* array = @[@1, @2];
// String
NSString* string = @"this is a NSString";
// Hash Map
NSDictionary<NSString*,NSNumber*>* dictionary = @{@"key": @1 };
// Set 沒有快速定義的方式
NSSet<NSNumber*>* set = [[NSSet alloc]initWithArray:@[@1]];
```


## 給 Function 是複製變數還是直接變數
![](https://i.imgur.com/k1bnSew.gif)

> 關於 Pass by reference / pass by  vale 詳閱 [[電腦科學：求值策略 wiki]](https://en.wikipedia.org/wiki/Evaluation_strategy)

經典的 Swap 函式是這樣子的，在 Swift 我們使用 `inout` 作為直接變數的求值：
```swift
// Swift
func swap(_ a: inout Int, _ b: inout Int) {
    let tmp = a
    a = b
    b = tmp
}
```

而 Objective-C 則是用 Pointer 來處理
```Objective-C
// Objective-C
void swap(Int* a, Int* b) {
    int tmp = *a;
    *a = *b;
    *b = tmp;
}
```

**[進階]** Array pass 是 Pass by reference，請參考下面這個 C 語言的範例：

```Objective-C
// Objective-C 
void swap_double(double a[static 2]) {
    double tmp = a[0];
    a[0] = a[1];
    a[1] = tmp;
}
double A[2] = { 1.0, 2.0, };
swap_double(A); 
//  A is now {2.0, 1.0,};
```
## [進階] Pointer！ 其實就是 Any Type

> **Pointer！ 其實就是 Any Type**
> **Pointer！ 其實就是 Any Type**
> **Pointer！ 其實就是 Any Type**

在 Swift 語言由於型別的強制性，Any 型別需要使用 `as?/as!` 的方式才能使用，但是在 
C 則可以使用 pointer 來處理。

> Objective-C 則是有特別的語法 `id` 可以使用，會在 Objective-C 物件導向部分解釋。

在 C 語言中，Any 可以使用 `void pointer` 來表示：
```C
// C
void * anyAddress;
char asciiA = 'A';
anyAddress = &asciiA;
*((int *) anyAddress) += 1;
printf("'%c'\n",asciiA); // print 'B'
```

C 語言雖然有直接型別上的限制(如錯誤定義值 `myChar = myArray`)，但是對於型別轉換和 Swift 一樣沒有強制性，但是卻會在型別轉型不如預期時將錯誤資料執行轉型。

## 簡單挑戰
1. 說明 `NSString* value[3]` 宣告了什麼變數？
2. 說明 `typedef struct Person Person` 將什麼型別取了什麼別名？
3. 說明 `NSNumber` 可以填入哪些 C 語言的型別？
4. [進階] 在文末的 `swap_double`  中 `a` 的值與來源 `A` 有什麼共同點？
5. [進階] 說明 `char a = 65.3;` 實際上 `a` 的值是什麼？
