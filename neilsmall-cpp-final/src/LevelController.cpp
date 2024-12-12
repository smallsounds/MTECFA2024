#include "LevelController.hpp"

void LevelController::setup(float s) {
    start_time = s;
    interval_time = 500;
}

void LevelController::processOSCInput(float value) {
    if (value > 50) {
        spawn_now = true;
    }
}

bool LevelController::should_spawn() {
    if (spawn_now) {
        spawn_now = false; 
        return true;       
    }
    return false; 
}


