//
//  MPKnobWindowBackgroundView.m
//  Knob
//
//  Created by Matias Piipari on 30/11/2013.
//  Copyright (c) 2013 Still Ltd. All rights reserved.
//

#import "MPKnobWindowBackgroundView.h"

@implementation MPKnobWindowBackgroundView

- (void)drawRect:(NSRect)frame
{
    [[NSColor clearColor] set];
    NSRectFill([self frame]);
    
    NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:frame
                                                         xRadius:20.0 yRadius:20.0];
    [[NSColor colorWithWhite:1.0 alpha:1.0] set];
    
    [path fill];
}

@end