// === STATE
START = false;
STAGE = 0;
ENEMY_COUNT = 0;
GAMEOVER = false;

// === POSITIONING
x = room_width / 2;
y = 4;

// === DELAYED START
alarm[0] = game_get_speed(gamespeed_fps) * 5;

// === FUNCTIONS
function game_over() {
	GAMEOVER = true;
	with (abs_enemy) {
		image_alpha = 0.3;
		depth = 100;
	}
	
	// Manage state
	var text_y = 224;
	var retry_y = 320;
	var quit_y = 416;
	var center = camera_get_view_width(view_camera[0]) / 2
	
	// Draw text
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(center, text_y, "Você sobreviveu por " + string(STAGE) + " níveis.");
	
	// Draw retry button
	var retry = instance_create_layer(center, retry_y, layer, obj_button_retry);
	
	// Draw quit button
	var quit = instance_create_layer(center, quit_y, layer, obj_button_sair);
	
	// Fix buttons width
	retry.image_xscale = 1.25;	
	quit.image_xscale = 1.25;
	
	// Wrap up
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

/// @function get_enemy_count(stage)
/// @description Returns the number of enemies to spawn based on stage number
/// @param {Real} stage Current stage number
/// @returns {Real} Number of enemies to spawn
function get_enemy_count(stage) {
    var base_count = 3;
    var max_enemies = 25;
    
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
    var count = base_count + additional;

    return min(count, max_enemies);
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
	var enemy;
    
    // Calculate spawn positions outside the viewport
    for (var i = 0; i < get_enemy_count(STAGE); i++) {
		var spawn_x = 0
		var spawn_y = 0;
        var spawn_side = irandom(3); // 0: left, 1: right, 2: top, 3: bottom
		var spawn_sprite = irandom(9) + 1;
        
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
		
		/*
		1 -> obj_boss
		3 -> obj_enemy_3
		5 -> obj_enemy_1
		2 -> obj_enemy_2
		*/
		if (spawn_sprite <= 1) {
			enemy = instance_create_layer(spawn_x, spawn_y, layer, obj_boss);
		} else if (spawn_sprite > 1 && spawn_sprite <= 4) {
			enemy = instance_create_layer(spawn_x, spawn_y, layer, obj_enemy3);
		} else if (spawn_sprite > 4 && spawn_sprite <= 9) {
			enemy = instance_create_layer(spawn_x, spawn_y, layer, obj_enemy1);
		} else {
			enemy = instance_create_layer(spawn_x, spawn_y, layer, obj_enemy2);
		}
		
		with (enemy) {
			SPEED = clamp(2, 1 + other.STAGE / 5, 4);
		}
    }
}