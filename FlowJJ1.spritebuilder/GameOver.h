//
//  GameOver.h
//  FlowJJ1
//
//  Created by Jason Hoang on 8/8/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameOver : CCNode

@property (nonatomic, copy) NSString *nextLevelName;
@property(nonatomic, assign) CCLabelTTF *_highScoreLabel;

@end
