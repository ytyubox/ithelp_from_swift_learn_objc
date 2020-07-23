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
    chapter("## 01 Welcome to Basic C Main", ^{
    });
    NSMutableArray<NSString*> *argv = [NSMutableArray array];
    for (int i = 0; i < argc; i++) {
        NSString *str = [[NSString alloc]
                         initWithCString:_argv[i]
                         encoding:NSUTF8StringEncoding];
        [argv addObject:str];
    }
    
    chapter("## 02 Hello world\n", ^ {
        NSString* name = (argc > 1)
        ? argv[1]
        : @"world";
        sayHello([name UTF8String]);
        printf("By using `2>&1 > /dev/null` to filter out stderr\n");
        printf("printf(...) is in stdout\n");
        fprintf(stderr,"fprintf(stderr, ...) is in stderr\n");
        NSLog(@"NSLog is in stderr");
    });
    

    chapter("## 03 Basic types\n",^{
        printf("sizeof bool is %lu\n",   sizeof(bool));         // 取得 bool 的使用二元組數量
        printf("sizeof char is %lu\n",   sizeof(char));         // 取得 char 的使用二元組數量
        printf("sizeof short is %lu\n",  sizeof(short));       // 取得 short 的使用二元組數量
        printf("sizeof int is %lu\n",    sizeof(int));           // 取得 int 的使用二元組數量
        printf("sizeof long is %lu\n",   sizeof(long int));     // 取得 long int 的使用二元組數量
        printf("sizeof float is %lu\n",  sizeof(float));       // 取得 float 的使用二元組數量
        printf("sizeof double is %lu\n", sizeof(double));     // 取得 double 的使用二元組數量
        
        printf("(float) 3 / (float) 2 = %f\n",(float) 3 / (float) 2);
        
        char     strSource[] = "1";
        char*   strErrorIndicator = NULL;
        int      inputBase = 10;
        printf("strtol(\"1\", &PTR, 10) = %ld\n",
               strtol(strSource, &strErrorIndicator, inputBase));
        long l = 0x3f9d70a4;
        printf("float value of 0x%lx is %f\n",
               l,
               *((float*)&l));
    });
    
    chapter("## 03 Header Usage\n", ^{
        const int result = SOCAdd(1, 2);
        printf("`Add.h` method add(1, 2) -> %d\n",
              result);
    });
    
    return 0;
}
