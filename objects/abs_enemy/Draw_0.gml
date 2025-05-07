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

// === HEALTH TEXT
draw_set_font(fnt_default);
var health_text = string(_health);
var text_x = hx + width + 10; // Position 10 pixels to the right of the healthbar
var text_y = hy + (height/2) - string_height(health_text)/2; // Vertically center with the healthbar
draw_text(text_x, text_y, health_text);

// === DEFAULT
draw_self();