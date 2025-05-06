var position = calculate_movement();

if (keyboard_check(KEY_ATTACK) && cooldown_attack <= 0) {
	instance_create_layer(
		x + sprite_width * -1,
		y,
		layer,
		obj_attack
	);
	cooldown_attack = 60 * 0.2
}

x = position.px;
y = position.py;

cooldown_attack = max(0, cooldown_attack - 1);