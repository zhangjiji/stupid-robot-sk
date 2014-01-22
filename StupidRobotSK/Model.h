//
//  Model.h
//  StupidRobotSK
//
//  Created by Zhang Zhe on 14-1-16.
//  Copyright (c) 2014年 Avalon Game Art. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Model : SKNode
-(RACSignal*)playAnimationByName:(NSString*)name;
-(RACSignal*)completeSignal;
@end
