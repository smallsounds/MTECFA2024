# Final Project Report Two
[Astral Wars by Nathan Foster](https://github.com/brandedcow/OFAstralWars)

I downloaded Astral Wars to my OpenFrameworks apps folder and ran the project. It worked, so I know I can use it as a basis for my final OpenFrameworks project. The Wendy's project lacked some of the files needed to make the project, so I wasn't able to test it. That being said, I'm sure the logic is still sound, and I can reference it still if I run into any issues. 

I was planning to ask Rachel to help me with my PureData setup and ask some clarifying questions:
- Is it okay that I'm still doing a game for my project?
- How more advanced do you want the PureData portion? Is it okay if I create a simpler sequencer like the one you created for the midterm?
- Are you looking for more interactivity between the OSC messages and the game? Is enemy count and color enough? Do you have any more ideas on how to expand the use of OSC messages in this case?


I took Nathan Foster's project and added ofxOSC using the projectGenerator. I changed the project so that the LevelController file contained:

    void LevelController::update_interval(float new_interval) {
        interval_time = new_interval;
    }

I used my other projects to set up the OSC receiver in the ofApp header file and in the setup portion of the ofApp c++ file. 

I created this

    void ofApp::update() {
    while (osc_receiver.hasWaitingMessages()) {
        ofxOscMessage message;
        osc_receiver.getNextMessage(message);

    float new_interval = message.getArgAsFloat(0);
    if (new_interval > 0) {
        level_controller.update_interval(new_interval);
            }
        }
    }

to change the spawn rate. The last if is just checking whether or not the value is valid just in case things get wonky. 

I then used Rachel's PureData project to test whether or not this worked in Astral Wars, and it worked. I'm still not feeling too confident with my PureData project, but I hope I can bounce some ideas off of my classmates if they have time to take a peek. 