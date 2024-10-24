# Project Goal

Spoken word wav file over randomized sequencer from OSC messages.

# Day 1
I am going to use the code-along and documentation files on the CPP repository for references. I also have some transformed/modified code-along code:

From first code-along:

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
("brush" now changes colors)

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
(made the right mouse click also generate circles, creating two different brushes with no way to clear the canvas)

From OSC code-along:

    void ofApp::draw(){
    int alpha = 50;
    int maxRadius = 100;
    int radiusStepSize = 3;
    int maxOffsetDistance = 125;
    for (int radius=maxRadius; radius>0; radius-=radiusStepSize) {
            float angle = ofRandom(ofDegToRad(360.0));
            float distance = ofRandom(maxOffsetDistance);
            float xOffset = cos(angle) * distance;
            float yOffset = sin(angle) * distance;
            ofDrawCircle(oscx+400, oscy+200, radius);
            ofDrawCircle(distance, distance, 30);
            ofDrawRectangle(distance, distance+40, 50, 100);
            ofDrawCircle(distance*100, -distance*100, 30);
            ofDrawRectangle(distance*100, distance*100+40, 50, 100);
            ofSetColor(oscy, oscx, 150, alpha);
         }
    }
(added glitchy "people" and colors)

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
(changes color of the FFT-responsive circle)

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
(polyline now changes colors)

(I HAD FUN WITH COLORS)

# Day 2
I found the audio files I wanted to use for the project. I'm going to make a piece about how editing voice overs is hell. I have included a beatiful voice over file from the game "Chaos Wars." The English dub was poorly produced and underfunded. I separated each character's lines and exported them as wav files. I've also inlcluded a click track to showcase how project settings can be wrong when I receive the session. I made sure to change the 44.1 kHz to 48 kHz to reflect what happens when indie game developers are put in charge of recording VO (no shade). I generated my project and moved the wav files into the data folder in the project.

# Day 3
I copied and pasted the FFT example's header lines into the ofApp.h of my nightmare VO project. I then tried to remember which example had the re-scaling feature and went through a couple examples. Didn't want to waste any more time and continued to work on the FFT part of the project. I copied and pasted the setup of the FFT example and replaced the sound.load file name with all of my audio files (four in total.) I tried to run the project, but there could only be two arguments made in sound.load. Maybe this is where I should've looked up at the documentation, buuuuuut I used the first two audio files. I built and ran the project, and it only played the first audio file. I looked up the [documentation](https://openframeworks.cc/documentation/sound/ofSoundPlayer/#!show_load) and saw that the second argument is for a bool. I individually loaded my audio files like so:

    void ofApp::setup(){
    ofEnableAlphaBlending();
    sound.load("VO1.wav");
    sound.load("V02.wav");
    sound.load("VO3.wav");
    sound.load("VO4.wav");
    sound.play();
    sound.setLoop(true);

    gui.setup();
    gui.add(audioamplitude.set("audioamplitude", 0.5, 0.0, 1.0));
    gui.add(visualdecay.set("visualdecay", 0.5, 0.0, 1.0));

    fft = new float[128];
    for (int i = 0; i < 128; i++){
    fft[i] = 0;
    }
    bands = 64;
    }

