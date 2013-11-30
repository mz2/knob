//
//  MPAppDelegate.h
//  Knob
//
//  Created by Matias Piipari on 30/11/2013.
//  Copyright (c) 2013 Still Ltd. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class BPODial;
@class KGNoiseLinearGradientView;

@interface MPAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (assign) IBOutlet KGNoiseLinearGradientView *windowBackgroundView;

@property (assign) IBOutlet BPODial *leftHandDial;
@property (assign) IBOutlet BPODial *rightHandDial;

@property (assign) IBOutlet NSPopUpButton *leftDialControlIndexPopup;
@property (assign) IBOutlet NSPopUpButton *rightDialControlIndexPopup;

- (IBAction)leftHandDialUpdated:(id)sender;
- (IBAction)rightHandDialUpdated:(id)sender;

@end
