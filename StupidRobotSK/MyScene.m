//
//  MyScene.m
//  StupidRobotSK
//
//  Created by Zhang Zhe on 13-12-19.
//  Copyright (c) 2013年 Avalon Game Art. All rights reserved.
//

#import "MyScene.h"
#import "Model.h"

@interface MyScene ()
@property (nonatomic, strong) NSString* labelText;
@end

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Hello, World!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [self addChild:myLabel];
        
//        RAC(self,labelText) = [RACObserve(myLabel, fontSize) map:^id(NSString* value) {
//            return @([value floatValue]);
//        }];
        
        RAC(self, labelText) = [RACObserve(myLabel, fontSize) distinctUntilChanged];
        
        myLabel.fontSize = 29;
        myLabel.fontSize = 28;
        
        [RACObserve(self, labelText) subscribeNext:^(id x) {
            NSLog(@"RACObserve log: %@", x);
        }];
        
        myLabel.text = @"Hello2";
        
        NSArray* array = @[@"1", @"2", @"3", @"4", @"5"];
        
        Model* model = [[Model alloc] init];
        
        __block NSUInteger index = 0;
        [[model completeSignal] subscribeNext:^(NSNumber* complete) {
            if(complete.boolValue == YES && index < array.count)
            {
                [model playAnimationByName:array[index++]];
            }
        }];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
