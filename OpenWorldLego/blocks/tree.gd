extends Node3D

@export var color_leaf: Material
@export var color_wood: Material

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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	recAdjutsColor($Tronc, color_wood)
	recAdjutsColor($Leaf, color_leaf)
