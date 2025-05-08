// Detect healing
var is_healing = place_meeting(x, y, abs_player);

if (is_healing) {
	cooldown--;
} else {
	cooldown = COOLDOWN;
}

if (cooldown <= 0) {
	instance_create_layer(x, y, "Instances", PLAYER_INSTANCE);
	instance_destroy(self);
}