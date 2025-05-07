var width = 400;
var height = 32;
var px = 32;
var py = 64;
var color = #00FEFC;
var _health = HEALTH / MAX_HEALTH * 100;

draw_healthbar(px, py, px+width, py+height, _health, c_black, color, color, 0, false, false);
draw_set_font(fnt_default);
draw_text(px, py * 0.25, "Jogador 1 - " + string(_health));