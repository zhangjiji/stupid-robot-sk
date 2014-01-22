//
//  Model.m
//  StupidRobotSK
//
//  Created by Zhang Zhe on 14-1-16.
//  Copyright (c) 2014年 Avalon Game Art. All rights reserved.
//

#import "Model.h"

@interface Model ()
@property (nonatomic) BOOL completed;
@property (nonatomic, strong) NSMutableArray* animQueue;
@end

@implementation Model
- (id)init
{
    self = [super init];
    if (self) {
        _completed = YES;
        _animQueue = [NSMutableArray arrayWithCapacity:1];
    }
    return self;
}

-(RACSignal*)playAnimationByName:(NSString*)name
{
    self.completed = NO;
    
    NSLog(@"PlayAnimation:%@", name);
    
    @weakify(self);
    [[RACScheduler scheduler] afterDelay:2.0 schedule:^{
        @strongify(self);
        self.completed = YES;
    }];
    
    return RACObserve(self, completed);
}

-(RACSignal*)completeSignal
{
    return RACObserve(self, completed);
}

@end
