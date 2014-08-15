//
//  Plat4.m
//  FlowJJ1
//
//  Created by Jason Hoang on 8/14/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "Plat4.h"


@implementation Plat4{
CCNode *red1;
CCNode *red2;
CCNode *star4;
}

- (void)didLoadFromCCB {
    red1.physicsBody.collisionType = @"level";
    red1.physicsBody.sensor = TRUE;
    red2.physicsBody.collisionType = @"level";
    red2.physicsBody.sensor = TRUE;
    
    
    star4.physicsBody.collisionType = @"star";
    star4.physicsBody.sensor = TRUE;
    
    
}

@end
