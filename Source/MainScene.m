//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Jason Hoang
//
//

#import "MainScene.h"
//scrolling speed
static const CGFloat scrollSpeed = 5.f;
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
}


-(void)didLoadFromCCB {
 
    self.userInteractionEnabled = TRUE;
    _grounds =@[_ground1,_ground2];
      self.multipleTouchEnabled = YES;
}



////// Rounded Rectangle Drawing
//UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(49.5, 28.5, 66, 35) cornerRadius: 4];
//[fillColor setFill];
//[roundedRectanglePath fill];
//[strokeColor setStroke];
//roundedRectanglePath.lineWidth = 1;
//[roundedRectanglePath stroke];
//self roundedRectanglePath




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
    //positioning for the green and red thingy majig
    _green.position = ccp(_green.position.x, _green.position.y - delta * scrollSpeed);
    _red.position = ccp(_red.position.x, _red.position.y - delta * scrollSpeed);
//    //The direction of the background moving
//    _physicsNode.position = ccp(_physicsNode.position.x, _physicsNode.position.y  - (scrollSpeed *delta));
    for (CCNode *ground in _grounds) {
        //Determines the speed of the background
        ground.position = ccp(ground.position.x, ground.position.y - scrollSpeed);
            //Loops the two backgrounds endlessly
                if (ground.position.y <= (-1 * (ground.contentSize.height*2))) {
                    ground.position = ccp(ground.position.x, ground.position.y +
                                              2 * (ground.contentSize.height*2));
                }
            }
    }


@end
