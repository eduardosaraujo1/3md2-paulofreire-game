// === Handle Attack
// Constants
var attack_distance = sprite_width;
var cooldown_time = game_get_speed(gamespeed_fps) * 0.2;

// Attack trigger
if (keyboard_check_pressed(KEY_ATTACK) && ATK_COOLDOWN <= 0) {
    var ax = x + lengthdir_x(attack_distance, direction);
    var ay = y + lengthdir_y(attack_distance, direction);
    
    instance_create_layer(ax, ay, layer, obj_attack);
    
    ATK_COOLDOWN = cooldown_time;
}

// Cooldown timer
ATK_COOLDOWN = max(0, ATK_COOLDOWN - 1);

// === Handle movement
var delta_x = keyboard_check(KEY_RIGHT) - keyboard_check(KEY_LEFT);
var delta_y = keyboard_check(KEY_DOWN) - keyboard_check(KEY_UP);

// Normalize vector
var distance = sqrt(sqr(delta_x) + sqr(delta_y));
if (distance != 0) {
	delta_x = delta_x / distance;
	delta_y = delta_y / distance;
}

// Define player direction
if (delta_x != 0 || delta_y != 0) {
	direction = point_direction(0, 0, delta_x, delta_y);
}

// Define player speed
delta_x *= SPEED;
delta_y *= SPEED;

// Ensure player is inside board
var half_w = abs(sprite_width) / 2;
var half_h = abs(sprite_height) / 2;

if (x + delta_x < half_w || x + delta_x > room_width - half_w) {
	delta_x = 0;
}
if (y + delta_y < half_h || y + delta_y > room_height - half_h) {
	delta_y = 0;
}

move_and_collide(delta_x, delta_y, [abs_enemy])
unstuck(abs_enemy);