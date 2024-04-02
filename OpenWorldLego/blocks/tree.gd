extends Node3D

@export var color_leaf: Material
@export var color_wood: Material

@export var foliage1: PackedScene
@export var foliage2: PackedScene
@export var foliage3: PackedScene
@export var foliage4: PackedScene
@export var trunk1: PackedScene
@export var trunk2: PackedScene
@export var trunk3: PackedScene

# Dimension Lego piece 2x2 = 16x16x9,6
var hlego:float = 9.6/16

# Called when the node enters the scene tree for the first time.
# When a cloud is initialized, a skin is chosen
func _ready() -> void:
	var int_trunk = randi_range(1,3)
	var int_foliage = randi_range(1,4)
	
	var trunk = generateTrunk(int_trunk)
	var h_trunk = heightTrunk(int_trunk)
	addCollision(trunk)
	changeColor(trunk,2)
	add_child(trunk)
	
	var foliage = generateFoliage(int_foliage)
	foliage.position.y = (h_trunk)*hlego/62.5 + trunk.position.y
	addCollision(foliage)
	changeColor(foliage,1)
	add_child(foliage)
	
# A trunk skin is chosen
func generateTrunk(int_trunk):
	var trunk
	if int_trunk == 1:
		trunk = trunk1.instantiate()
	elif int_trunk == 2:
		trunk = trunk2.instantiate()
	else:
		trunk = trunk3.instantiate()
	return trunk

func heightTrunk(int_trunk):
	var htrunk
	if int_trunk == 1:
		htrunk = 5
	elif int_trunk == 2:
		htrunk = 6
	else:
		htrunk = 7
	
	return htrunk

# A foliage skin is chosen
func generateFoliage(int_foliage):
	var foliage
	if int_foliage == 1:
		foliage = foliage1.instantiate()
	elif int_foliage == 2:
		foliage = foliage2.instantiate()
	elif int_foliage == 3:
		foliage = foliage3.instantiate()
	else:
		foliage = foliage4.instantiate()
	
	return foliage

# The color is changed, mode=1 for foliage and mode=2 for trunk
func changeColor(node,mode):
	if mode == 1:
		for child in node.get_children():
			if not(child is AnimationPlayer):
				child.set_surface_override_material(0, color_leaf)
	else:
		for child in node.get_children():
			if not(child is AnimationPlayer):
				child.set_surface_override_material(0, color_wood)
		
		

# Collision is added for each children of the node
func addCollision (node):
	var collision
	var box
	var vec3
	for child in node.get_children():
		if not(child is AnimationPlayer):
			child.create_trimesh_collision()
