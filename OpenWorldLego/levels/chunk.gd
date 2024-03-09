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
			
			# Add 0.3 because we want more dirt than water on our map
			var currentPN = 0.3+perlin_noise.get_noise_2d(x*tailleChunk+i, y*tailleChunk+j)
			
			# WATER
			if currentPN < -0.05: # 0.5 permit to have few blocks of sand between dirt and water
				block.changeMaterial(color_water)
				block.position = Vector3(x*tailleChunk+i, 0, y*tailleChunk+j)
			# SAND
			elif currentPN < 0:
				block.changeMaterial(color_sand)
				block.position = Vector3(x*tailleChunk+i, int(currentPN*10+1)*hlego, y*tailleChunk+j)
			# DIRT
			else:
				# fill the ground of dirt to dig into it
				for k in range(0, int(currentPN*10+1)):
					block.changeMaterial(color_dirt)
					block.position = Vector3(x*tailleChunk+i, k*hlego, y*tailleChunk+j)
					block.set_visible(false)
					add_child(block)
					block = dirt_scene.instantiate()
				# TREE
				k_TabRandom+=1
				if k_TabRandom==100:
					k_TabRandom = 0
				# Plant a tree (1 chance per 100)
				if TabRandom[k_TabRandom]==TabRandom[0]:
					var tree = tree_scene.instantiate()
					tree.position = Vector3(tailleChunk*x+i, int(currentPN*10)*hlego, tailleChunk*y+j)
					add_child(tree)
				# Block at the surface
				block.changeMaterial(color_dirt)
				block.position = Vector3(x*tailleChunk+i, int(currentPN*10+1)*hlego, y*tailleChunk+j)
				block.set_visible(true)
			add_child(block)

func getCoordChunk():
	return coordChunk
