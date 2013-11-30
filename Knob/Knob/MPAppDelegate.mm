//
//  MPAppDelegate.m
//  Knob
//
//  Created by Matias Piipari on 30/11/2013.
//  Copyright (c) 2013 Still Ltd. All rights reserved.
//

#import "MPAppDelegate.h"

#include <iostream>
#include <unistd.h>
#include <time.h>

#import "BPODial.h"
#import "KGNoise.h"

#include "LMXListener.h"
#include "MIDIListener.h"

#include <LeapMIDI.h>
#include <Leap.h>

#import "MPMIDIListener.h"
#import "MPLeapController.h"

@interface MPAppDelegate ()
@property (strong, readwrite) MPMIDIListener *listener;
@end

@implementation MPAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    [self initializeDial:self.leftHandDial];
    [self initializeDial:self.rightHandDial];
    
    self.windowBackgroundView.backgroundColor = [NSColor colorWithWhite:0.0 alpha:0.1];
    //self.windowBackgroundView.noiseOpacity = 0.01;
    
    [self.window makeKeyAndOrderFront:self];
    [NSApp activateIgnoringOtherApps:YES];
    
    // start listening for events
    self.listener = [[MPMIDIListener alloc] init];
}

- (void)initializeDial:(BPODial *)dial
{
    dial.numberOfTickMarks = 16;
    dial.tickMarkRadius = 5.0f;
    dial.apertureInDegrees = 270.0f;
    dial.minLabel = @"MIN";
    dial.maxLabel = @"MAX";
}

- (void)windowDidResignMain:(NSNotification *)notification
{
    // It's always nicer if the user has a choice
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"DefaultAlwaysOnTop"] == YES) {
        [[self window] setLevel:NSFloatingWindowLevel];
    } else {
        [[self window] setLevel:NSNormalWindowLevel];
    }
}

- (IBAction)leftHandDialUpdated:(id)sender
{
    
}

- (IBAction)rightHandDialUpdated:(id)sender
{
    
}

@end
