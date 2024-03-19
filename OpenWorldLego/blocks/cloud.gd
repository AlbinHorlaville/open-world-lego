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
	if n==0:
		var model = model1.instantiate()
		add_child(model)
	elif n==1:
		var model = model2.instantiate()
		add_child(model)
	else:
		var model = model3.instantiate()
		add_child(model)
	pass # Replace with function body.


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
	
	position.x += vitesse*delta*0.1
	pass

