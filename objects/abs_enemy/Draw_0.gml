// === HEALTHBAR
var width = 200;
var height = 16;
var _health = HEALTH;
var hx = x - width / 2; // Centers the helathbar
var hy = y - sprite_height / 2 - (height * 1.5);
var color = #E9006D;

draw_healthbar(
	hx,
	hy,
	hx + width,
	hy + height,
	_health,
	c_gray,
	color,
	color,
	0,
	true,
	true
);

// === DEFAULT
draw_self();