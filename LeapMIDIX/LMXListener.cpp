//
//  Listener.cpp
//  LeapMIDIX
//
//  Created by Mischa Spiegelmock on 12/1/12.
//  Copyright (c) 2012 DBA int80. All rights reserved.
//

#include <memory>
#include <map>

#include "LMXListener.h"

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
    viz->init(this);
#endif
    
    // create default program
    FingerControlPtr controlProgram = make_shared<FingerControl>();
    controlProgram->initGestures();
    setProgram(controlProgram);
}

LMXListener::~LMXListener() {
    if (viz)
        delete viz;
    if (device)
        delete device;
}

void LMXListener::onGestureRecognized(const Leap::Controller &controller, GesturePtr gesture) {
    leapmidi::Listener::onGestureRecognized(controller, gesture);
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
    
    if (1) {
        cout << "recognized control index " << controlIndex
        << " (" << control->description() << ")"
        << ", raw value: "
        << control->rawValue() << " mapped value: " << val << endl;
    }
    
    device->addControlMessage(controlIndex, val);
}

void LMXListener::drawLoop() {
#ifdef LMX_VISUALIZER_ENABLED
    viz->drawLoop();
#else
    std::cin.get();
#endif
}

} // namespace leapmidi