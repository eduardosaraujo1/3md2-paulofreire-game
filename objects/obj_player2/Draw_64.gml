var width = 400;
var height = 32;
var px = display_get_gui_width() - (width + 32); // 32 is padding
var py = 64
var color = #FFD400
var _health = round(HEALTH / MAX_HEALTH * 100);

draw_healthbar(px, py, px+width, py+height, _health, c_black, color, color, 0, false, false);
draw_set_font(fnt_default);
draw_text(px, py * 0.25, "Jogador 2 - " + string(_health));