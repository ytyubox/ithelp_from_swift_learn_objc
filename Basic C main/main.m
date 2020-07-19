//
//  main.m
//  Basic C main
//  To Compile please go to SRCROOT/Basic C main and execute `make`
//
//  Created by 游宗諭 on 2020/7/15.
//

#import <Foundation/Foundation.h>

/// 預宣告 function，這個 function 實際上是在 01/sayHello.m 定義的
void sayHello(const char*);
/// command line 編譯需要使用 `-I` 來指定 header search path
/// Directory Options (Using the GNU Compiler Collection (GCC)) https://gcc.gnu.org/onlinedocs/gcc/Directory-Options.html
/// 此外，該行等同 #include "Basic/02HeaderUsage/Add.h"，且不需要加 `-I`
#import "SOCAdd.h"

void chapter(const char* const title,
             void (^ todo) (void)
             ) {
    printf("\n▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼\n");
    printf("\n%s\n",title);
    todo();
}

int main(int argc,
         const char * _argv[argc - 1]) {
    chapter("Welcome to Basic C Main", ^{
    });
    NSMutableArray<NSString*> *argv = [NSMutableArray array];
    for (int i = 0; i < argc; i++) {
        NSString *str = [[NSString alloc]
                         initWithCString:_argv[i]
                         encoding:NSUTF8StringEncoding];
        [argv addObject:str];
    }
    
    chapter("## 01 Hello world\n", ^ {
        NSString* name = (argc > 1)
        ? argv[1]
        : @"world";
        sayHello([name UTF8String]);
        printf("By using `2>&1 > /dev/null` to filter out stderr\n");
        printf("printf(...) is in stdout\n");
        fprintf(stderr,"fprintf(stderr, ...) is in stderr\n");
        NSLog(@"NSLog is in stderr");
    });
    
    chapter("## 02 Header Usage\n", ^{
        const int result = SOCAdd(1, 2);
        printf("`Add.h` method add(1, 2) -> %d\n",
              result);
    });
    
    chapter("## 03 types and const\n",^{
        const char* const s = "the constant";
        printf("the const `s` will always be `%s`\n",s);
    });
    return 0;
}
