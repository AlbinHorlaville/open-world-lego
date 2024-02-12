extends Node

@export var dirt_scene: PackedScene
@export var limit_map: Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(limit_map.x):
		for j in range(limit_map.z):
			var dirt = dirt_scene.instantiate()
			dirt.position = Vector3(i, 0, j)
			add_child(dirt)
	print(self.get_path())
