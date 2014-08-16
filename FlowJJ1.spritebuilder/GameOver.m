//
//  GameOver.m
//  FlowJJ1
//
//  Created by Jason Hoang on 8/8/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "GameOver.h"
#import "MainScene.h"


@implementation GameOver


-(void)gameOverAgain {
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio playEffect:@"button.wav"];
    CCScene *gameOverAgain= [CCBReader loadAsScene:@"MainScene"];
    CCTransition *transition = [CCTransition transitionFadeWithDuration:0.8f];
    [[CCDirector sharedDirector] replaceScene:gameOverAgain withTransition:transition];
    
    
}
@end
