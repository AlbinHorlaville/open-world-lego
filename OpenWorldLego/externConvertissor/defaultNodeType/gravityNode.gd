extends Node3D
class_name GravityNode
# This is a node that have an hitbox but can not fall yet - TODO !

func _init(myRessources : Node3D):
	# ajouter fils
	self.add_child(myRessources)
	set_scale(Vector3(62.5, 62.5, 62.5))
	for mesh in myRessources.get_children():
		if mesh is MeshInstance3D:
			# add collision
			mesh.create_convex_collision()
