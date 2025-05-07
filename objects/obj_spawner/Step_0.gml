// === ENEMY COUNT UPDATING
ENEMY_COUNT = instance_number(abs_enemy);

// === STAGE TRACKING
if (ENEMY_COUNT <= 0 && !GAMEOVER) {
	next_stage();
}

// === Game Over Handler
if (instance_number(abs_player) <= 0) {
	GAMEOVER = true;
}