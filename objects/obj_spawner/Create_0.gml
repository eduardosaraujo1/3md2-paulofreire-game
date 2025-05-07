// === STATE
STAGE = 0;
ENEMY_COUNT = 0;

// === POSITIONING
x = room_width / 2;
y = 4;

// === FUNCTIONS
function next_stage() {
	// Must increment current stage to go to the next
	STAGE++;
	
    // Get the current view dimensions and position
    var cam = view_camera[0];
    var view_x = camera_get_view_x(cam);
    var view_y = camera_get_view_y(cam);
    var view_w = camera_get_view_width(cam);
    var view_h = camera_get_view_height(cam);
    
    // Calculate spawn positions outside the viewport
    for (var i = 0; i < 10; i++) {
		var spawn_x = 0
		var spawn_y = 0;
        var spawn_side = irandom(3); // 0: left, 1: right, 2: top, 3: bottom
		var spawn_sprite = irandom(3); // 0-2 is enemy1, 3 is enemy2
        
        switch (spawn_side) {
            case 0: // Left side
                spawn_x = view_x - random_range(128, 256);
                spawn_y = view_y + random_range(0, view_h);
                break;
            case 1: // Right side
                spawn_x = view_x + view_w + random_range(128, 256);
                spawn_y = view_y + random_range(0, view_h);
                break;
            case 2: // Top side
                spawn_x = view_x + random_range(0, view_w);
                spawn_y = view_y - random_range(128, 256);
                break;
            case 3: // Bottom side
                spawn_x = view_x + random_range(0, view_w);
                spawn_y = view_y + view_h + random_range(128, 256);
                break;
        }
        
		switch (spawn_sprite) {
			case 0:
			case 1:
			case 2:
				instance_create_layer(spawn_x, spawn_y, layer, obj_enemy1);
				break;
			case 3:
				instance_create_layer(spawn_x, spawn_y, layer, obj_enemy2);
				break;
		}
    }
}