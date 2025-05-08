// Inherit the parent event
event_inherited();

var nearest =  instance_nearest(x, y, abs_player);
if (nearest != noone) {
	image_angle = point_direction(x, y, nearest.x, nearest.y) - 90;
}