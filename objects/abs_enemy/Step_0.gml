// === STEP 1: Target nearest player
var player = instance_nearest(x, y, abs_player);
if (player == noone) exit;

var move_speed = 1.5;
var move_dir = point_direction(x, y, player.x, player.y);

// Initial movement vector toward the player
var vx = lengthdir_x(move_speed * random_range(1, 5), move_dir);
var vy = lengthdir_y(move_speed, move_dir);

// Combine attraction to player and repulsion from others
x += vx;
y += vy;

// === STEP 3: Attack if close
if (point_distance(x, y, player.x, player.y) <= attack_range) {
    player.plr_health = max(0, player.plr_health - DAMAGE);
}

// === STEP 4: Die if health is 0
if (ENEMY_HEALTH <= 0) {
    instance_destroy();
}