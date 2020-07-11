//
//  Math.m
//  Core
//
//  Created by 游宗諭 on 2020/7/11.
//  Copyright © 2020 ytyubox. All rights reserved.
//

#import "MyMath.h"

@implementation MyMath
+ (NSString *)identifier {
    return @"MYMATH";
}
- (int)toAdd: (int) lValue
           r: (int) rValue
{
    return lValue + rValue;
}
@end
