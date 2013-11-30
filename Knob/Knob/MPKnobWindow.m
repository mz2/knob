//
//  MPKnobWindow.m
//  Knob
//
//  Created by Matias Piipari on 30/11/2013.
//  Copyright (c) 2013 Still Ltd. All rights reserved.
//

#import "MPKnobWindow.h"

@implementation MPKnobWindow

- (id)initWithCoder:(NSCoder *)aDecoder
{
    return [super initWithCoder:aDecoder];
}

- (id)initWithContentRect:(NSRect)contentRect
                styleMask:(NSUInteger)aStyle
                  backing:(NSBackingStoreType)bufferingType
                    defer:(BOOL)flag
{
    if (self = [super initWithContentRect:contentRect
                                styleMask:aStyle
                                  backing:bufferingType
                                    defer:flag])
    {
        [self setAlphaValue:1.0];
        [self setOpaque:NO];
        [self setExcludedFromWindowsMenu:NO];
    }
    
    return self;
}

- (BOOL)isMovableByWindowBackground
{
    return YES;
}

@end
