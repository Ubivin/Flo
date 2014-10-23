//
//  MainScene.m
//  Flo
//
//  Created by Jason Hoang
//
//

#import "MainScene.h"
#import "Obstacle.h"
#import "GameOver.h"
#import "Plat1.h"
#import "Plat2.h"
#import "Plat3.h"
#import "Plat4.h"
#import "Pause.h"

//scrolling speed
static CGFloat scrollSpeed = 300;
static CGFloat firstObstaclePosition = 1300.f;
static CGFloat firstObstaclePosition1 = 950.f;
static CGFloat firstObstaclePosition2 = 650.f;
static CGFloat firstObstaclePosition3 = 350.f;


static const CGFloat distanceBetweenObstacles = 1310.f;

@implementation MainScene {
    float timerTillScrollFaster;
    NSTimer *timer;
    CCNode *_green;
    CCNode *_detect;
    CCSprite *_red;
    CCNode *_ground1;
    CCNode *_ground2;
    CCSprite *_invis;
    NSArray *_grounds;
    CCNode *_leftSide;
    CCNode *pauseMenu;
    CCNode *_rightSide;
    UITouch * t1;
    UITouch * t2;
    int countdownCounter;
    int touchDetected;
    int touchCollision;
    NSMutableArray *_obstacles;
    NSMutableArray *_obstacles1;
    NSMutableArray *_obstacles2;
    NSMutableArray *_obstacles3;
    CCPhysicsNode *_physicsNode;
    CCNode *Obstacle;
    CCNode *_background;
    CCNode *_scroller;
//    CCButton *_restartButton;
//    CCButton *_homePause;
    CCButton *_resumePause;
    CCButton *_restartPause;
    float _score;
    CCNode *bottomScreen;
    CCLabelTTF *_scoreCount;
    CCLabelTTF *_scoreCount2;
    CCLabelTTF * _highScoreLabel;
    CCLabelTTF *_countdown;
    bool checkingPause;
    NSUserDefaults *_highcore;
    int invisGreen;
    

}


-(void)didLoadFromCCB {
    
//    self.paused = TRUE;
    
    bottomScreen.physicsBody.collisionType = @"bottom";
    bottomScreen.physicsBody.sensor = TRUE;
   _detect.physicsBody.collisionType = @"detect";
   _detect.physicsBody.sensor = TRUE;
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

    _obstacles2 = [NSMutableArray array];
    [self spawnNewObstacle2];
    [self spawnNewObstacle2];
    
    _obstacles3 = [NSMutableArray array];
    [self spawnNewObstacle3];
    [self spawnNewObstacle3];
    
    checkingPause = NO;
    touchCollision = 0;
    
    
    [self backgroundMusic];

   
    
 

    
}

-(void)backgroundMusic{
    
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    // play background sound
    [audio playBg:@"TechTalk.mp3" loop:TRUE];
 
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
    int posX = (arc4random() % (int)([CCDirector sharedDirector].viewSize.width-150))+50;
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
    //int posX = arc4random() % (int)[CCDirector sharedDirector].viewSize.width;
    int posX = (arc4random() % (int)([CCDirector sharedDirector].viewSize.width-150))+50;
    obstacle.position = ccp(posX, previousObstacleYPosition1 + distanceBetweenObstacles);
    [_scroller addChild: obstacle];
    [_obstacles1 addObject: obstacle];
}

-(void)spawnNewObstacle2 {
    CCNode *previousObstacle2 = [_obstacles2 lastObject];
    CGFloat previousObstacleYPosition2 = previousObstacle2.position.y;
    if (!previousObstacle2) {
        //this is the first obstacle
        previousObstacleYPosition2 = firstObstaclePosition2;
    }
    Obstacle *obstacle = (Obstacle *)[CCBReader load: @"Plat3"];
    //Spawns randomly
   int posX = (arc4random() % (int)([CCDirector sharedDirector].viewSize.width-240))+100;
    obstacle.position = ccp(posX, previousObstacleYPosition2 + distanceBetweenObstacles);
    [_scroller addChild: obstacle];
    [_obstacles2 addObject: obstacle];
}

-(void)spawnNewObstacle3 {
    CCNode *previousObstacle3 = [_obstacles3 lastObject];
    CGFloat previousObstacleYPosition3 = previousObstacle3.position.y;
    if (!previousObstacle3) {
        //this is the first obstacle
        previousObstacleYPosition3 = firstObstaclePosition3;
    }
    Obstacle *obstacle = (Obstacle *)[CCBReader load: @"Plat4"];
    //Spawns randomly
    int posX = (arc4random() % (int)([CCDirector sharedDirector].viewSize.width-240))+50;
    obstacle.position = ccp(posX, previousObstacleYPosition3 + distanceBetweenObstacles);
    [_scroller addChild: obstacle];
    [_obstacles3 addObject: obstacle];
}



