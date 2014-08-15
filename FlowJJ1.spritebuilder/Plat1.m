//
//  Plat1.m
//  FlowJJ1
//
//  Created by Jason Hoang on 8/11/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "Plat1.h"


@implementation Plat1 {
    
    CCNode *green1;
    CCNode *green2;
    CCNode *green3;
    CCNode *star1;
   
    
}

- (void)didLoadFromCCB {
    green1.physicsBody.collisionType = @"level";
    green1.physicsBody.sensor = TRUE;
    green2.physicsBody.collisionType = @"level";
    green2.physicsBody.sensor = TRUE;
    green3.physicsBody.collisionType = @"level";
    green3.physicsBody.sensor = TRUE;
    
    star1.physicsBody.collisionType = @"star";
    star1.physicsBody.sensor = TRUE;
    
    
}


@end
