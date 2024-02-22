extends Node

@export var dirt_scene: PackedScene
@export var tree_scene: PackedScene
@export var perlin_noise: Noise
@export var color_dirt: Material
@export var color_water: Material
@export var color_sand: Material

@export var tailleChunk:int = 16

var coordChunk:Vector2

func CreateChunk(x, y):
	coordChunk = Vector2(x, y)
	for i in range(tailleChunk):
		for j in range(tailleChunk):
			var block = dirt_scene.instantiate()
			
			var currentPN = perlin_noise.get_noise_2d(x*tailleChunk+i, y*tailleChunk+j)
			if currentPN < -0.1:
				block.changeMaterial(color_water)
				block.position = Vector3(x*tailleChunk+i, 0, y*tailleChunk+j)
			elif currentPN <= 0.1:
				block.changeMaterial(color_sand)
				block.position = Vector3(x*tailleChunk+i, 0, y*tailleChunk+j)
			else:
				block.changeMaterial(color_dirt)
				block.position = Vector3(x*tailleChunk+i, int(currentPN*10), y*tailleChunk+j)
				
				# Plant a tree (1 chance per 100)
				if randi_range(0, 100)==1:
					var tree = tree_scene.instantiate()
					tree.position = Vector3(tailleChunk*x+i, int(currentPN*10), tailleChunk*y+j)
					add_child(tree)
				
			add_child(block)

func getCoordChunk():
	return coordChunk
