// Player State
plr_speed = 8;
plr_health = 200;
plr_max_health = 200;

cooldown_attack = 0;

/// @param {string}  label Healthbar text
/// @param {Asset.GMSprite}  sprite Healthbar sprite
function render_healthbar(label, sprite, px, py, width, height) {
	//health
	draw_sprite_stretched(
		sprite,
		0,
		px,
		py,
		(plr_health / plr_max_health) * width,
		height
	);
	//background
	draw_sprite_stretched(
		spr_healthbar,
		0,
		px,
		py,
		width,
		height
	);
	//text
	draw_set_font(fnt_default);
	draw_text(px, py * 0.25, label + " - " + string(plr_health));
}

function calculate_movement() {
	var delta_x = keyboard_check(KEY_RIGHT) - keyboard_check(KEY_LEFT);
	var delta_y = keyboard_check(KEY_DOWN) - keyboard_check(KEY_UP);
	
	if (delta_x == -1){
		image_xscale = 1;
	} else if (delta_x == 1) {
		image_xscale = -1;
	}

	// Normalize vectors
	var magnitude = sqrt(delta_x * delta_x + delta_y * delta_y); // a^2 + b^2 = c^2
	if (magnitude != 0) {
		delta_x /= magnitude;
		delta_y /= magnitude;
	}

	// Calculate new position
	var player_x = x + delta_x * plr_speed;
	var player_y = y + delta_y * plr_speed;
	
	// Truncate position for inside board
	var half_w = abs(sprite_width) / 2;
	var half_h = abs(sprite_height) / 2;
	player_x = max(min(player_x, room_width - half_w), half_w);
	player_y = max(min(player_y, room_height - half_h), half_h);
	
	return {
		px: player_x,
		py: player_y
	};
}