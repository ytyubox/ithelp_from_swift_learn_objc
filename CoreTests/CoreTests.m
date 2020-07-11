//
//  CoreTests.m
//  CoreTests
//
//  Created by 游宗諭 on 2020/7/11.
//

#import <XCTest/XCTest.h>
#import <Core/MyMath.h>

@interface CoreTests : XCTestCase

@end

@implementation CoreTests

- (void)testToAdd {
    int expected = 3;
    MyMath* myMath = [MyMath alloc];
    int result = [myMath toAdd:1 r:2];
    XCTAssertEqual(expected, result);
}

- (void)testStaticMember {
    NSString* expect = @"MYMATH";
    NSString* result = [MyMath identifier];
    
    XCTAssertTrue([expect isEqualToString:result]);
    const char* expectChar = [expect UTF8String];
    const char* resultChar = [result UTF8String];
    XCTAssertEqual(strcmp(expectChar, resultChar), 0);
}
@end
