// === ENEMY COUNT UPDATING
ENEMY_COUNT = instance_number(abs_enemy);

// === STAGE TRACKING
if (ENEMY_COUNT <= 0) {
	next_stage();
}