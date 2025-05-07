// === CONFIGURATION
ATK_COOLDOWN = game_get_speed(gamespeed_fps) * 0.25;
ATK_SPEED = 4;
ATK_DAMAGE = 20;
DAMAGE = 20;
SPEED = 8;
MAX_HEALTH = 200;
HEALTH = 200;

// === STATE
cooldown = 0;

// === HELPER FUNCTIONS
/// @parameter {Real} ax
/// @parameter {Real} ay
/// @parameter {Real} adir
/// @parameter {Real} color
function create_attack(ax, ay, adir, color) {
	var inst = instance_create_layer(ax, ay, layer, obj_attack);
	with (inst) {
		direction = adir;
		speed = other.ATK_SPEED;
		DAMAGE = other.ATK_DAMAGE;
		image_index = color mod 2;
	}
}