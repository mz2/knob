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

@property (strong, readwrite) id controllerMessageObserver;
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
    
    [self initializePopupButton:self.leftDialControlIndexPopup tag:0];
    [self initializePopupButton:self.rightDialControlIndexPopup tag:1];
    
    __weak MPAppDelegate *slf = self;
    
    // start listening for events
    self.controllerMessageObserver = [[NSNotificationCenter defaultCenter] addObserverForName:@"MPControlMessageNotification"
                                                                                       object:nil
                                                                                        queue:[NSOperationQueue mainQueue]
                                                                                   usingBlock:^(NSNotification *note)
    {
        NSUInteger controlIndex = [[note.object objectForKey:@"controlIndex"] unsignedIntegerValue];
        NSUInteger handIndex = [[note.object objectForKey:@"handIndex"] unsignedIntegerValue];
        NSUInteger value = [[note.object objectForKey:@"value"] unsignedIntegerValue];
        
        MPAppDelegate *strongSelf = slf;

        //NSLog(@"Hand: %lu, control index: %lu, value: %lu", handIndex, controlIndex, value);

        //NSUInteger leftI = [[NSUserDefaults standardUserDefaults] integerForKey:@"leftControlIndex"];
        //NSUInteger rightI = [[NSUserDefaults standardUserDefaults] integerForKey:@"rightControlIndex"];

        if (controlIndex == 19)
        {
            [strongSelf.leftHandDial setIntegerValue:value];
        }
        else
        {
            [strongSelf.rightHandDial setIntegerValue:value];
        }
    }];
    
    self.listener = [[MPMIDIListener alloc] init];
    
    
}

- (void)initializePopupButton:(NSPopUpButton *)popup tag:(NSUInteger)tag
{
    [popup.menu removeAllItems];
    
    for (NSUInteger i = 0; i < 50; i++)
    {
        NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:[NSString stringWithFormat:@"%lu", i]
                                                      action:@selector(selectIndex:)
                                               keyEquivalent:@""];
        item.tag = tag;
        [popup.menu addItem:item];
        
        if (tag == 0
            && i == [[NSUserDefaults standardUserDefaults] integerForKey:@"leftControlIndex"])
            [popup selectItem:item];
        else if
            (tag == 1
             && i == [[NSUserDefaults standardUserDefaults] integerForKey:@"rightControlIndex"])
            [popup selectItem:item];
    }
}

- (void)selectIndex:(NSMenuItem *)item
{
    NSUInteger index = [item.title integerValue];
    NSUInteger tag = item.tag;
    
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    [defs setValue:@(index) forKey:tag == 0 ? @"leftControlIndex" : @"rightControlIndex"];
    [defs synchronize];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self.controllerMessageObserver];
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
