/// @function get_nearest_collider(colliding_object)
/// @description Finds the nearest instance that is colliding with the calling instance
/// @param {Asset.GMObject} colliding_object The object type to check collisions with
/// @returns {Id.Instance} The nearest colliding instance, or noone if none found
function get_nearest_collider(colliding_object) {
    var nearest = noone;
    var nearest_dist = infinity;
    
    // Get list of all colliding instances
    var colliders = ds_list_create();
    var num_colliders = instance_place_list(x, y, colliding_object, colliders, false);
    
    // Find nearest collider that isn't self
    for (var i = 0; i < num_colliders; i++) {
        var collider = ds_list_find_value(colliders, i); // Proper ds_list access
        if (collider != id) {
            var dist = point_distance(x, y, collider.x, collider.y);
            if (dist < nearest_dist) {
                nearest = collider;
                nearest_dist = dist;
            }
        }
    }
    
    ds_list_destroy(colliders);
    return nearest;
}

/// @function try_cardinal_directions(start_x, start_y, obstacle_object, distance)
/// @description Attempts to find a non-colliding position in cardinal/diagonal directions
/// @param {Real} start_x Starting X position
/// @param {Real} start_y Starting Y position
/// @param {Asset.GMObject} obstacle_object The object to avoid colliding with
/// @param {Real} distance Distance to check in each direction
/// @returns {Array<Any>} [success, new_x, new_y] 
function try_cardinal_directions(start_x, start_y, obstacle_object, distance) {
    var directions = [0, 90, 180, 270, 45, 135, 225, 315];
    
    for (var i = 0; i < array_length(directions); i++) {
        var test_x = start_x + lengthdir_x(distance, directions[i]);
        var test_y = start_y + lengthdir_y(distance, directions[i]); // Fixed
        
        if (!place_meeting(test_x, test_y, obstacle_object)) {
            return [true, test_x, test_y];
        }
    }
    
    return [false, start_x, start_y];
}

/// @function apply_push(direction, distance)
/// @description Moves the instance in the specified direction by the specified distance
/// @param {Real} direction Direction to move in degrees
/// @param {Real} distance Distance to move
/// @returns {Array<Real>} [new_x, new_y]
function apply_push(direction, distance) {
    var new_x = x + lengthdir_x(distance, direction);
    var new_y = y + lengthdir_y(distance, direction);
    return [new_x, new_y];
}

/// @function unstuck(obstacle_object, attempts, push_distance)
/// @description Attempts to push an instance out of collision with specified obstacles
/// @param {Asset.GMObject} obstacle_object Object or parent object to unstuck from
/// @param {Real} attempts Maximum number of unstucking attempts
/// @param {Real} push_distance Distance to push in each attempt
/// @returns {Bool} Whether unstucking was successful
function unstuck(obstacle_object, attempts = 5, push_distance = 2) {
    // Skip if not colliding with anything
    if (!place_meeting(x, y, obstacle_object)) {
        return true;
    }
    
    var original_x = x;
    var original_y = y;
    var attempt = 0;
    
    while (place_meeting(x, y, obstacle_object) && attempt < attempts) {
        attempt++;
        
        // Get nearest collider
        var nearest = get_nearest_collider(obstacle_object);
        
        if (nearest != noone) {
            // Push away from nearest collider
            var push_dir = point_direction(nearest.x, nearest.y, x, y);
            var new_pos = apply_push(push_dir, push_distance);
            x = new_pos[0];
            y = new_pos[1];
        } else {
            // Try cardinal directions
            var result = try_cardinal_directions(original_x, original_y, obstacle_object, push_distance);
            
            if (result[0]) {
                // Cardinal direction worked
                x = result[1];
                y = result[2];
            } else {
                // Last resort: random direction
                var random_dir = random(360);
                var new_pos = apply_push(random_dir, push_distance);
                x = new_pos[0];
                y = new_pos[1];
            }
        }
        
        // Check if we're now unstuck
        if (!place_meeting(x, y, obstacle_object)) {
            return true;
        }
    }
    
    // Keep within room boundaries
    x = clamp(x, 0, room_width);
    y = clamp(y, 0, room_height);
    
    // Return success status
    return !place_meeting(x, y, obstacle_object);
}

/// @function unstuck_advanced(obstacle_object, attempts, push_distance, respect_bounds)
/// @description Advanced unstucking that respects room boundaries and sprite dimensions
/// @param {Asset.GMObject} obstacle_object Object to unstuck from
/// @param {Real} attempts Maximum number of attempts
/// @param {Real} push_distance Distance to push in each attempt
/// @param {Bool} respect_bounds Whether to respect room boundaries
/// @returns {Bool} Whether unstucking was successful
function unstuck_advanced(obstacle_object, attempts = 5, push_distance = 2, respect_bounds = true) {
    // Basic unstuck implementation 
    var result = unstuck(obstacle_object, attempts, push_distance);
    
    // Additional boundary checking
    if (respect_bounds) {
        var half_w = sprite_width / 2;
        var half_h = sprite_height / 2;
        
        x = clamp(x, half_w, room_width - half_w);
        y = clamp(y, half_h, room_height - half_h);
    }
    
    return result;
}
