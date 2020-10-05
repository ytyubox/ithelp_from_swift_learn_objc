#import <Foundation/Foundation.h>

@protocol PointProtocol
@property CGFloat x;
@property CGFloat y;
@end

@interface OCPoint : NSObject <PointProtocol>
@property CGFloat x;
@property CGFloat y;
@end

