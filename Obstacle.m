//
//  Obstacle.m
//  FlowJJ1
//
//  Created by Jason Hoang on 7/22/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "Obstacle.h"


@implementation Obstacle {
    CCNode *_topPipe;
    CCNode *_bottomPipe;
}

#define ARC4RANDOM_MAX 0X100000000
// visibility on a 3.5-inch iPhone ends a 88 points
static const CGFloat minimumYPositionTopPipe = 128.f;
// visibility at 480
static const CGFloat maximumYPositionBottomPipe = 440.f;
//distance between top and bottom pipe
static const CGFloat pipeDistance = 142.f;
//calculate the end of the range of top pipe
static const CGFloat maximumYpositionTopPipe = maximumYPositionBottomPipe - pipeDistance;

-(void)setupRandomPosition {
    //value between 0.f and 1.f
    
    CGFloat random = ((double)arc4random() / ARC4RANDOM_MAX);
    CGFloat range = maximumYpositionTopPipe - minimumYPositionTopPipe;
    _topPipe.position = ccp(_topPipe.position.x, minimumYPositionTopPipe + (random * range));
    _bottomPipe.position = ccp(_bottomPipe.position.x, _topPipe.position.y + pipeDistance);
    
    
    
}

@end
