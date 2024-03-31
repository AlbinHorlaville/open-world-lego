class_name Brick extends Node3D

# The color of the lego brick
@export var material:Material
# The biome where it is located, to applicate some shaders
@export var biome:int # from 0 to the number of biomes
# The solidity of the lego brick, it impacts the time needed to destroy it for example
@export var solidity:int # from 1 to 10
# The weight of the lego brick
@export var weight:int # from 1 to 10
# The pourcentage of density of the lego brick. it impacts the way the other bricks can pass through.
@export var density:int # from 0 to 100

func _ready() -> void:
	# get the instance
	var mesh_inst = $brick2x2.get_child(0)
	# Assign the material
	mesh_inst.set_surface_override_material(0, self.material)

func changeMaterial(new_mat:Material)->void:
	# get the instance
	var mesh_inst = $brick2x2.get_child(0)
	# Assign the material
	mesh_inst.set_surface_override_material(0, new_mat)

func resetMaterial():
	# get the instance
	var mesh_inst = $brick2x2.get_child(0)
	# Assign the material
	mesh_inst.set_surface_override_material(0, material)

# -1 and 10 are used for blocks that should be never destroy, like water or bedrock
func is_destroyable():
	return self.solidity > 0 and self.solidity < 10

func get_collision():
	return $CollisionShape3D
