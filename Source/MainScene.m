//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Jason Hoang
//
//

#import "MainScene.h"
#import "DrawView.h"
#import "Shape.h"
#import "Obstacle.h"

//scrolling speed
static const CGFloat scrollSpeed = 100.f;
static const CGFloat firstObstaclePosition = 200.f;
static const CGFloat distanceBetweenObstacles = 100.f;

@implementation MainScene {
    CCSprite *_green;
    CCSprite *_red;
    CCNode *_ground1;
    CCNode *_ground2;
    NSArray *_grounds;
    CCNode *_leftSide;
    CCNode *_rightSide;
    UITouch * t1;
    UITouch * t2;
    int touchDetected;
    NSMutableArray *_obstacles;
    CCPhysicsNode *_physicsNode;
    
}


-(void)didLoadFromCCB {
 
    self.userInteractionEnabled = TRUE;
    _grounds =@[_ground1,_ground2];
    self.multipleTouchEnabled = YES;
    

    _obstacles = [NSMutableArray array];
    [self spawnNewObstacle];
    [self spawnNewObstacle];
    [self spawnNewObstacle];
    [self spawnNewObstacle];
    [self spawnNewObstacle];
    
}

-(void)spawnNewObstacle {
    CCNode *previousObstacle = [_obstacles lastObject];
    CGFloat previousObstacleYPosition = previousObstacle.position.y;
    if (!previousObstacle) {
        //this is the first obstacle
        previousObstacleYPosition = firstObstaclePosition;
    }
    CCNode *obstacle = [CCBReader load: @"Obstacle"];
    //Spawns randomly
    int posX = arc4random() % (int)[CCDirector sharedDirector].viewSize.width;
    obstacle.position = ccp(posX, previousObstacleYPosition + distanceBetweenObstacles);
    [_physicsNode addChild: obstacle];
    [_obstacles addObject: obstacle];
//    [self addChild:obstacle];
}





-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    if (touchDetected == 0){
        t1 = touch;
        CGPoint touchLocation = [touch locationInNode:self];
         _green.position=touchLocation;
        NSLog((@"Tap 1"));
        touchDetected++;

    }
        else if (touchDetected == 1){
            t2 = touch;
            NSLog(@"Tap 2");
              CGPoint secondTouch = [touch locationInNode:self];
             _red.position=secondTouch;
            touchDetected++;
        }
        else
        {}
    }


-(void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    if (t1 == touch){
       
        CGPoint touchLocation = [touch locationInNode:self];
       _green.position=touchLocation;
        NSLog(@"Move 1");
    }
    else if (t2 == touch)
    {
        CGPoint secondTouch = [touch locationInNode:self];
        _red.position=secondTouch;
        NSLog(@"Move 2");
    }
}

-(void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    touchDetected = 0;
    NSLog(@"end 1");
}



- (void)update:(CCTime)delta {
    
//    //positioning for the green and red thingy majig
//    _green.position = ccp(_green.position.x, _green.position.y - delta * scrollSpeed);
//    _red.position = ccp(_red.position.x, _red.position.y - delta * scrollSpeed);
    //The direction of the background moving
    _physicsNode.position = ccp(_physicsNode.position.x, _physicsNode.position.y  - (scrollSpeed *delta));
    for (CCNode *ground in _grounds) {
        //Determines the speed of the background
        ground.position = ccp(ground.position.x, ground.position.y - (scrollSpeed *delta));
            //Loops the two backgrounds endlessly
                if (ground.position.y <= (-1 * (ground.contentSize.height*1))) {
                    ground.position = ccp(ground.position.x, ground.position.y +
                                              2 * (ground.contentSize.height*1));
                }
            }
    //Remove the obstacles as it goes off screen
    NSMutableArray *offScreenObstacles = nil;
    for (CCNode *obstacle in _obstacles){
        CGPoint obstacleWorldPosition = [_physicsNode convertToWorldSpace: obstacle.position];
        CGPoint obstacleScreenPosition = [self convertToNodeSpace: obstacleWorldPosition];
        if (obstacleScreenPosition.y < -obstacle.contentSize.height){
            if (!offScreenObstacles)
            {
                offScreenObstacles = [NSMutableArray array];
            }
            [offScreenObstacles addObject:obstacle];
        }
    }
    for (CCNode *obstacleToRemove in offScreenObstacles) {
        [obstacleToRemove removeFromParent];
        [_obstacles removeObject: obstacleToRemove];
        //for each removed obstacle, add a new one
        [self spawnNewObstacle];
    }
    }


@end
