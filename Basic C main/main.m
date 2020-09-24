    //
    //  main.m
    //  Basic C main
    //  To Compile please go to SRCROOT/Basic C main and execute `make`
    //
    //  Created by 游宗諭 on 2020/7/15.
    //

#import <Foundation/Foundation.h>

    /// 預宣告 function，這個 function 實際上是在 01/sayHello.m 定義的
extern void sayHello(const char*);
    /// command line 編譯需要使用 `-I` 來指定 header search path
    /// Directory Options (Using the GNU Compiler Collection (GCC)) https://gcc.gnu.org/onlinedocs/gcc/Directory-Options.html
    /// 此外，該行等同 #include "Basic/02HeaderUsage/Add.h"，且不需要加 `-I`
#import "SOCAdd.h"

void chapter(const char* const title,
             void (^ todo) (void)) {
    printf("\n▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼\n");
    printf("\n%s\n",title);
    todo();
}

void swap_double(double a[static 2]) {
    double tmp = a[0];
    a[0] = a[1];
    a[1] = tmp;
}

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
    
    chapter("## 04 Aggregation types\n", ^{
        int FLAs[3] = {
            [0] = 1,
            [2] = 2,
        };
        printf("FLA[0] = %d, FLA[1] = %d, FLA[2] = %d\n",
               FLAs[0],
               FLAs[1],
               FLAs[2]);
        printf("sizeof(FLAs) = %lu, sizeof(FLAs[0] = %lu, length of FLAs = %lu\n",
               sizeof(FLAs),
               sizeof(FLAs[0]),
               sizeof(FLAs)/ sizeof(FLAs[0])
               );
        int VLAsLength = 3;
        int VLAs[VLAsLength];
        printf("VLAs length = %lu\n",sizeof(VLAs) / sizeof(VLAs[0]));
        
        double A[2] = { 1.0, 2.0, };
        printf("A[0] = %f, A[1]%f\n",A[0], A[1]);
        swap_double(A);
        printf("`void swap_double(double a[static 2])`\n");
        printf("A[0] = %f, A[1]%f\n",A[0], A[1]);
        struct Person person = {
            .age = 18,
            .gender = 'm',
        };
        printf("Variable person is a `struct Person` type with age: %d, gender: %c\n",
               person.age,
               person.gender);
        
        struct Person* personAddress = &person;
        printf("To get a `struct Person*` value can use:\n");
        printf("\t\t: ( ptr)->age: %d, ptr->gender: %c\n",
               personAddress->age,
               personAddress->gender
               );
        printf("\t\t: (*ptr).age: %d, (*ptr).gender: %c\n",
               (*personAddress).age,
               (*personAddress).gender
               );
        
            // Array
        NSArray<NSNumber*>* array = @[@1, @2];
            // String
        NSLog(@"NSArray<NSNumber*>* array:\n%@",array);
        NSString* string = @"this is a NSString";
            // Hash Map
        NSLog(@"NSString* string:\n%@",string);
        NSDictionary<NSString*,NSNumber*>* dictionary = @{@"key": @1 };
            // Set 沒有快速定義的方式
        NSLog(@"NSDictionary<NSString*,NSNumber*>* dictionary:\n%@",dictionary);
        NSSet<NSNumber*>* set = [[NSSet alloc]initWithArray:@[@1]];
        NSLog(@"NSSet<NSNumber*>* set:\n%@",set);
        
        void * anyAddress;
        char asciiA = 'A';
        anyAddress = &asciiA;
        *((int *) anyAddress) += 1;
        printf("`*((int *) anyAddress) += 1` make asciiA to '%c'\n",asciiA);
    });
    
    chapter("## 05 functions and Storage\n", ^{
        printf("size of a pointer is %lu\n",sizeof(&main));
        printf("size of main is %lu\n",sizeof(main));
        printf("size of a function is %lu\n", sizeof(chapter));
        int (*mainCopy)(int, const char **) = main;
        printf("main: %d is copied by main Copy: %d\n",(int)main, (int)mainCopy);
        printf("mainCopy declared by `int (*mainCopy)(int, const char **)`");
        int (^mainBlock)(int, const char **);
        printf("Block type is `int (^__strong)(int, const char **)` not the same for C function\n");
        mainBlock = ^(int argg, const char ** argv) {
            return main(argc, argv);
        };
        printf("mainBlock = ^(int argg, const char ** argv) is the way to copy main to block\n");
        
        
        printf("Objective-C can not have nested function\n");
        
        printf("exit(EXIT_SUCCESS) will teminate the main function\n");
        
        printf("using `assert(bool)` to assert condition\n");
        printf("if assert get false, the main will abort with message indicate file and line where assertion failure.\n");
        
            /// #if __DARWIN_UNIX03
            /// #define    assert(e) \
            ///    (__builtin_expect(!(e), 0) ? __assert_rtn(__func__, __FILE__, __LINE__, #e) : (void)0)
            /// #endif /* __DARWIN_UNIX03 */
            ///
        
    });
    
    chapter("## 06 control flow", ^{
        printf("C language have for loop, while loop, and do while loop\n");
        printf("Fast Enumeration is the Objective-C only loop rather than C\n");
        printf("However,Fast Enumeration only avaliable on Object that conform to NSFastEnumeration protocol\n");
        NSArray* arr = @[@1, @2, @3];
        for (NSNumber* number in arr)
            printf("%d",[number intValue]); // number 可以直接使用

        NSDictionary<NSString*,NSNumber*>* dic = @{@"x": @4, @"2": @5, @"3": @6};
        for (NSURL* number in dic)
            NSLog(@"%@\n",number);
        
        
    });
    
    chapter("## 10 header usage\n", ^{
        const int result = SOCAdd(1, 2);
        printf("`Add.h` method add(1, 2) -> %d\n",
               result);
    });
    if (@available(macOS 20, *)) {
        printf("macOS above 20\n");
    }
    NSLog(@"Null %@\n",[NSNull null]);
    NSLog(@"nil %@\n", nil);
    NSLog(@"Nil %@\n", Nil);
    return EXIT_SUCCESS;
}

