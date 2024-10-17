# Project Goal

Spoken word wav file over randomized sequencer from osc messages. Ambient sounds and sfx would accompany spoken word. 

# Day 1
I am going to use the code-along and documentation files on the CPP repository for references. I also have some transformed/modified code-along code:

From OSC code-along:

    void ofApp::draw(){
    if (ofGetMousePressed(OF_MOUSE_BUTTON_LEFT)) {  // If the left mouse button is pressed...
        ofSetRectMode(OF_RECTMODE_CENTER);
        float randomColor = ofRandom(50, 255);
        float randomColor1 = ofRandom(50, 100);
        float randomColor2 = ofRandom(50, 50);
        int numRects = 10;
        int maxRadius = 40;  // Increase for a wider brush
        int radiusStepSize = 3;  // Decrease for more circles (i.e. a more opaque brush)
        int alpha = 10;  // Increase for a more opaque brush
        int maxOffsetDistance = 75;  // Increase for a larger spread of circles
    // draw smaller and smaller circles and layering (increasing) opaqueness
        for (int radius=maxRadius; radius>0; radius-=radiusStepSize) {
            float angle = ofRandom(ofDegToRad(360.0));
            float distance = ofRandom(maxOffsetDistance);
            float xOffset = cos(angle) * distance;
            float yOffset = sin(angle) * distance;
            ofSetColor(randomColor,randomColor1,randomColor2, alpha);
            ofDrawCircle(ofGetMouseX()+xOffset, ofGetMouseY()+yOffset, radius);
    }
        }

        if (ofGetMousePressed(OF_MOUSE_BUTTON_RIGHT)) {  // If the right mouse button is pressed...
        ofBackground(0);  // Draw a black background over the screen
        }
    }
and

    void ofApp::draw(){
    if (ofGetMousePressed(OF_MOUSE_BUTTON_LEFT)) {  // If the left mouse button is pressed...
        ofSetRectMode(OF_RECTMODE_CENTER);
        float randomColor = ofRandom(50, 255);
        float randomColor1 = ofRandom(50, 100);
        float randomColor2 = ofRandom(50, 50);
        int numRects = 10;
        int maxRadius = 40;  // Increase for a wider brush
        int radiusStepSize = 3;  // Decrease for more circles (i.e. a more opaque brush)
        int alpha = 10;  // Increase for a more opaque brush
        int maxOffsetDistance = 75;  // Increase for a larger spread of circles
    // draw smaller and smaller circles and layering (increasing) opaqueness
        for (int radius=maxRadius; radius>0; radius-=radiusStepSize) {
            float angle = ofRandom(ofDegToRad(360.0));
            float distance = ofRandom(maxOffsetDistance);
            float xOffset = cos(angle) * distance;
            float yOffset = sin(angle) * distance;
            ofSetColor(randomColor,randomColor1,randomColor2, alpha);
            ofDrawCircle(ofGetMouseX()+xOffset, ofGetMouseY()+yOffset, radius);
    }
        }

        if (ofGetMousePressed(OF_MOUSE_BUTTON_RIGHT)) {  // If the left mouse button is pressed...
        ofSetRectMode(OF_RECTMODE_CENTER);
        float randomColor = ofRandom(50, 255);
        float randomColor1 = ofRandom(50, 255);
        float randomColor2 = ofRandom(50, 255);
        int numRects = 10;
        int maxRadius = 40;  // Increase for a wider brush
        int radiusStepSize = 3;  // Decrease for more circles (i.e. a more opaque brush)
        int alpha = 10;  // Increase for a more opaque brush
        int maxOffsetDistance = 75;  // Increase for a larger spread of circles
    // draw smaller and smaller circles and layering (increasing) opaqueness
        for (int radius=maxRadius; radius>0; radius-=radiusStepSize) {
            float angle = ofRandom(ofDegToRad(360.0));
            float distance = ofRandom(maxOffsetDistance);
            float xOffset = cos(angle) * distance;
            float yOffset = sin(angle) * distance;
            ofSetColor(randomColor,randomColor1,randomColor2, alpha);
            ofDrawCircle(ofGetMouseX()+xOffset, ofGetMouseY()+yOffset, radius);
    }
        }
    }

From FFT code-along: 

    void ofApp::draw(){
    for (int i = 0; i < bands; i++){
    ofDrawCircle(ofGetWidth()/2, ofGetHeight()/2, fft[i]*1000);
    }
    gui.draw();

    int alpha = 50;
    int maxRadius = 1000;
    int radiusStepSize = 3;
    int maxOffsetDistance = 125;
    for (int radius=maxRadius; radius>0; radius-=radiusStepSize) {
            float angle = ofRandom(ofDegToRad(360.0));
            float distance = ofRandom(maxOffsetDistance);
            float xOffset = cos(angle) * distance;
            float yOffset = sin(angle) * distance;
            ofSetColor(distance, 255, 150, alpha);
            
    }
    }

and

    void ofApp::draw(){
    ofTranslate(256, 192);
    for (int i = 0; i < bands; i+=16) {
    ofPolyline polyline;
    for (int j = 0; j < bands; j++) {
        polyline.addVertex(j, i - fft[j] * 100.0);
    }
    polyline.draw();

        float randomColor = ofRandom(50, 255);
        float randomColor1 = ofRandom(50, 255);
        float randomColor2 = ofRandom(50, 255);
        ofSetColor(randomColor,randomColor1,randomColor2, 90);

    }
    }