-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
//    if(self.paused == TRUE && invisGreen == 1){
//        _countdown.visible = TRUE;
//    }
    _green.visible = FALSE;
        t1 = touch;
        CGPoint touchLocation = [touch locationInNode:self];
        _green.position=touchLocation;
    _invis.position=touchLocation;
    
    if(pauseMenu.visible == TRUE){
        pauseMenu.visible = FALSE;
        self.paused = FALSE;
    }
    
   


}



-(void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    
    if (touch == t1){
        
        CGPoint touchLocation = [touch locationInNode:self];
        _green.position=touchLocation;
    }
    CGPoint touchLocation = [touch locationInNode:self];
    _invis.position=touchLocation;

}



- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateRecognized) {
        // handling code ffdsfd
    }
}


/////////////////////////////Pause Menu



-(void)resumePause{
    pauseMenu.visible = FALSE;
    self.paused = FALSE;
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio playEffect:@"button.wav"];
}



////////////////////////////////////




-(void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    _green.visible = TRUE;
//    touchDetected = 0;
    self.paused = YES;
    if(checkingPause == YES){
        
        pauseMenu.visible = FALSE;
        
    }else
    {
    pauseMenu.visible = TRUE;
    }
}


-(void)gameOverScene{
    
    GameOver *popup = (GameOver *)[CCBReader load:@"GameOver"];
    popup.positionType = CCPositionTypeNormalized;
    popup.position = ccp(.05 ,.2);
    popup.nextLevelName = @"GameOver";
    [self addChild:popup];
    scrollSpeed = 275.f;
    checkingPause = YES;
    _highScoreLabel.visible = TRUE;
    _scoreCount.visible = FALSE;
    _scoreCount2.visible = TRUE;
    //
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //    GameOver *gameOverScene = (GameOver *) [CCBReader load: @"GameOver"];
    NSUserDefaults *_highScore = [NSUserDefaults standardUserDefaults];
    if(_score > [_highScore floatForKey: @"highScore"])
    {
        [_highScore setFloat: _score forKey: @"highScore"];
    }
    
    //    popup.finalScoreLabel.string = [NSString stringWithFormat: @"%.0f", _score];
    _highScoreLabel.string  = [NSString stringWithFormat: @"%.0f", (float)[_highScore floatForKey:@"highScore"]];
    
    
}
// WHEN FINGER TOUCHES OBSTACLE
-(BOOL)ccPhysicsCollisionBegin: (CCPhysicsCollisionPair *)pair green:(CCSprite *)green level:(CCNode *)level{
    invisGreen = 0;
      self.paused = YES;
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio playEffect:@"gameover.mp3"];
    [_green removeFromParent];
//    _restartButton.visible = true;
//    NSString *popup = gameover
    [self gameOverScene];

    
    return TRUE;
     
}

//}
//Remove the STAR when it touches

-(BOOL)ccPhysicsCollisionBegin: (CCPhysicsCollisionPair *)pair green:(CCSprite *)green star:(CCNode *)star {
    
OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio playEffect:@"laser.wav"];
    
    [star removeFromParent];
    _score++;
    return TRUE;
}



-(BOOL)ccPhysicsCollisionBegin: (CCPhysicsCollisionPair *)pair star:(CCSprite *)star bottom:(CCNode *)bottom {
    invisGreen = 0;
    NSLog(@"Star Touched.");
    self.paused = YES;
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio playEffect:@"gameover.mp3"];
    [_green removeFromParent];
    //    _restartButton.visible = true;
    //    NSString *popup = gameover
    [self gameOverScene];
    
    return TRUE;

}



//START COUNTDOWN
-(BOOL)ccPhysicsCollisionBegin: (CCPhysicsCollisionPair *)pair invis:(CCNode *)invis green:(CCSprite *)green{
    invisGreen = 1;
    countdownCounter = 3;
    timer = [NSTimer scheduledTimerWithTimeInterval: 1.2
                                             target: self
                                           selector: @selector(countDown)
                                           userInfo: nil
                                            repeats: YES];
    return TRUE;
}

-(void)countDown{
    countdownCounter -=1;
    if (countdownCounter <=0){
        [timer invalidate];
        timer = nil;
    }
    if (countdownCounter == 0){
        _countdown.visible = FALSE;
    }
}




