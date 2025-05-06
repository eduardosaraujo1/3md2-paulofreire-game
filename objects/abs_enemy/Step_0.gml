var target = instance_nearest(x, y, abs_player);

if (target != noone) {
    var dir = point_direction(x, y, target.x, target.y);
    var spd = 4;
    x += lengthdir_x(spd, dir);
    y += lengthdir_y(spd, dir);
	
	var distance = point_distance(x, y, target.x, target.y)
	
	if (distance < 3) {
		target.plr_health = max(0, target.plr_health - DAMAGE);
	};
}

if (ENEMY_HEALTH <= 0) {
	instance_destroy(self);
}