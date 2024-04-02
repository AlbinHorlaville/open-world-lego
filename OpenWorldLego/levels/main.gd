extends Node


@onready var player : CharacterBody3D = $Player
@onready var inventory_interface : Control = $GUI/InventoryInterface


@export var limit_map: Vector3

@export var Chunk: PackedScene

@export var Cloud: PackedScene

@export var seed:int
@export var perlin_noise_tree: Noise

# Use for imported Node
const nodeCreator = preload("res://externConvertissor/nodeCreator.gd")
const nodeType = preload("res://externConvertissor/nodeType.gd")

var DictChunk_ON:Dictionary # Dictionnary of chunks charged
var DictChunk_OFF:Dictionary # Dictionnary of chunks uncharged
var ChunksToBuild:Array # Chunks that need to be generate in the few next frames
var count:int = 0 # Genere 1 chunk per frame

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Init the dictionnaries
	DictChunk_ON = {}
	DictChunk_OFF = {}
	ChunksToBuild = []
	# The player has to be on positives coordinates
	$Player.position = Vector3(500, 20, 500)
	# Choose the seed for Perlin Noise
	seed = randi_range(0, 100000)
	perlin_noise_tree.set_seed(randi_range(0, 100000))
	# Build some clouds
	GenerateCloud()
	# Appel à la fonction convertissor de fichier
	
	
	# Initiate inventory
	inventory_interface.set_player_inventory_data(player.inventory_data)
	player.toggle_inventory.connect(toggle_inventory_interface)
	
	


func toggle_inventory_interface() -> void :
	inventory_interface.visible = not inventory_interface.visible 
	
	if inventory_interface.visible :
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else : 
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	

func _process(_delta: float) -> void:
	# Create 1 chunk as maximum per frame
	count+=1
	if count==4:
		ChunkInit()
		count=0
	
	updateChunkToCharge()
	addNewBrick()

func ChunkInit():
	if len(ChunksToBuild)>0:
		var pos_chunk = ChunksToBuild.pop_front()
		var chunk = Chunk.instantiate()
		chunk.CreateChunk(pos_chunk.x, pos_chunk.y, pos_chunk.z, seed, perlin_noise_tree)
		DictChunk_ON[pos_chunk] = chunk
		$World.add_child(chunk)
		return

func updateChunkToCharge():
	var neighbors = $Player.getBehaviorsChunks()
	var chunk
	
	# Remove entry of DictChunk_ON who does not appears in neighbors
	for pos_chunk in DictChunk_ON:
		if not pos_chunk in neighbors:
			chunk = DictChunk_ON[pos_chunk]
			DictChunk_OFF[pos_chunk] = chunk
			#chunk.set_visible(false)
			$World.remove_child(chunk)
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
			#chunk.set_visible(true)
			$World.add_child(chunk)
			continue
		if not pos_chunk in ChunksToBuild:
			# Case of new chunk who as to be charged
			# Limit the size of the map to 1000x1000
			if limit_map.x/16>=pos_chunk.x and pos_chunk.x>=0 and limit_map.z/16>=pos_chunk.y and pos_chunk.y>=0:
				ChunksToBuild.append(pos_chunk)

# Create some clouds in the sky
func GenerateCloud():
	var nb_clouds = randi_range(20,40)
	var Player = $Player
	var distance = (1 + Player.limit_view)*16*15
	var posx_player = Player.position.x
	var posz_player = Player.position.z
	# Boucle de création d'un nuage, on instancie son x,y,z en fonction du joueur et sa vitesse (en fonction de sa hauteur)
	for i in range (nb_clouds):
		var cloud = Cloud.instantiate()
		var posx = randi_range(posx_player-distance,posx_player+distance)
		var posz = randi_range (posz_player-distance,posz_player+distance)
		var hauteur_min = 200
		var coeff_hauteur = 4
		var posy = randi_range(1,4)*10*coeff_hauteur+hauteur_min
		cloud.position = Vector3(posx, posy, posz)
		cloud.distance = distance
		
		cloud.Player = Player
		cloud.vitesse = (1 - float(posy-hauteur_min)/(50*coeff_hauteur))*1.5
		
		$Sky.add_child(cloud)

# Return the distance between 2 objects in the world
func distance(p1, p2):
	return sqrt(pow(p1.x-p2.x,2)+pow(p1.y-p2.y,2)+pow(p1.z-p2.z,2))
	
func importCustomerDae(file_path , typeOfImport):
	# Créer une node3D à partir d'un fichier .dae
	print("Importing file: ",file_path)
	print("Type of import: ",typeOfImport)
	var instance = null
	match typeOfImport:
		"Gravity":
			instance = nodeCreator.createGravityNodeOnPlayer(file_path,$Player.position)
		"Basic":
			instance = nodeCreator.createBasicNodeOnPlayer(file_path,$Player.position)
			
	if (instance != null):
		get_tree().get_root().add_child(instance)

func addNewBrick():
	var brick = $Player.addNewBrick()
	if (brick!=null):
		var pos_chunk = Vector3(int(brick.position.x/16), int(brick.position.y/16), int(brick.position.z/16))
		DictChunk_ON[pos_chunk].addNewBrick(brick)
