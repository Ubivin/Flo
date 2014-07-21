//
//  DrawView.m
//  FlowJJ1
//
//  Created by Jason Hoang on 7/18/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
 //// Color Declarations
 UIColor* fillColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
 UIColor* strokeColor = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1];
 
 //// Rectangle Drawing
 UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(52.5, 31.5, 47, 37)];
 [fillColor setFill];
 [rectanglePath fill];
 [strokeColor setStroke];
 rectanglePath.lineWidth = 1;
 [rectanglePath stroke];
   
}


@end
