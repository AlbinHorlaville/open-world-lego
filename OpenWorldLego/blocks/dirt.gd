extends StaticBody3D

func changeMaterial(mat:Material)->void:
	# Instanciate a new MeshInstance3D
	var mesh_inst = MeshInstance3D.new()
	# Instanciate it BoxMesh
	mesh_inst.mesh = BoxMesh.new()
	# Assign the material
	mesh_inst.set_surface_override_material(0, mat)
	# Add to the tree
	add_child(mesh_inst)
