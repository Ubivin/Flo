//
//  Title.m
//  FlowJJ1
//
//  Created by Jason Hoang on 8/9/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "Title.h"

static CGFloat scrollSpeed = 100
;

@implementation Title{
    CCNode *_title1;
    CCNode *_title2;
    CCNode *tutorial;
    CCLabelTTF *delete;
    CCLabelTTF *playLabel;
    CCButton *next;
    int touch1;
}

-(void)didLoadFromCCB {
    // access audio object
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    // play background sound
    [audio preloadEffect:@"ding.wav"];
     [audio preloadEffect:@"button.wav"];
    [audio preloadEffect:@"laser.wav"];
    [audio preloadEffect:@"gameover.wav"];
   
}

- (void)update:(CCTime)delta {
    //loop the background endlessly
    [_title1 setPosition:ccp(_title1.positionInPoints.x, _title1.positionInPoints.y - scrollSpeed * delta)];
    [_title2 setPosition:ccp(_title2.positionInPoints.x, _title2.positionInPoints.y - scrollSpeed * delta)];
    
    
    if (_title1.positionInPoints.y <= -_title1.contentSizeInPoints.height * _title1.scaleYInPoints){
        
        [_title1 setPosition:ccp(_title1.positionInPoints.x, 0)];
        [_title2 setPosition:ccp(_title2.positionInPoints.x, _title2.contentSizeInPoints.height * _title2.scaleYInPoints)];
}
}



-(void)play {
    delete.visible = FALSE;
     tutorial.visible = TRUE;
    playLabel.visible = FALSE;
//    CCScene *play= [CCBReader loadAsScene:@"MainScene"];
//    [[CCDirector sharedDirector] replaceScene:play];
}

-(void)next {
 
        CCScene *next= [CCBReader loadAsScene:@"MainScene"];
        [[CCDirector sharedDirector] replaceScene:next];
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio playEffect:@"button.wav"];
}

@end
