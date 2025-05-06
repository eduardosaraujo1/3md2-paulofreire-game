// HEALTHBAR
var healthbar_x = x - sprite_width/2
var healthbar_y = y - sprite_height - 32
draw_healthbar(
	healthbar_x,
	healthbar_y,
	healthbar_x + sprite_width,
	healthbar_y + 16,
	ENEMY_HEALTH,
	c_black,
	#E9006D,
	#E9006D,
	0,
	false,
	false
);

draw_self();