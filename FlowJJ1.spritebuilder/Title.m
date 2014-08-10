//
//  Title.m
//  FlowJJ1
//
//  Created by Jason Hoang on 8/9/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "Title.h"


@implementation Title

-(void)play {
    CCScene *play= [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:play];
}

@end
