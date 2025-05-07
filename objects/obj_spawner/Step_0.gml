// === ENEMY COUNT UPDATING
ENEMY_COUNT = instance_number(abs_enemy);

// === STAGE TRACKING
if (START && ENEMY_COUNT <= 0 && !GAMEOVER) {
	next_stage();
}

// === Game Over Handler
if (instance_number(abs_player) <= 0) {
	GAMEOVER = true;
	with (abs_enemy) {
		image_alpha = 0.3;
	}
}