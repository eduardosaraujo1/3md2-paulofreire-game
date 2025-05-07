image_angle = (image_angle + spin) mod 360;

// add acceleration
spin = min(spin + SPIN_ACCELERATION, SPIN_MAX);