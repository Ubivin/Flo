//
//  Plat3.m
//  FlowJJ1
//
//  Created by Jason Hoang on 8/11/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "Plat3.h"


@implementation Plat3{
    CCNode *yellow1;
    CCNode *yellow2;
    CCNode *star3;
}

- (void)didLoadFromCCB {
    yellow1.physicsBody.collisionType = @"level";
    yellow1.physicsBody.sensor = TRUE;
    yellow2.physicsBody.collisionType = @"level";
    yellow2.physicsBody.sensor = TRUE;

    
    star3.physicsBody.collisionType = @"star";
    star3.physicsBody.sensor = TRUE;
    
    
}

@end
