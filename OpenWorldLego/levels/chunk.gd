extends Node

@export var dirt_scene: PackedScene
@export var tree_scene: PackedScene
@export var color_dirt: Material
@export var color_water: Material
@export var color_sand: Material

@export var tailleChunk:int = 16

var coordChunk:Vector2

# Dimension Lego piece 2x2 = 16x16x9,6
var hlego:float = 9.6/16

# To avoid to call an random generator each time we create a chunk,
# We prebuild a random tab and iterate on it to decide if we build a tree on the current block
var TabRandom:Array
var k_TabRandom:int
var is_Build:bool=false
func BuildRandTab() -> void:
	if not is_Build:
		k_TabRandom = 0
		TabRandom = []
		for i in range(100):
			TabRandom.append(randi_range(0, 200))
		is_Build = true

func CreateChunk(x, y, perlin_noise):
	BuildRandTab()
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
				block.position = Vector3(x*tailleChunk+i, int(currentPN*10)*hlego, y*tailleChunk+j)
				
				k_TabRandom+=1
				if k_TabRandom==100:
					k_TabRandom = 0
				## Plant a tree (1 chance per 100)
				if TabRandom[k_TabRandom]==TabRandom[0]:
					var tree = tree_scene.instantiate()
					tree.position = Vector3(tailleChunk*x+i, int(currentPN*10)*hlego, tailleChunk*y+j)
					add_child(tree)
				
			add_child(block)

func getCoordChunk():
	return coordChunk
