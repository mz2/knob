//
//  MPMIDIListener.h
//  Knob
//
//  Created by Matias Piipari on 30/11/2013.
//  Copyright (c) 2013 Still Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MPLeapController.h"

@interface MPMIDIListener : NSObject
@property (readonly, strong) MPLeapController *controller;
@end