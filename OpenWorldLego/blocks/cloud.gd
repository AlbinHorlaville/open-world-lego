extends Node3D
@export var model1: PackedScene
@export var model2: PackedScene
@export var model3: PackedScene

var Player
var vitesse
var distance
# Called when the node enters the scene tree for the first time.
func _ready():
	var n = randi_range(0, 2)
	var model
	if n==0:
		model = model1.instantiate()
	elif n==1:
		model = model2.instantiate()
	else:
		model = model3.instantiate()
	add_child(model)
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var posx_player = Player.position.x
	var posz_player = Player.position.z
	
	# Verification si nuage sort de la limite range of view en x
	if position.x > posx_player + distance:
		position.x = posx_player - distance
	if position.x < posx_player - distance:
		position.x = posx_player + distance
	
	# Verification si nuage sort de la limite range of view en z
	if position.z > posz_player + distance:
		position.z = posz_player - distance
	if position.z < posz_player - distance:
		position.z = posz_player + distance
	
	position.x += vitesse*delta
	pass

