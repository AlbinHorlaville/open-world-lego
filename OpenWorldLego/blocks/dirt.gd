extends StaticBody3D

func changeMaterial(mat:Material)->void:
	# get the instance
	var mesh_inst = $brick_2x2/_NODEID_1059234381
	# Assign the material
	mesh_inst.set_surface_override_material(0, mat)
