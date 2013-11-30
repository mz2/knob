//
//  MPLeapController.m
//  Knob
//
//  Created by Matias Piipari on 30/11/2013.
//  Copyright (c) 2013 Still Ltd. All rights reserved.
//

#import "MPLeapController.h"

@interface MPLeapController ()
@property (readwrite) MPLeapControllerImpl *controller;
@end


@implementation MPLeapController

- (instancetype)init
{
    if (self = [super init])
    {
        _controllerHandle = new MPLeapControllerImpl(new Leap::Controller());
    }
    
    return self;
}

- (void)dealloc
{
    delete _controllerHandle;
}

@end
