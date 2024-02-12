extends Node


@export var dirt_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(100):
		for j in range(100):
			var dirt = dirt_scene.instantiate()
			dirt.position = Vector3(i, 0, j)
			add_child(dirt)
