extends StaticBody3D

var material:Material

func initMaterial(mat:Material)->void:
	# get the instance
	var mesh_inst = $brick2x2.get_child(0)
	# Assign the material
	mesh_inst.set_surface_override_material(0, mat)
	material = mat

func changeMaterial(mat:Material)->void:
	# get the instance
	var mesh_inst = $brick2x2.get_child(0)
	# Assign the material
	mesh_inst.set_surface_override_material(0, mat)

func resetMaterial():
	# get the instance
	var mesh_inst = $brick2x2.get_child(0)
	# Assign the material
	mesh_inst.set_surface_override_material(0, material)

func is_destroyable():
	return true
