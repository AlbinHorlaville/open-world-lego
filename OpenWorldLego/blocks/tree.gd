extends Node3D

# Dimension Lego piece 2x2 = 16x16x9,6
var hlego:float = 9.6/16

# Readjust the y position because a lego bric is not 1 by 1 by 1
func recAdjustY(node):
	for n in node.get_children():
		if n is StaticBody3D:
			n.position.y = n.position.y * hlego
		else:
			recAdjustY(n)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	recAdjustY(self)
