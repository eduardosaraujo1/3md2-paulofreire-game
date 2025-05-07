// === Check Death of Self
if (HEALTH <= 0 && !dying) {
	kill_self();
}

	show_debug_message(instance_number(abs_enemy));
if (dying) {
	if (image_index > image_number - 1) {
		instance_destroy();
	}
	exit;
}

// === Moving Towards Player
var target = instance_nearest(x, y, abs_player);

// === Calculate direction vector toward the player
var dx = target.x - x;
var dy = target.y - y;
var dist = point_distance(x, y, target.x, target.y);

// Normalize the direction and apply speed
var nx = dx / dist * SPEED;
var ny = dy / dist * SPEED;

// Make enemy move
var collisions = move_and_collide(nx, ny, [abs_player, abs_enemy]);

// === Player Damage
for (var i = 0; i < array_length(collisions); i++)
{
	damage_player(collisions[i], DAMAGE);
}