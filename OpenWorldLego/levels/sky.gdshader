shader_type sky;

void sky() {
	// Called for every visible pixel in the sky background, as well as all pixels
	// in the radiance cubemap.
	if (AT_CUBEMAP_PASS)
        // Sets the radiance cubemap to a nice shade of blue instead of doing
        // expensive sky calculations
        COLOR = vec3(0.2, 0.6, 1.0);
}
