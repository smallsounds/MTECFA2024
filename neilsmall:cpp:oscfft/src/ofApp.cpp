#include "ofApp.h"
#include "ofxGui.h"

//--------------------------------------------------------------
void ofApp::setup(){
ofEnableAlphaBlending();
sender.setup("localhost", 12345);
receiver.setup(12345);
cube.load("cube.png");
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
//Icospheres
ofNoFill();
ofSetColor(255,255,255,255);
ofSetLineWidth(2);
ofSetIcoSphereResolution(1);
ofSetRectMode(OF_RECTMODE_CENTER);
    for (int i = 0; i < 10; i++) {
        ofPushMatrix();
        ofTranslate(ofGetWidth()/12*(i+1.5), ofGetHeight()/2);
        ofRotateDeg(ofGetElapsedTimef()*i*fft[i]);
        ofDrawIcoSphere(0, 50, 0, 50);
        ofPopMatrix();
    }

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

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseScrolled(int x, int y, float scrollX, float scrollY){

}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h) {

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){ 

}
