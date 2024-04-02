extends Node

@export var grass_scene: PackedScene
@export var dirt_scene: PackedScene
@export var sand_scene: PackedScene
@export var water_scene: PackedScene
@export var snow_scene: PackedScene
@export var tree_scene: PackedScene

@export var noise_humidity: Noise
@export var noise_temperature: Noise

@export var noise_biome_ocean: Noise
@export var noise_biome_plaine: Noise
@export var noise_biome_montagne: Noise
@export var noise_biome_foret: Noise

# The variable of the current noise to use in building chunks
var current_biome_noise: Noise
var max_height:int

@export var tailleChunk:int = 16

var coordChunk:Vector3

# save all the bricks in it so we can find them easily for add a new brick to the chunk for example
var DictBlocks:Dictionary = {}

# Dimension Lego piece 2x2 = 16x16x9,6
var hlego:float = 9.6/16

func CreateChunk(x, y, z, seed, perlin_noise_tree):
	noise_humidity.set_seed(seed)
	noise_temperature.set_seed(seed)
	
	noise_biome_ocean.set_seed(seed)
	noise_biome_plaine.set_seed(seed)
	noise_biome_montagne.set_seed(seed)
	noise_biome_foret.set_seed(seed)

	coordChunk = Vector3(x, y, z)
	for i in range(tailleChunk):
		for j in range(tailleChunk):
			
			var X = x*tailleChunk+i
			var Z = z*tailleChunk+j
			var block
			
			current_biome_noise = get_biome_noise(X, Z)
			var y_value
			if current_biome_noise==noise_biome_plaine:
				y_value = 0.2+current_biome_noise.get_noise_2d(X, Z)
			elif current_biome_noise==noise_biome_ocean:
				y_value = 0
			elif current_biome_noise==noise_biome_montagne:
				y_value = 0.2+current_biome_noise.get_noise_2d(X, Z)
			else:
				y_value = 0.1+current_biome_noise.get_noise_2d(X, Z)
			y_value = normalize(y_value)
			
			#var what_biome = (noise_humidity.get_noise_2d(X, Z)+noise_temperature.get_noise_2d(X, Z)+2)/4
			#max_height = 30
			#var y_value = (what_biome*noise_biome_montagne.get_noise_2d(X, Z) + (1-what_biome)*noise_biome_foret.get_noise_2d(X, Z))
			# Si la hauteur du block se trouve dans la zone du chunk 16x16x16, alors on le construit
			if (int(y_value*max_height)*hlego >=y*tailleChunk and int(y_value*max_height)*hlego < (y+1)*tailleChunk) or y<1:
				# WATER
				if y_value > 0.01 and y_value < 0.02 : # Water that shows up on the sand
					block = water_scene.instantiate()
					block.position = Vector3(X, 0, Z)
					block.changeTransparency() # Set the transparency to 0.5 to see the sand below the water
					$Water.add_child(block)
					DictBlocks[block.position] = block
				if y_value <= 0.01: # 0.5 permit to have few blocks of sand between dirt and water
					block = water_scene.instantiate()
					block.position = Vector3(X, 0, Z)
					$Water.add_child(block)
					DictBlocks[block.position] = block
				# Sand
				elif y_value < 0.08:
						block = sand_scene.instantiate()
						block.position = Vector3(X, int(y_value*max_height*hlego), Z)
						add_child(block)
						DictBlocks[block.position] = block
						
						var high_block = block.position.y
						
						# fill the ground of dirt to dig into it
						var k = y
						while k+hlego/2<high_block:
							block = sand_scene.instantiate()
							block.position = Vector3(X, k, Z)
							#block.set_visible(false)
							add_child(block)
							DictBlocks[block.position] = block
							k+=hlego
				# DIRT
				else:
					block = grass_scene.instantiate()
					# Block at the surface
					block.position = Vector3(X, int(y_value*max_height)*hlego, Z)
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

# Return the current biome noise for a coordinate
func get_biome_noise(x,z):
	var humidity_value = noise_humidity.get_noise_2d(x, z)
	var temperature_value = noise_temperature.get_noise_2d(x, z)
	if humidity_value > 0:
		if temperature_value > 0:
			max_height = 0
			return noise_biome_ocean
		else:
			max_height = 10
			return noise_biome_foret
	else:
		if temperature_value > 0:
			max_height = 5
			return noise_biome_plaine
		else:
			max_height = 40
			return noise_biome_montagne

# (data - min(data)) / (max(data) - min(data))
func normalize(value):
	return value+1/2

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
