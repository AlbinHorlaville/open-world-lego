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

# Readjust the color to paint a tree
func recAdjutsColor(node, material):
	for n in node.get_children():
		if n is Brick:
			n.changeMaterial(material)
			# Readjust the y position because a lego bric is not 1 by 1 by 1
			n.position.y = n.position.y * hlego
		else:
			recAdjutsColor(n, material)

func changeColor(node,mode):
	if mode == 1:
		for child in node.get_children():
			if not(child is AnimationPlayer):
				child.set_surface_override_material(0, color_leaf)
	else:
		for child in node.get_children():
			if not(child is AnimationPlayer):
				child.set_surface_override_material(0, color_wood)
		
		
func addCollision (node):
	var collision
	var box
	var vec3
	for child in node.get_children():
		if not(child is AnimationPlayer):
			child.create_trimesh_collision()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var int_trunk = randi_range(1,3)
	var int_foliage = randi_range(1,4)
	
	var h_trunk
	var trunk
	if int_trunk == 1:
		trunk = trunk1.instantiate()
		h_trunk = 5
	elif int_trunk == 2:
		trunk = trunk2.instantiate()
		h_trunk = 6
	else:
		trunk = trunk3.instantiate()
		h_trunk = 7
	addCollision(trunk)
	changeColor(trunk,2)
	add_child(trunk)
	
	var foliage
	if int_foliage == 1:
		foliage = foliage1.instantiate()
	elif int_foliage == 2:
		foliage = foliage2.instantiate()
	elif int_foliage == 3:
		foliage = foliage3.instantiate()
	else:
		foliage = foliage4.instantiate()
		
	foliage.position.y = (h_trunk)*hlego/62.5 + trunk.position.y
	addCollision(foliage)
	changeColor(foliage,1)
	add_child(foliage)
	
