//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Jason Hoang
//
//

#import "MainScene.h"
//scrolling speed IS THIS STILL NEEDED?!
static const CGFloat scrollSpeed = 80.f;
@implementation MainScene {
    CCSprite *_green;
    CCSprite *_red;
    CCPhysicsNode *_physicsNode;
    CCNode *_ground1;
    CCNode *_ground2;
    NSArray *_grounds;
    CCNode *_leftSide;
    CCNode *_rightSide;
}


-(void)didLoadFromCCB {
    self.userInteractionEnabled = TRUE;
    _grounds =@[_ground1,_ground2];
      self.multipleTouchEnabled = YES;
    
}
//// This moves the red and green with each touch
//-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
//    [_green.physicsBody applyImpulse:ccp(0, 400.f)];
//    [_red.physicsBody applyImpulse:ccp(0, 400.f)];
//
//}


- (void)update:(CCTime)delta {
    //positioning for the green and red thingy majig
    _green.position = ccp(_green.position.x, _green.position.y - delta * scrollSpeed);
    _red.position = ccp(_red.position.x, _red.position.y - delta * scrollSpeed);
    //The direction of the background moving
    _physicsNode.position = ccp(_physicsNode.position.x, _physicsNode.position.y  - (scrollSpeed *delta));
    for (CCNode *ground in _grounds) {
        ground.position = ccp(ground.position.x, ground.position.y - 1);
            //Loops the two backgrounds endlessly
                if (ground.position.y <= (-1 * (ground.contentSize.height*2))) {
                    ground.position = ccp(ground.position.x, ground.position.y +
                                              2 * (ground.contentSize.height*2));
                }
            }
    }





@end