and... NO AUDIO! YAY!!!! I searched "How to play multiple audio files openframeworks" and [this](https://stackoverflow.com/questions/23481526/synchronizing-music-files-in-openframeworks) popped up. It made me groan because I do the same thing (create different audio players) when coding in Unity and didn't realize it was the same. Using this forum post, I changed my ofApp.h to look like this:

    #pragma once

    #include "ofMain.h"
    #include "ofxGui.h"

    class ofApp : public ofBaseApp{

        public:
            void setup() override;
            void update() override;
            void draw() override;
            void exit() override;

            void keyPressed(int key) override;
            void keyReleased(int key) override;
            void mouseMoved(int x, int y ) override;
            void mouseDragged(int x, int y, int button) override;
            void mousePressed(int x, int y, int button) override;
            void mouseReleased(int x, int y, int button) override;
            void mouseScrolled(int x, int y, float scrollX, float scrollY) override;
            void mouseEntered(int x, int y) override;
            void mouseExited(int x, int y) override;
            void windowResized(int w, int h) override;
            void dragEvent(ofDragInfo dragInfo) override;
            void gotMessage(ofMessage msg) override;
            
            ofxPanel gui;
            ofParameter<float> audioamplitude;
            ofParameter<float> visualdecay;

            ofSoundPlayer VO1, V02, VO3, VO4;

            float * fft;
            float * soundSpectrum;
            int bands;
    };
and changed my ofApp.cpp to:

    #include "ofApp.h"
    #include "ofxGui.h"

    //--------------------------------------------------------------
    void ofApp::setup(){
    ofEnableAlphaBlending();
    VO1.load("VO1.wav");
    VO2.load("VO2.wav");
    VO3.load("VO3.wav");
    VO4.load("VO4.wav");
    VO1.play();
    VO2.play();
    VO3.play();
    VO4.play();
    VO1.setLoop(false);
    VO2.setLoop(false);
    VO3.setLoop(false);
    VO4.setLoop(false);

    gui.setup();
    gui.add(audioamplitude.set("audioamplitude", 0.5, 0.0, 1.0));
    gui.add(visualdecay.set("visualdecay", 0.5, 0.0, 1.0));

    fft = new float[128];
    for (int i = 0; i < 128; i++){
    fft[i] = 0;
    }
    bands = 64;
    }

I added the metronome wav file after setting up the dialogue/VO layers. Tomorrow, I'm going figure out how to make the image resize itself, [how to trigger the audio using a computer keyboard](https://openframeworks.cc/ofBook/chapters/sound.html), and what I want the OSC sequencer to do.

# Day 4
OSC Sequencer time! I copied the sequencer Rachel gave us and opened Logic. I looked for fx that sounded like someone talking. "Dinoboss Downer" worked pretty well for this idea. I also looked for white noise with a little tonality to capture interference that's captured during low-budget VO recording sessions. After finding the plugin that did this ("In Africa [Sadistic]" weird name), I adjusted the gains to my liking and added a lowpass filter on Dinoboss to make it sound like the "conversation" was happening in another room. I found that if I click on the static/interference track and then the talking track, the static track would continue to play. YAY! Two instruments, one MIDI transfer. I built and ran the project and the audio levels were almost perfect. I just needed to turn down the metronome. I just rebounced the metronome file with a lower volume. Easier to edit the asset than the code right now. 

Now that all the audio levels are sound, I worked on the [window resizer](https://openframeworks.cc/documentation/application/ofBaseApp/#show_windowResized). I took a look at the documentation and created: 

    		void onWindowResized(ofResizeEventArgs &resize);

to add to the header. I knew it wasn't going to be this easy, so I took the logic I learned in Unity for Musicians and applied it here. I renamed the event on the source file:

    void ofApp::onWindowResized(ofResizeEventArgs &resize)

and also added new integers

    int newWidth = resize.width;
    int newHeight = resize.height;

I wasn't sure if this alone would work, so I looked up if there were any listeners and found some [documentation](https://openframeworks.cc/documentation/events/ofEventUtils/#!show_ofAddListener). I saw that it references events, so I thought it would be applicable to what I'm trying to do. I messaged my friend Willow to come take a look at it, and she told me that I just needed to add the event, reference which file is affected (this), and add the & part of the argument to the setup:

    ofAddListener(ofEvents().windowResized, this, &ofApp::onWindowResized);

I took the Basic Shapes example, copied and pasted it into the draw event, and tried it. The shapes did not resize :( I will keep looking into this.

I went to Rachel's office hours, and we found the file for the scaling. Using the example, I fixed my project and here's what it looks like now:

header:
    #pragma once

    #include "ofMain.h"
    #include "ofxGui.h"

    class ofApp : public ofBaseApp{

        public:
            void setup() override;
            void update() override;
            void draw() override;
            void exit() override;

            void keyPressed(int key) override;
            void keyReleased(int key) override;
            void mouseMoved(int x, int y ) override;
            void mouseDragged(int x, int y, int button) override;
            void mousePressed(int x, int y, int button) override;
            void mouseReleased(int x, int y, int button) override;
            void mouseScrolled(int x, int y, float scrollX, float scrollY) override;
            void mouseEntered(int x, int y) override;
            void mouseExited(int x, int y) override;
            void windowResized(int w, int h);
            void dragEvent(ofDragInfo dragInfo) override;
            void gotMessage(ofMessage msg) override;
            
            ofxPanel gui;
            ofParameter<float> audioamplitude;
            ofParameter<float> visualdecay;

            ofSoundPlayer VO1, VO2, VO3, VO4, met;

            float timeScale;
            float clearAlpha;


            float * fft;
            float * soundSpectrum;
            int bands;
    };

source file:

    #include "ofApp.h"
    #include "ofxGui.h"

    //--------------------------------------------------------------
    void ofApp::setup(){
    ofEnableAlphaBlending();
    VO1.load("VO1.wav");
    VO2.load("VO2.wav");
    VO3.load("VO3.wav");
    VO4.load("VO4.wav");
    met.load("met.wav");
    VO1.play();
    VO2.play();
    VO3.play();
    VO4.play();
    met.play();
    VO1.setLoop(false);
    VO2.setLoop(false);
    VO3.setLoop(false);
    VO4.setLoop(false);
    met.setLoop(false);

    gui.setup();
    gui.add(audioamplitude.set("audioamplitude", 0.5, 0.0, 1.0));
    gui.add(visualdecay.set("visualdecay", 0.5, 0.0, 1.0));

    fft = new float[128];
    for (int i = 0; i < 128; i++){
    fft[i] = 0;
    }
    bands = 64;
    }

    //--------------------------------------------------------------
    void ofApp::update(){

    }

    //--------------------------------------------------------------
    void ofApp::draw(){

        // Reverse the contrast of the rectangles and screen over time
        ofColor darkColor(0,0,0,255);  // Opaque black
        ofColor lightColor(255,255,255,255);  // Opaque white
        float time = ofGetElapsedTimef();  // Time in seconds
        float percent = ofMap(cos(time/2.0), -1, 1, 0, 1);  // Create a value that oscillates between 0 to 1
        ofColor bgColor = darkColor;  // Color for the transparent rectangle we use to clear the screen
        bgColor.lerp(lightColor, percent);  // This modifies our color "in place", check out the documentation page
        bgColor.a = clearAlpha;  // Our initial colors were opaque, but our rectangle needs to be transparent
        ofColor fgColor = lightColor;  // Color for the rectangle outlines
        fgColor.lerp(darkColor, percent);  // Modifies color in place

        // Semi-clear the screen, using a transparent rectangle
        ofSetColor(bgColor);
        ofSetRectMode(OF_RECTMODE_CORNER);
        ofFill();
        ofDrawRectangle(0, 0, ofGetWidth(), ofGetHeight());  // ofBackground doesn't work with alpha, so draw a transparent rect

        // Draw the spiraling rectangles
        ofSetRectMode(OF_RECTMODE_CENTER);
        ofSetColor(fgColor);
        ofNoFill();
        ofPushMatrix();
            ofTranslate(ofGetWidth()/2, ofGetHeight()/2);  // Translate to the center of the screen
            for (int i=0; i<100; i++) {
                // Draw the smallest rectangle first and scale out to bigger ones progressively
                ofScale(1.1, 1.1);

                // Make the rectangles spiral
                float time = ofGetElapsedTimef();
                float noise = ofSignedNoise(time * timeScale) * 20.0;
                ofRotate(noise);

                ofDrawRectangle(0, 0, 50, 50);
            }
        ofPopMatrix();
    }


I then added the lines that allow the project to receive OSC messages. I imported the code from the OSC example and my exploration of it (see above) into the project. The graphics coincidentally fit well with my project's theme, so I think I'm going to keep them as is. I also decided to make the metronome play when I press "p" rather than having it play from the start and make it stop when I press "m." I tried mapping the audio to spacebar initially, but there's apparently [no spacebar option](https://openframeworks.cc/documentation/application/ofBaseApp/#!show_keyPressed). I used my C# knowledge to set up the play and stop functions for the metronome audio file, and they worked! Additionally, I added a polyline to reflect the FFT. I played around with the number of bands and found that 512 bands yielded the best visuals for my project. I tried a 10000 bands and that crashed the project haha. I attempted to find a way to make the polyline take over the whole screen, but I wasn't sure how to do that without increasing the number of bands/crashing the project.


Okay, I cleaned up my code, and here's what I have now:


    #include "ofApp.h"
    #include "ofxGui.h"

    //--------------------------------------------------------------
    void ofApp::setup(){
    ofEnableAlphaBlending();
    sender.setup("localhost", 12345);
    receiver.setup(12345);
    VO1.load("VO1.wav");
    VO2.load("VO2.wav");
    VO3.load("VO3.wav");
    VO4.load("VO4.wav");
    met.load("met.wav");
    VO1.play();
    VO2.play();
    VO3.play();
    VO4.play();
    VO1.setLoop(false);
    VO2.setLoop(false);
    VO3.setLoop(false);
    VO4.setLoop(false);

    fft = new float[512];
    for (int i = 0; i < 512; i++){
    fft[i] = 0;
    }
    bands = 512;
    }
    //--------------------------------------------------------------
    void ofApp::update(){
    ofSoundUpdate();
    
    soundSpectrum = ofSoundGetSpectrum(bands);
    for (int i = 0; i < bands; i++) {
        fft[i] *= 0.9;
        if (fft[i] < soundSpectrum[i]) {
        fft[i] = soundSpectrum[i];
        }
    }
    while(receiver.hasWaitingMessages()){
        ofxOscMessage msg;
        receiver.getNextMessage(msg);
        if (msg.getAddress() == "/x"){
        oscx = msg.getArgAsFloat(0);
        }
        if (msg.getAddress() == "/y"){
        oscy = msg.getArgAsFloat(0);
        }
    }
    }

    //--------------------------------------------------------------
    void ofApp::draw(){
    //osc ball and accompanying human thng
    int alpha = 50;
    int maxRadius = 100;
    int radiusStepSize = 3;
    int maxOffsetDistance = 125;
    for (int radius=maxRadius; radius>0; radius-=radiusStepSize) {
            float angle = ofRandom(ofDegToRad(360.0));
            float distance = ofRandom(maxOffsetDistance);
            float xOffset = cos(angle) * distance;
            float yOffset = sin(angle) * distance;
            ofDrawCircle(oscx+400, oscy+200, radius);
            ofDrawCircle(distance, distance, 30);
            ofDrawRectangle(distance, distance+40, 50, 100);
            ofDrawCircle(distance*100, -distance*100, 30);
            ofDrawRectangle(distance*100, distance*100+40, 50, 100);
            ofSetColor(oscy, oscx, 150, alpha);
    }
    // polyline
    ofSetRectMode(OF_RECTMODE_CENTER);
    float centerX = ofGetWidth() / 2;
    float centerY = ofGetHeight() / 2;
        for (int i = 0; i < bands; i+=16) {
        ofPolyline polyline;
        for (int j = 0; j < bands; j++) {
        polyline.addVertex(j + centerX - (bands / 2), centerY - (i - fft[j] * 100.0));
    }
    polyline.draw();

        float randomColor = ofRandom(50, 255);
        float randomColor1 = ofRandom(50, 255);
        float randomColor2 = ofRandom(50, 255);
        ofSetColor(randomColor,randomColor1,randomColor2, 90);
    }
    //rectangles in the background
        ofColor darkColor(0,0,0,255);  
        ofColor lightColor(255,255,255,255);
        float time = ofGetElapsedTimef(); 
        float percent = ofMap(cos(time/2.0), -1, 1, 0, 1); 
        ofColor bgColor = darkColor;  
        bgColor.lerp(lightColor, percent); 
        bgColor.a = clearAlpha;  
        ofColor fgColor = lightColor;  
        fgColor.lerp(darkColor, percent); 

        ofSetColor(bgColor);
        ofSetRectMode(OF_RECTMODE_CORNER);
        ofFill();
        ofDrawRectangle(0, 0, ofGetWidth(), ofGetHeight());  

        ofSetRectMode(OF_RECTMODE_CENTER);
        ofSetColor(fgColor);
        ofNoFill();
        ofPushMatrix();
            ofTranslate(ofGetWidth()/2, ofGetHeight()/2);
            for (int i=0; i<100; i++) {
                ofScale(1.1, 1.1);
                float time = ofGetElapsedTimef();
                float noise = ofSignedNoise(time * timeScale) * 20.0;
                ofRotate(noise);
                ofDrawRectangle(0, 0, 50, 50);
            }
        ofPopMatrix();
    }


    //--------------------------------------------------------------
    void ofApp::exit(){

    }

    //--------------------------------------------------------------
    void ofApp::keyPressed(int key){
        if (key == 'p'){
            met.play();
        }
        if (key == 'm'){
            met.stop();
        }
    }

To end the day. I added icoshperes to represent the audio as well. Cooper showed me this really cool way to translate and rotate the icospheres:

    void ofApp::draw(){
    ofNoFill();
    ofSetLineWidth(2);
    ofSetIcoSphereResolution(1);
    ofSetRectMode(OF_RECTMODE_CENTER);
        for (int i = 0; i < 10; i++)
        {
            ofPushMatrix();
            ofTranslate(ofGetWidth()/12*(i+1), ofGetHeight()/2);
            ofRotateDeg(ofGetElapsedTimef()*i*4);
            ofDrawIcoSphere(0, 0, 0, 50);
            ofPopMatrix();
        }
    }

I adapted this idea and turned it into this:

    ofNoFill();
    ofSetColor(255,255,255,255);
    ofSetLineWidth(2);
    ofSetIcoSphereResolution(1);
    ofSetRectMode(OF_RECTMODE_CENTER);
        for (int i = 0; i < 10; i++)
        {
            ofPushMatrix();
            ofTranslate(ofGetWidth()/12*(i+1.5), ofGetHeight()/2);
            ofRotateDeg(ofGetElapsedTimef()*i*fft[i]);
            ofDrawIcoSphere(0, 50, 0, 50);
            ofPopMatrix();
        }

I wanted the icospheres to be white so that they didn't clash with anything happening in the background. I added .5 to the ofTranslate argument to better center the icospheres. I also wanted them to react to the audio, so I added the FFT in the ofRotateDeg's argument. The 50 in the second argument is a preference thing. IDK, I just liked it when I tested it.

I was chatting with Cooper while writing the documentation for today and when I explained to them that I wanted to map different wav files to different graphics, they suggested:

    "maybe you could just make a second soundspectrum, then when you set each one with the ofSoundGetSpectrum function

    you set all the audios you dont want included to a volume of 0, then set them back to regular audioamplitude before the end of update

    this would also mean making a second float * fft;

    although it can prob still just use one for loop to assign both of them tho"

I will explore this tomorrow if I have the time :)

# Day 5
Hello, I have had a migraine all day,  so I haven't been able to touch this project due to its migraine-inducing visuals and audio. HOWEVER, what I can do in the final 20 hours, is consult Cooper. There is something missing from this project, and I don't know what. I sent Cooper a video recording of my project, and they said:

    i think the actual connectivity between the audio and the visuals ur doing is very cool, but i wish the visuals were a bit more cohesive, i like each piece of it individually, but what if they worked together to form a singular visual stucture, y'know?

So I decided to add a picture of Cubase with all of the audio files for this project inside of it. I added "ofImage cube;" to the header file and wrote "cube.draw(ofGetWidth()/2, ofGetHeight()/2);" I didn't use the example's arguments for the draw function because I liked where the image was placed in relation to the other elements on the canvas when it is centered. 

I ran the project and didn't like how bright the image was. I looked up how to change the transparency of images and found [this](https://procomputingproducts.co.uk/post/set-transparency-of-an-image-on-open-frameworks). I didn't realize you could apply ofSetColor to an image. I darkened the image and also changed the alpha value. This messed up my OSC graphics, so I added another ofSetColor below and rearranged the other ofSetColor.

    //cubase
    ofSetColor(175, 175, 175, 25);
    cube.draw(ofGetWidth()/2, ofGetHeight()/2);
    //osc ball and accompanying human thng
    ofSetColor(255, 255, 255, 255);
    int maxRadius = 100;
    int radiusStepSize = 3;
    int maxOffsetDistance = 125;
    for (int radius=maxRadius; radius>0; radius-=radiusStepSize) {
            float angle = ofRandom(ofDegToRad(360.0));
            float distance = ofRandom(maxOffsetDistance);
            float xOffset = cos(angle) * distance;
            float yOffset = sin(angle) * distance;
            ofDrawCircle(oscx+400, oscy+200, radius);
            ofDrawCircle(distance, distance, 30);
            ofSetColor(oscy, oscx, 150, 255);
            ofDrawRectangle(distance, distance+40, 50, 100);
            ofDrawCircle(distance*100, -distance*100, 30);
            ofDrawRectangle(distance*100, distance*100+40, 50, 100);
    }

I then cleaned and reformatted the source file and called it a day. My brain is pounding.

# Day 6
I had my high school friends review the project, and a lot of my intentions were clear. I realized that I haven't really been documenting the intention behind the art, so I'm going to do that now.

![image](https://github.com/smallsounds/MTECFA2024/blob/main/neilsmall%3Acpp%3Aoscfft/READMEpic/vo.png)

The image of Cubase in the background shows how all the elements are about voice over editing. The "people" flashing on the side show that these voices you're hearing are characters and that the experience is so overwhelming that you can't focus on them. The OSC circle emphasizes the background static/talking/jitter and also evokes a calm feeling for me. I say calm because it reminds me of a sun that a 5 year old would draw. The background static/talking itself could be noise inside the recordings or from my roommates' activities, as both happen while I'm trying to edit VO files. The rectangles in the background represent the stability of the DAW and its settings--it's the only constant that makes sense. The polylines lay right on top of the DAW tracks in the Cubase image and they're upside down, making the tracks in the image come to life. The icospheres in the center represent what I'm listening for while editing VO files. Finally, pressing "p" to make the metronome play and "m" to make it mute represents how I get session files where the metronome is on (or off). I have to mute it, or I accidentally turn it on.