function calculate_movement() {
	var delta_x = keyboard_check(KEY_RIGHT) - keyboard_check(KEY_LEFT);
	var delta_y = keyboard_check(KEY_DOWN) - keyboard_check(KEY_UP);

	// Normalize vectors
	var magnitude = sqrt(delta_x * delta_x + delta_y * delta_y); // a^2 + b^2 = c^2
	if (magnitude != 0) {
		delta_x /= magnitude;
		delta_y /= magnitude;
	}

	// Calculate new position
	var player_x = x + delta_x * DEFAULT_SPEED;
	var player_y = y + delta_y * DEFAULT_SPEED;
	
	// Truncate position for inside board
	var half_w = sprite_width / 2;
	var half_h = sprite_height / 2;
	player_x = max(min(player_x, room_width - half_w), half_w);
	player_y = max(min(player_y, room_height - half_h), half_h);
	
	return {
		px: player_x,
		py: player_y
	};
}