
draw_self();

var is_healing = place_meeting(x, y, abs_player);

if (is_healing) {
	draw_healthbar(
		x - sprite_width/2, 
		y - sprite_height/2, 
		x + sprite_width/2,
		y + sprite_height/2, 
		(cooldown / COOLDOWN) * 100,
		c_black, 
		#E9006D,
		#E9006D,
		0,
		false,
		false
	);	
}
