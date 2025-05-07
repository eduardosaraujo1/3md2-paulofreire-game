// Ensure player is inside board
var half_w = abs(sprite_width) / 2;
var half_h = abs(sprite_height) / 2;
x = clamp(half_w, x, room_width - half_w);
y = clamp(half_h, y, room_height - half_h);

if (HEALTH <= 0) {
	if (COLOR_INDEX <= 0) {
		sprite_index = spr_player1_dead;
	} else {
		sprite_index = spr_player2_dead;
	}
	exit;
}

// == Cooldown Tick
atk_cooldown = max(0, atk_cooldown - 1);
dash_cooldown = max(0, dash_cooldown - 1);

// === Handle Attack
if (keyboard_check_pressed(KEY_ATTACK) && atk_cooldown <= 0) {
    var ax = x + lengthdir_x(sprite_width + 8, direction);
    var ay = y + lengthdir_y(sprite_width + 8, direction);
    create_attack(ax, ay, direction, COLOR_INDEX);
    
    atk_cooldown = ATK_COOLDOWN;
}


// === Handle Dashing
if (keyboard_check_pressed(KEY_DASH) && dash_cooldown <= 0) {
	alarm[0] = 5;
	image_speed = 1;
	
	dash_cooldown = DASH_COOLDOWN;
}

if (image_index > image_number - 1) {
	image_speed = 0;
	image_index = 0;
}


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

move_and_collide(delta_x, delta_y, [abs_enemy])
unstuck(abs_enemy);