// === Moving Towards Player
var target = instance_nearest(x, y, abs_player);

// === Calculate direction vector toward the player
var dx = target.x - x;
var dy = target.y - y;
var dist = point_distance(x, y, target.x, target.y);

// Normalize the direction
var nx = dx / dist * SPEED;
var ny = dy / dist * SPEED;

var collisions = move_and_collide(nx, ny, [abs_player, abs_enemy]);

// === Player Damage
for (var i = 0; i < array_length(collisions); i++)
{
    with (collisions[i])
    {
		if (object_is_ancestor(object_index, abs_player)) {
			self.HEALTH = max(self.HEALTH - other.DAMAGE, 0);
		}
    }
}