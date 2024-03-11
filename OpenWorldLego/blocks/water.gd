extends StaticBody3D
var k:int
func _ready() -> void:
	k+=1
	# get the instance
	var mesh_inst = $brick_2x2.get_child(0)
	# Assign the material
	mesh_inst.set_surface_override_material(0, load("res://materials/Water.tres"))

func _process(delta: float) -> void:
	
	position.y = (2*sin(delta*(position.x+k)) + 2*sin(delta*(position.z+k)))/2
	k+=1
