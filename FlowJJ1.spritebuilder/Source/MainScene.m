//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Jason Hoang
//
//

#import "MainScene.h"
#import "Obstacle.h"
#import "GameOver.h"
#import "Plat1.h"
#import "Plat2.h"

//scrolling speed
static CGFloat scrollSpeed = 50.f;
static const CGFloat firstObstaclePosition = 600.f;
static const CGFloat firstObstaclePosition1 = 470.f;

static const CGFloat distanceBetweenObstacles = 600.f;

@implementation MainScene {
    float timerTillScrollFaster;
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
    NSMutableArray *_obstacles1;

    CCPhysicsNode *_physicsNode;
    //CCNode *_topPipe;
//    CCNode *_bottomPipe;
    CCNode *Obstacle;
    CCNode *_background;
    CCNode *_scroller;
    CCButton *_restartButton;
    float _score;
    CCLabelTTF *_scoreCount;

}


-(void)didLoadFromCCB {
    
    self.userInteractionEnabled = TRUE;
    _grounds =@[_ground1,_ground2];
    self.multipleTouchEnabled = YES;
    
    _physicsNode.collisionDelegate = self;
    _obstacles = [NSMutableArray array];
    [self spawnNewObstacle];
    [self spawnNewObstacle];
    
    
    _obstacles1 = [NSMutableArray array];
    [self spawnNewObstacle1];
    [self spawnNewObstacle1];
//    [self spawnNewObstacle];
//    [self spawnNewObstacle];
//    [self spawnNewObstacle];
    
}

-(void)spawnNewObstacle {
    CCNode *previousObstacle = [_obstacles lastObject];
    CGFloat previousObstacleYPosition = previousObstacle.position.y;
    if (!previousObstacle) {
        //this is the first obstacle
        previousObstacleYPosition = firstObstaclePosition;
    }
    Obstacle *obstacle = (Obstacle *)[CCBReader load: @"Plat1"];
    //Spawns randomly
    int posX = arc4random() % (int)[CCDirector sharedDirector].viewSize.width;
    obstacle.position = ccp(posX, previousObstacleYPosition + distanceBetweenObstacles);
    [_scroller addChild: obstacle];
    [_obstacles addObject: obstacle];
}

-(void)spawnNewObstacle1 {
    CCNode *previousObstacle1 = [_obstacles1 lastObject];
    CGFloat previousObstacleYPosition1 = previousObstacle1.position.y;
    if (!previousObstacle1) {
        //this is the first obstacle
        previousObstacleYPosition1 = firstObstaclePosition1;
    }
    Obstacle *obstacle = (Obstacle *)[CCBReader load: @"Plat2"];
    //Spawns randomly
    int posX = arc4random() % (int)[CCDirector sharedDirector].viewSize.width;
    obstacle.position = ccp(posX, previousObstacleYPosition1 + distanceBetweenObstacles);
    [_scroller addChild: obstacle];
    [_obstacles1 addObject: obstacle];
}


-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    if (touchDetected == 0){
        t1 = touch;
        CGPoint touchLocation = [touch locationInNode:self];
        _green.position=touchLocation;
        //        NSLog((@"Tap 1"));
        touchDetected++;
        
    }
//    else if (touchDetected == 1){
//        t2 = touch;
//        //            NSLog(@"Tap 2");
//        CGPoint secondTouch = [touch locationInNode:self];
//        _red.position=secondTouch;
//        touchDetected++;
//    }
//    else
//    {}

}

-(void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    if (t1 == touch){
        
        CGPoint touchLocation = [touch locationInNode:self];
        _green.position=touchLocation;
        //        NSLog(@"Move 1");
    }
//    else if (t2 == touch)
////    {
////        CGPoint secondTouch = [touch locationInNode:self];
////        _red.position=secondTouch;
////        //        NSLog(@"Move 2");
////    }
}

//restart button
-(void)restart{
    CCScene *scene = [CCBReader loadAsScene: @"MainScene"];
    [[CCDirector sharedDirector] replaceScene:scene];
}

