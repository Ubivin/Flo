//
//  Plat2.m
//  FlowJJ1
//
//  Created by Jason Hoang on 8/11/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "Plat2.h"


@implementation Plat2{
    CCSprite *blue1;
    CCSprite *blue2;
    CCSprite *blue3;
    CCSprite *blue4;
    CCSprite *star3;
}

- (void)didLoadFromCCB {
    blue1.physicsBody.collisionType = @"level";
    blue1.physicsBody.sensor = TRUE;
    blue2.physicsBody.collisionType = @"level";
    blue2.physicsBody.sensor = TRUE;
    blue3.physicsBody.collisionType = @"level";
    blue3.physicsBody.sensor = TRUE;
    blue4.physicsBody.collisionType = @"level";
    blue4.physicsBody.sensor = TRUE;
    
    star3.physicsBody.collisionType = @"star";
    star3.physicsBody.sensor = TRUE;

    
}

@end
