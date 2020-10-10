# [26] 30 天從 Swift 學會 Objective-C：Swift friendly 的 Error handling

![](https://images.unsplash.com/photo-1525785967371-87ba44b3e6cf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1653&q=80)

Photo by [@hhh13](@hhh13) on [Unsplash](https://unsplash.com/photos/tEMU4lzAL0w)

## Objective-C 的 Error handling
Apple 的 Cocoa 函式庫對於 Objective-C 的 Error Handling 有固定的編寫方式，可以參考 [Introduction to Error Handling Programming Guide For Cocoa](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ErrorHandlingCocoa/ErrorHandling/ErrorHandling.html)

而 Swift語言在對接 Objective-C 有預設的直接對接方式

1. Method 最後一個非 Block 的參數是 `NSError**`，且
2. Method return BOOL

![](https://i.imgur.com/HgqXzpF.png)

> 關於 Cocoa Error Parameters 可以參考：
[About Imported Cocoa Error Parameters - Apple Developer Documentation](https://developer.apple.com/documentation/swift/cocoa_design_patterns/about_imported_cocoa_error_parameters)

### 強制取消 Swift interface 的轉變

```objectivec
// Objective-C
@interface Atemplate : NSObject
- (BOOL) canFailureMethodForURL: (NSURL*) aURL WithError:(NSError**)aError NS_SWIFT_NOTHROW;
@end
```
使得 Swift interface 就是直接對照到 Method。
![](https://i.imgur.com/xV28Kv2.png)

## C 語言的 Error Handling

Swift 語言的 Error handling 對於指令的錯誤有所謂的錯誤回饋，對於 C 語言也是有同樣的方法。在 C 語言中，我們常見到的 `malloc`、`fopen` 在無法取得正確 return 的時候，會回傳 NULL，而透過 `errno.h`則可以取得相對應的錯誤資訊。

```c
// C
#include <stdio.h>
#include <errno.h>
#include <string.h>

int main () {

   FILE * pf;
   int errnum;
   pf = fopen ("unexist.txt", "rb");
	
   if (pf == NULL) {
   
      errnum = errno;
      fprintf(stderr, "Value of errno: %d\n", errno);
      perror("Error printed by perror");
      fprintf(stderr, "Error opening file: %s\n", strerror( errnum ));
   } else {
      fclose (pf);
   }
   
   return 0;
}

/*
 * Value of errno: 2
 * Error printed by perror: No such file or directory
 * Error opening file: No such file or directory
*/
```

> 範例來自於 [tutorialspoint.com](https://www.tutorialspoint.com/cprogramming/c_error_handling.htm)



## 簡單測驗
1. Objective-C 如何編寫才可以使 Swift 編譯器使用 Error Handling？
2. [進階] 如何透過編寫 Swift 的 adapter 將 C 語言的 `errno.h` 套用 Error handling？
