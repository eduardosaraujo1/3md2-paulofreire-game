// === STATE
STAGE = 0;
ENEMY_COUNT = 0;
GAMEOVER = false;

// === POSITIONING
x = room_width / 2;
y = 4;

// === FUNCTIONS
/// @function get_enemy_count(stage)
/// @description Returns the number of enemies to spawn based on stage number
/// @param {Real} stage Current stage number
/// @returns {Real} Number of enemies to spawn
function get_enemy_count(stage) {
    // Base count: start with 3 enemies at stage 1
    var base_count = 3;
    
    // Progressive increase: Add more enemies as stages advance
    // Formula: base + (stage-1) + floor(stage/3)
    // This gives:
    // Stage 1: 3 enemies
    // Stage 2: 4 enemies
    // Stage 3: 5 enemies
    // Stage 4: 7 enemies
    // Stage 5: 8 enemies
    // Stage 10: 15 enemies
    var additional = (stage - 1) + floor(stage / 3);
    
    // Cap the maximum number of enemies to prevent overwhelming the player
    var max_enemies = 25;
    
    // Calculate final count
    var count = base_count + additional;
    
    // Ensure we don't exceed the maximum
    return min(count, max_enemies);
    
    // Alternative simpler formula if you prefer:
    // return min(base_count + floor(stage * 1.5), max_enemies);
}

function next_stage() {
	// The seed must be randomized to prevent predictable behavior
	randomize();

	// Must increment current stage to go to the next
	STAGE++;
	
    // Get the current view dimensions and position
    var cam = view_camera[0];
    var view_x = camera_get_view_x(cam);
    var view_y = camera_get_view_y(cam);
    var view_w = camera_get_view_width(cam);
    var view_h = camera_get_view_height(cam);
    
    // Calculate spawn positions outside the viewport
    for (var i = 0; i < get_enemy_count(STAGE); i++) {
		var spawn_x = 0
		var spawn_y = 0;
        var spawn_side = irandom(3); // 0: left, 1: right, 2: top, 3: bottom
		var spawn_sprite = irandom(3); // 0-2 is enemy1, 3 is enemy2
        
        switch (spawn_side) {
            case 0: // Left side
                spawn_x = view_x - irandom_range(96, 224);
                spawn_y = view_y + irandom_range(0, view_h);
                break;
            case 1: // Right side
                spawn_x = view_x + view_w + random_range(96, 224);
                spawn_y = view_y + irandom_range(0, view_h);
                break;
            case 2: // Top side
                spawn_x = view_x + irandom_range(0, view_w);
                spawn_y = view_y - irandom_range(96, 224);
                break;
            case 3: // Bottom side
                spawn_x = view_x + irandom_range(0, view_w);
                spawn_y = view_y + view_h + random_range(96, 224);
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