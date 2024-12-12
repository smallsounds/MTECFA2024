#pragma once

#include "ofMain.h"
#include "Player.hpp"
#include "Bullet.hpp"
#include "Life.hpp"
#include "Enemy.hpp"
#include "LevelController.hpp"
#include "ofxOsc.h"

class ofApp : public ofBaseApp {

public:
	void setup();
	void update();
	void draw();

	void keyPressed(int key);
	void keyReleased(int key);
	void mouseMoved(int x, int y);
	void mouseDragged(int x, int y, int button);
	void mousePressed(int x, int y, int button);
	void mouseReleased(int x, int y, int button);
	void mouseEntered(int x, int y);
	void mouseExited(int x, int y);
	void windowResized(int w, int h);
	void dragEvent(ofDragInfo dragInfo);
	void gotMessage(ofMessage msg);
	void update_bullets();
	void limitPlayer(ofPoint * point);
	void check_bullet_collisions();
	void draw_lives();
	void draw_score();
	void reset_game();
	void handleOSC();

	string game_state;
	int score;
	float max_enemy_amplitude;
	float max_enemy_shoot_interval;
	float oscy = 0.0;

	Player player_1;
	vector<Bullet> bullets;
	vector<Enemy> enemies;
	LevelController level_controller;
	ofxOscReceiver oscReceiver;
	

	ofPoint player_start;

	ofImage player_image;
	ofImage enemy_bullet_image;
	ofImage player_bullet_image;
	ofImage enemy_image;
	ofImage start_screen;
	ofImage end_screen;

	ofSoundPlayer player_bullet_sound;
	ofSoundPlayer bgmx;

	ofTrueTypeFont score_font;

private:
    bool reset_button_pressed = false;
};