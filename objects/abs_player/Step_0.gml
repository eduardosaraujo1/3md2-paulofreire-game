// === Handle Attack

// Attack trigger
if (keyboard_check_pressed(KEY_ATTACK) && cooldown <= 0) {
    var ax = x + lengthdir_x(sprite_width + 8, direction);
    var ay = y + lengthdir_y(sprite_width + 8, direction);
    create_attack(ax, ay, direction, ATTACK_COLOR_INDEX);
    
    cooldown = ATK_COOLDOWN;
}

// Cooldown timer
cooldown = max(0, cooldown - 1);

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