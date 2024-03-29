//
//  LMXListener.cpp
//  LeapMIDIX
//
//  Created by Mischa Spiegelmock on 12/1/12.
//  Copyright (c) 2012 DBA int80. All rights reserved.
//

#include <memory>
#include <map>

#include "LMXListener.h"

#import <Foundation/Foundation.h>

namespace leapmidi {
    
LMXListener::LMXListener() {
    viz = NULL;
    device = NULL;
}

void LMXListener::init(Leap::Controller *controller) {
    std::cout << "Leap MIDI device initalized" << std::endl;
    
    // create virtual midi source
    device = new Device();
    device->init();
    
    viz = NULL;
#ifdef LMX_VISUALIZER_ENABLED
    // initialize visualizer
    viz = new Visualizer();
    viz->init(this, controller);
#endif
    
    // PROGRAM SETUP
    // Setting the current program by calling initGestures() will define
    // a new set of active gesture recognizers. We should add a UI to
    // let the user choose the current active program.
    
    // create default program
    //BallControlProgramPtr program = make_shared<BallControl>();
    FingerControlProgramPtr program = make_shared<FingerControl>();
    //    FingerNotePtr program = make_shared<FingerNote>();
//    BallControlProgramPtr program = make_shared<BallControl>();
    
    // load program's set of gesture recognizers
    program->initGestures(gestureRecognizers());
    
//    setProgram(noteProgram);
}

LMXListener::~LMXListener() {
    
#ifdef LMX_VISUALIZER_ENABLED
    if (viz)
        delete viz;
#endif
    if (device)
        delete device;
}

void LMXListener::onGestureRecognized(const Leap::Controller &controller, GesturePtr gesture) {
    leapmidi::Listener::onGestureRecognized(controller, gesture);
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"MPGestureRecognizerNotification"
    //                                                    object:@{@"controller:" : [NSValue valueWithPointer:&controller]}];
}

void LMXListener::onControlUpdated(const Leap::Controller &controller, GesturePtr gesture, ControlPtr control) {
    // call superclass method
    leapmidi::Listener::onControlUpdated(controller, gesture, control);
    
    // draw gesture and control output
    // ...
    
    // control
    leapmidi::midi_control_index controlIndex = control->controlIndex();
    
    // control value
    leapmidi::midi_control_value val = control->mappedValue();
    
    cout << "recognized control index " << controlIndex
    << " (" << control->handIndex() << " " << control->description() << ")"
    << ", raw value: "
    << control->rawValue() << " mapped value: " << val << endl;
    
    
    if (controlIndex != [[NSUserDefaults standardUserDefaults] integerForKey:@"leftControlIndex"]
        &&
        controlIndex != [[NSUserDefaults standardUserDefaults] integerForKey:@"rightControlIndex"])
    {
        return;
    }
    
    bool multithreaded = true;
    
    if (multithreaded)
        device->addControlMessage(controlIndex, val);
    else
        device->queueControlPacket(controlIndex, val);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MPControlMessageNotification"
                                                        object:@{@"controller":[NSValue valueWithPointer:&controller],
                                                                 @"handIndex":@(control->handIndex()),
                                                                 //@"fingerIndex":@(control->fingerIndex()),
                                                                 @"controlIndex":@(controlIndex), @"value":@(val)}];
}
    
void LMXListener::onNoteUpdated(const Leap::Controller &controller, GesturePtr gesture, NotePtr note) {
    // call superclass method
    leapmidi::Listener::onNoteUpdated(controller, gesture, note);
    
    // draw gesture and note output
    // ...
    
    // note
    leapmidi::midi_note_index noteIndex = note->noteIndex();
    // control value
    leapmidi::midi_note_value val = note->mappedValue();
    
    cout << "recognized note index " << noteIndex
        << " (" << note->description() << ")"
        << ", raw value: "
        << note->rawValue() << " mapped value: " << val << endl;
    
    device->addNoteMessage(noteIndex, val);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MPNoteMessageNotification"
                                                        object:@{@"controller":[NSValue valueWithPointer:&controller],
                                                                 @"index":@(noteIndex), @"value":@(val)}];
}


void LMXListener::drawLoop() {
#ifdef LMX_VISUALIZER_ENABLED
    viz->drawLoop();
#else
    std::cin.get();
#endif
}

} // namespace leapmidi