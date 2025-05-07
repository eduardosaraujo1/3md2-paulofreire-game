// === CONFIGURATION
DAMAGE = 20;
SPEED = 8;
SPIN_ACCELERATION = 0.1;
SPIN_MAX = 60;

// === STATE
spin = 1;

// === Create logic
image_speed = 0;
alarm[0] = game_get_speed(gamespeed_fps) * 20;
