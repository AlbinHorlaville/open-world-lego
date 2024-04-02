extends Node3D
class_name GravityNode
# Ceci est une node pouvant tomber ayant de la gravité et des collisions

func _init(myRessources : Node3D):
	# ajouter fils
	self.add_child(myRessources)
	set_scale(Vector3(62.5, 62.5, 62.5))
	for mesh in myRessources.get_children():
		if mesh is MeshInstance3D:
			mesh.create_convex_collision()
	# ajouter collision
