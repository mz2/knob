//
//  MPMIDIListener.m
//  Knob
//
//  Created by Matias Piipari on 30/11/2013.
//  Copyright (c) 2013 Still Ltd. All rights reserved.
//

#import "MPMIDIListener.h"

#include "LMXListener.h"

#include <LeapMIDI.h>
#include <Leap.h>

struct MPMIDIListenerImpl
{
    leapmidi::LMXListener *impl;
    MPMIDIListenerImpl(leapmidi::LMXListener *l) { impl = l; }
    ~MPMIDIListenerImpl() { delete impl; }
};

@interface MPMIDIListener ()
@property (readwrite) MPMIDIListenerImpl *listenerHandle;
@end

@implementation MPMIDIListener

- (instancetype)init
{
    if (self = [super init])
    {
        _listenerHandle = new MPMIDIListenerImpl(new leapmidi::LMXListener());
        _controller = [[MPLeapController alloc] init];
        
        _listenerHandle->impl->init(_controller.controllerHandle->impl);
        _controller.controllerHandle->impl->addListener(*_listenerHandle->impl);
        _controller.controllerHandle->impl->setPolicyFlags(Leap::Controller::PolicyFlag::POLICY_BACKGROUND_FRAMES);
        _controller.controllerHandle->impl->enableGesture(Leap::Gesture::TYPE_SWIPE);
    }
    
    return self;
}

- (void)dealloc
{
    delete _listenerHandle;
}

@end