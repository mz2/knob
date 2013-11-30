//
//  MPLeapController.h
//  Knob
//
//  Created by Matias Piipari on 30/11/2013.
//  Copyright (c) 2013 Still Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <LeapMIDI.h>
#import <Leap.h>

struct MPLeapControllerImpl
{
    Leap::Controller *impl;
    MPLeapControllerImpl(Leap::Controller *c) { impl = c; }
    ~MPLeapControllerImpl() { delete impl; }
};

@interface MPLeapController : NSObject
@property (readonly) MPLeapControllerImpl *controllerHandle;
@end
