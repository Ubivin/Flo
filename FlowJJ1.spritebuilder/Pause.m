//
//  Pause.m
//  FlowJJ1
//
//  Created by Jason Hoang on 8/13/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "Pause.h"
#import "MainScene.h"
#import "Title.h"


@implementation Pause

-(void)homePause {
    CCScene *homePause = [CCBReader loadAsScene:@"Title"];
    CCTransition *transition1 = [CCTransition transitionFadeWithDuration:0.8f];
    [[CCDirector sharedDirector] replaceScene:homePause withTransition:transition1];
}

-(void)titlePause {
    CCScene *titlePause = [CCBReader loadAsScene:@"MainScene"];
    CCTransition *transition2 = [CCTransition transitionFadeWithDuration:0.8f];
    [[CCDirector sharedDirector] replaceScene:titlePause withTransition:transition2];
}

@end

