extends Node

@export var limit_map: Vector3

@export var Chunk: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generateMap()

func generateMap() -> void:
	# Change the seed each time we play the game, comment to change it manualy
	# perlin_noise.seed = randi()
	# generate every block on the map
	for i in range(limit_map.x/16): # gives the number of chunks
		for j in range(limit_map.z/16): # gives the number of chunks
			var chunk = Chunk.instantiate()
			chunk.CreateChunk(i, j)
			$World.add_child(chunk)

func _process(delta: float) -> void:
	var children = $World.get_children()
	for child in children:
		if child is Node:
			if distance(child.getCoordChunk(), $Player.getCoordChunk())<2:
				child.set_visible(true)
			else:
				child.set_visible(false)

func distance(p1, p2):
	return sqrt(pow(p1.x-p2.x,2)+pow(p1.y-p2.y,2)+pow(p1.z-p2.z,2))
