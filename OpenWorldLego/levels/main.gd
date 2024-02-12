extends Node

@export var dirt_scene: PackedScene
@export var limit_map: Vector3
@export var perlin_noise: Noise
@export var color_dirt: Material
@export var color_water: Material

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	perlin_noise.seed = randi()
	for i in range(limit_map.x):
		for j in range(limit_map.z):
			var dirt = dirt_scene.instantiate()
			generateGround(dirt, i, j)
			dirt.position = Vector3(i, 0, j)
			add_child(dirt)
	
func generateGround(block:Node, x, y) -> void:
	var currentPN = perlin_noise.get_noise_2d(x, y)
	if currentPN > -0.1:
		block.changeMaterial(color_dirt)
	else:
		block.changeMaterial(color_water)
	