-(void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    touchDetected = 0;
    //    NSLog(@"end 1");
}
//When green touches an obstacle

-(BOOL)ccPhysicsCollisionBegin: (CCPhysicsCollisionPair *)pair green:(CCSprite *)green wildcard:(CCNode *)wildcard {
    
    NSLog(@"Game Over - green");
      self.paused = YES;
    [_green removeFromParent];
//    _restartButton.visible = true;
    
    GameOver *popup = (GameOver *)[CCBReader load:@"GameOver"];
    popup.positionType = CCPositionTypeNormalized;
    popup.position = ccp(.10 ,.10);
    popup.nextLevelName = @"GameOver";
    [self addChild:popup];
    scrollSpeed=100.f;

    return TRUE;
}

-(bool)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair typeA:(CCNode *)nodeA typeB:(CCNode *)nodeB {
      self.paused = YES;
    _restartButton.visible = true; 
}

//When red touches an obstacle
//-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair red:(CCNode *)red level:(CCNode *)level {
//    NSLog(@"Game Over - red");
//    _restartButton.visible = true;
//    return TRUE;
//    
//}
//test
//-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair red:(CCSprite *)red green:(CCSprite *)green {
//    NSLog(@"Game Over - red");
////    _restartButton.visible = true;
//    return TRUE;
//}
// Increase scrollspeed
-(void)timerTillScrollIncrease
{
    CCLOG(@"%f",scrollSpeed);
    scrollSpeed += 10;
}
- (void)update:(CCTime)delta {
    
    timerTillScrollFaster += delta;
    if (timerTillScrollFaster >= 15 && timerTillScrollFaster - delta <= 15)
    {
        [self timerTillScrollIncrease];
        timerTillScrollFaster = 0;
    }
    //    //positioning for the green and red thingy majig
    //    _green.position = ccp(_green.position.x, _green.position.y - delta * scrollSpeed);
    //    _red.position = ccp(_red.position.x, _red.position.y - delta * scrollSpeed);
    //The direction of the background moving
    
    _score += delta*1;
    _scoreCount.string = [NSString stringWithFormat:@"%.0f", _score];
    
    _scroller.position = ccp(_scroller.position.x, _scroller.position.y  - (scrollSpeed *delta));
    
    for (CCNode *ground in _grounds) {
        //Determines the speed of the background
        ground.position = ccp(ground.position.x, ground.position.y - (scrollSpeed *delta));
        //Loops the two backgrounds endlessly
        if (ground.position.y <= (-1 * (ground.contentSize.height*1)))
        {
            ground.position = ccp(ground.position.x, ground.position.y + 2 * (ground.contentSize.height* 1));
        }
       
    }



    //Remove the obstacles as it goes off screen
    NSMutableArray *offScreenObstacles = nil;
    for (CCNode *obstacle in _obstacles){
        CGPoint obstacleWorldPosition = [_scroller convertToWorldSpace: obstacle.position];
        CGPoint obstacleScreenPosition = [self convertToNodeSpace: obstacleWorldPosition];
        if (obstacleScreenPosition.y < - obstacle.contentSize.height){
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
    
    NSMutableArray *offScreenObstacles1 = nil;
    for (CCNode *obstacle1 in _obstacles1){
        CGPoint obstacleWorldPosition = [_scroller convertToWorldSpace: obstacle1.position];
        CGPoint obstacleScreenPosition = [self convertToNodeSpace: obstacleWorldPosition];
        if (obstacleScreenPosition.y < - obstacle1.contentSize.height){
            if (!offScreenObstacles1)
            {
                offScreenObstacles1 = [NSMutableArray array];
            }
            [offScreenObstacles1 addObject:obstacle1];
        }
    }
    
    for (CCNode *obstacleToRemove1 in offScreenObstacles1) {
        [obstacleToRemove1 removeFromParent];
        [_obstacles1 removeObject: obstacleToRemove1];
        //for each removed obstacle, add a new one
        [self spawnNewObstacle1];
    }
    
    
}

@end