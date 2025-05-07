/// @description Performs player dash
var original_x = x;
var original_y = y;

x += lengthdir_x(DASH_DISTANCE, direction);
y += lengthdir_y(DASH_DISTANCE, direction);

if (place_meeting(x, y, abs_enemy)) {
	HEALTH -= 10;
	x = original_x;
	y = original_y;
}