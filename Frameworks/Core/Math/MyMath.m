//
//  Math.m
//  Core
//
//  Created by 游宗諭 on 2020/7/11.
//  Copyright © 2020 ytyubox. All rights reserved.
//

#import "MyMath.h"

@implementation MyMath
/// Static member
///
/// 在 Swift 中 static member 屬於全域變數, 宣告方式如下
/// ```swift
/// class MyMath {
///     static var idenifier:String { "MYMATH" }
/// }
/// ```
///
+ (NSString *)identifier {
    return @"MYMATH";
}
- (int)toAdd: (int) lValue
           r: (int) rValue
{
    return lValue + rValue;
}
@end
