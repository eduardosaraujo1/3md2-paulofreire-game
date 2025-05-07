// === CONFIGURATION
DAMAGE = 1;
MAX_HEALTH = 100;
HEALTH = 100;
SPEED = 2;

// === STATE
dying = false;

// === Helper functions
function kill_self() {
	dying = true;
	
	sprite_index = spr_death;
	image_index = 0;
	image_speed = 1;
}

function damage_player(instance, dmg) {
    with (instance)
    {
		if (object_is_ancestor(object_index, abs_player)) {
			self.HEALTH = max(self.HEALTH - dmg, 0);
		}
    }
}