// Increase scrollspeed
-(void)timerTillScrollIncrease
{
    CCLOG(@"%f",scrollSpeed);
    scrollSpeed += 50;
}
- (void)update:(CCTime)delta {
    
    

    
    timerTillScrollFaster += delta;
    if (timerTillScrollFaster >= 10 && timerTillScrollFaster - delta <= 10)
    {
        [self timerTillScrollIncrease];
        timerTillScrollFaster = 0;
    }
    //    //positioning for the green and red thingy majig
    //    _green.position = ccp(_green.position.x, _green.position.y - delta * scrollSpeed);
    //    _red.position = ccp(_red.position.x, _red.position.y - delta * scrollSpeed);
    //The direction of the background moving
    
    //Countdown TIMER
    
      _countdown.string = [NSString stringWithFormat:@"%i", countdownCounter];
    
//    Score tracker
    _scoreCount.string = [NSString stringWithFormat:@"%.0f", _score];
    _scoreCount2.string = [NSString stringWithFormat:@"%.0f", _score];
    
    _scroller.position = ccp(_scroller.position.x, _scroller.position.y  - (scrollSpeed *delta));
    
    
//    for (CCNode *ground in _grounds) {
//        //Determines the speed of the background
//        ground.position = ccp(ground.position.x, ground.position.y - (scrollSpeed *delta));
////        ground.position = ccp(ground.position.x, ground.position.y - .1);
//        //Loops the two backgrounds endlessly
//        if (ground.position.y <= (-1 * (ground.contentSize.height*1)))
//        {
//            ground.position = ccp(ground.position.x, ground.position.y + 2 * (ground.contentSize.height* 1));
//        }
//        
//    }
    
    //loop the background endlessly
    [_ground1 setPosition:ccp(_ground1.positionInPoints.x, _ground1.positionInPoints.y - scrollSpeed * delta)];
    [_ground2 setPosition:ccp(_ground2.positionInPoints.x, _ground2.positionInPoints.y - scrollSpeed * delta)];
    
    
    if (_ground1.positionInPoints.y <= -_ground1.contentSizeInPoints.height * _ground1.scaleYInPoints){
        
        [_ground1 setPosition:ccp(_ground1.positionInPoints.x, 0)];
        [_ground2 setPosition:ccp(_ground2.positionInPoints.x, _ground2.contentSizeInPoints.height * _ground2.scaleYInPoints)];
    }
    
    
//
//    for (CCNode *background in _grounds) {
//            background.position = ccp(background.position.x, background.position.y - _movementSpeed);
//            if (background.position.y <= (-1 * background.contentSize.height))
//            {
//                background.position = ccp(background.position.x, background.position.y +
//                                          2 * background.contentSize.height);
//            }
//        }
//    }



    //Remove the obstacles as it goes off screen
    NSMutableArray *offScreenObstacles = nil;
    for (CCNode *obstacle in _obstacles){
        CGPoint obstacleWorldPosition = [_scroller convertToWorldSpace: obstacle.position];
        CGPoint obstacleScreenPosition = [self convertToNodeSpace: obstacleWorldPosition];
        if (obstacleScreenPosition.y < - 1 - self.contentSize.height){
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
        if (obstacleScreenPosition.y < - 1 - self.contentSize.height){
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
    
    
    NSMutableArray *offScreenObstacles2 = nil;
    for (CCNode *obstacle2 in _obstacles2){
        CGPoint obstacleWorldPosition = [_scroller convertToWorldSpace: obstacle2.position];
        CGPoint obstacleScreenPosition = [self convertToNodeSpace: obstacleWorldPosition];
        if (obstacleScreenPosition.y < - 1 - self.contentSize.height){
            if (!offScreenObstacles2)
            {
                offScreenObstacles2 = [NSMutableArray array];
            }
            [offScreenObstacles2 addObject:obstacle2];
        }
    }
    
    for (CCNode *obstacleToRemove2 in offScreenObstacles2) {
        [obstacleToRemove2 removeFromParent];
        [_obstacles2 removeObject: obstacleToRemove2];
        //for each removed obstacle, add a new one
        [self spawnNewObstacle2];
    }
    
    NSMutableArray *offScreenObstacles3 = nil;
    for (CCNode *obstacle3 in _obstacles3){
        CGPoint obstacleWorldPosition = [_scroller convertToWorldSpace: obstacle3.position];
        CGPoint obstacleScreenPosition = [self convertToNodeSpace: obstacleWorldPosition];
        if (obstacleScreenPosition.y < - 1 - self.contentSize.height){
            if (!offScreenObstacles3)
            {
                offScreenObstacles3 = [NSMutableArray array];
            }
            [offScreenObstacles3 addObject:obstacle3];
        }
    }
    
    for (CCNode *obstacleToRemove3 in offScreenObstacles3) {
        [obstacleToRemove3 removeFromParent];
        [_obstacles3 removeObject: obstacleToRemove3];
        //for each removed obstacle, add a new one
        [self spawnNewObstacle3];
    }
    
    
}



@end