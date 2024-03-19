extends Node

@export var dirt_scene: PackedScene
@export var water_scene: PackedScene
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

func CreateChunk(x, y, perlin_noise_height, perlin_noise_tree):
	BuildRandTab()
	coordChunk = Vector2(x, y)
	for i in range(tailleChunk):
		for j in range(tailleChunk):
			
			var X = x*tailleChunk+i
			var Y = y*tailleChunk+j
			var block
			
			# Add 0.3 because we want more dirt than water on our map
			var currentPN = 0.3+perlin_noise_height.get_noise_2d(X, Y)
			
			# WATER
			if currentPN > -0.05 and currentPN < -0.03 : # Water that shows up on the sand
				block = water_scene.instantiate()
				block.changeMaterial()
				block.position = Vector3(X, 0, Y)
				block.changeTransparency() # Set the transparency to 0.5 to see the sand below the water
				$Water.add_child(block)
			if currentPN < -0.05: # 0.5 permit to have few blocks of sand between dirt and water
				block = water_scene.instantiate()
				block.changeMaterial()
				block.position = Vector3(X, 0, Y)
				$Water.add_child(block)
			else:
				# SAND
				block = dirt_scene.instantiate()
				if currentPN < 0:
					block.initMaterial(color_sand)
					block.position = Vector3(X, int(currentPN*10*hlego), Y)
					add_child(block)
				# DIRT
				else:
					# Block at the surface
					block.initMaterial(color_dirt)
					block.position = Vector3(X, int(currentPN*10)*hlego, Y)
					add_child(block)
					
					var high_block = block.position.y
					
					# fill the ground of dirt to dig into it
					for k in range(0, int(high_block/hlego+1)):
						block = dirt_scene.instantiate()
						block.initMaterial(color_dirt)
						block.position = Vector3(X, k*hlego, Y)
						block.set_visible(false)
						add_child(block)
						
					# TREE
					PlantTree(perlin_noise_tree,X,Y,high_block,hlego)
				
func gradient(x,y):
	return 10*exp(-(((x-500)**2)+((y-500)**2))/1000)

func getCoordChunk():
	return coordChunk

func PlantTree(perlin_noise_tree,x,y,high_block,hlego):
	var v_noise_tree = perlin_noise_tree.get_noise_2d(x, y)
	# On est dans une forêt
	if v_noise_tree>0.20:
		var rand = randi_range(1,35)
		if rand == 1:
			var tree = tree_scene.instantiate()
			tree.position = Vector3(x, high_block+hlego, y)
			add_child(tree)
	# On n'est pas dans une forêt
	else:
		var rand = randi_range(1,400)
		if rand == 1:
			var tree = tree_scene.instantiate()
			tree.position = Vector3(x, high_block+hlego, y)
			add_child(tree)
	return
