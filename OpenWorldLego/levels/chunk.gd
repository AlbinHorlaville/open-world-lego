extends Node

@export var grass_scene: PackedScene
@export var dirt_scene: PackedScene
@export var sand_scene: PackedScene
@export var water_scene: PackedScene
@export var tree_scene: PackedScene

@export var tailleChunk:int = 16

var coordChunk:Vector3

# save all the bricks in it so we can find them easily for add a new brick to the chunk for example
var DictBlocks:Dictionary = {}

# Dimension Lego piece 2x2 = 16x16x9,6
var hlego:float = 9.6/16

func CreateChunk(x, y, z, perlin_noise_height, perlin_noise_tree):
	coordChunk = Vector3(x, y, z)
	for i in range(tailleChunk):
		for j in range(tailleChunk):
			
			var X = x*tailleChunk+i
			var Z = z*tailleChunk+j
			var block
			
			# Add 0.3 because we want more dirt than water on our map
			var currentPN = perlin_noise_height.get_noise_2d(X, Z)
			
			# Si la hauteur du block se trouve dans la zone du chunk 16x16x16, alors on le construit
			if (int(currentPN*30)*hlego >=y*tailleChunk and int(currentPN*30)*hlego < (y+1)*tailleChunk) or y<1:
				# WATER
				if currentPN > -0.05 and currentPN < -0.03 : # Water that shows up on the sand
					block = water_scene.instantiate()
					block.position = Vector3(X, 0, Z)
					block.changeTransparency() # Set the transparency to 0.5 to see the sand below the water
					$Water.add_child(block)
					DictBlocks[block.position] = block
				if currentPN < -0.05: # 0.5 permit to have few blocks of sand between dirt and water
					block = water_scene.instantiate()
					block.position = Vector3(X, 0, Z)
					$Water.add_child(block)
					DictBlocks[block.position] = block
				else:
					# SAND
					block = sand_scene.instantiate()
					if currentPN < 0:
						block.position = Vector3(X, int(currentPN*10*hlego), Z)
						add_child(block)
						DictBlocks[block.position] = block
					# DIRT
					else:
						block = grass_scene.instantiate()
						# Block at the surface
						block.position = Vector3(X, int(currentPN*30)*hlego, Z)
						add_child(block)
						DictBlocks[block.position] = block
						
						var high_block = block.position.y
						
						# fill the ground of dirt to dig into it
						var k = y
						while k+hlego/2<high_block:
							block = dirt_scene.instantiate()
							block.position = Vector3(X, k, Z)
							#block.set_visible(false)
							add_child(block)
							DictBlocks[block.position] = block
							k+=hlego
							
						# TREE
						PlantTree(perlin_noise_tree, X, high_block, Z)
				
func gradient(x,y):
	return 10*exp(-(((x-500)**2)+((y-500)**2))/1000)

func getCoordChunk():
	return coordChunk

func PlantTree(perlin_noise_tree, x, high_block, z):
	var v_noise_tree = perlin_noise_tree.get_noise_2d(x, z)
	# On est dans une forêt
	if v_noise_tree>0.20:
		var rand = randi_range(1,35)
		if rand == 1:
			var tree = tree_scene.instantiate()
			tree.position = Vector3(x, high_block+hlego, z)
			add_child(tree)
	# On n'est pas dans une forêt
	else:
		var rand = randi_range(1,400)
		if rand == 1:
			var tree = tree_scene.instantiate()
			tree.position = Vector3(x, high_block+hlego, z)
			add_child(tree)
	return

# Add the new block to the tree and to DictBlocks
func addNewBrick(brick):
	if DictBlocks.find_key(brick.position)==null:
		DictBlocks[brick.position] = brick
		add_child(brick)
