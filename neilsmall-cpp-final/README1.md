# Final Project Report One
Example OpenFrameworks Projects:
[2D Video Game by Wendy Arango (Video)](https://youtu.be/pa29bvDQ3Ms?si=5rnsir4dZu4UauSw)
[2D Video Game by Wendy Arango (Repo)](https://github.com/warango4/graphicComputing/tree/master/of2dGame)
[Astral Wars by Nathan Foster](https://github.com/brandedcow/OFAstralWars)

Example PureData Projects:
[Step-sequencer](https://www.gamedeveloper.com/audio/16-step-sequencer-in-pure-data)
[Rachel's Sequencer](https://github.com/rdwrome/cppfa24/blob/main/06PD%2BoFxOSC/pdsequencer.pd)

Arduino:
[Arduino Joystick Video](https://youtu.be/vo7SbVhW3pE?si=oFn7tj4H2zUlJxj0)
[Arduino Joystick Documentation](https://arduinogetstarted.com/tutorials/arduino-joystick)
[OpenFramworks Arduino Documentation](https://openframeworks.cc/documentation/communication/ofArduino/)

## The Plan:
I am working on an asteroid shooter game that has elements that are controlled by OSC messages from a PureData sequencer. If there is time, I would also like to integrate a joystick via an Arduino to use as a controller for the player character. I am going to be basing my code off of the two example games above, and the number of enemies on screen will correlate to the OSC messages received. Additionally, the color of the enemy will be chosen based on the OSC messaged received as the enemy spawns. 

## Timeline:
Nov. 14-21: Create the PureData sequencer
Nov. 21-28: Create the game and test the sequencer
Nov. 28-30: Assess whether or not integrating the Arduino is possible
Dec. 1-5: Continue integrating the Arduino or refine/debug the game and sequencer
Dec. 5-12: Finish and submit! 