// === ENEMY COUNT UPDATING
ENEMY_COUNT = instance_number(abs_enemy);

show_debug_message(ENEMY_COUNT)

// === STAGE TRACKING
if (ENEMY_COUNT <= 0) {
	next_stage();
}