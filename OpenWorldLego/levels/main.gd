extends Node

@export var limit_map: Vector3

@export var Chunk: PackedScene

var DictChunk_ON:Dictionary # Dictionnary of chunks charged
var DictChunk_OFF:Dictionary # Dictionnary of chunks uncharged

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DictChunk_ON = {}
	DictChunk_OFF = {}
	# The player has to be on positives coordinates
	$Player.position = Vector3(500, 10, 500)

func _process(_delta: float) -> void:
	var neighbors = $Player.getBehaviorsChunks()
	var chunk
	
	# Remove entry of DictChunk_ON who does not appears in neighbors
	for pos_chunk in DictChunk_ON:
		if not pos_chunk in neighbors:
			chunk = DictChunk_ON[pos_chunk]
			DictChunk_OFF[pos_chunk] = chunk
			chunk.set_visible(false)
			DictChunk_ON.erase(pos_chunk)

	# Update DictChunk_ON and DictChunk_OFF
	for pos_chunk in neighbors:
		if pos_chunk in DictChunk_ON:
			continue
		if pos_chunk in DictChunk_OFF:
			# Get the chunk and place it in DictChunk_ON
			chunk = DictChunk_OFF[pos_chunk]
			DictChunk_OFF.erase(pos_chunk)
			DictChunk_ON[pos_chunk] = chunk
			chunk.set_visible(true)
			continue
		# Case of new chunk who as to be charged
		chunk = Chunk.instantiate()
		chunk.CreateChunk(pos_chunk.x, pos_chunk.y)
		chunk.set_visible(true)
		DictChunk_ON[pos_chunk] = chunk
		$World.add_child(chunk)

func distance(p1, p2):
	return sqrt(pow(p1.x-p2.x,2)+pow(p1.y-p2.y,2)+pow(p1.z-p2.z,2))
	
