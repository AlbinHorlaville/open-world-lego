extends Node3D

var Player
var vitesse
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var posx_player = Player.position.x
	var posz_player = Player.position.z
	var distance = (1 + Player.limit_view)*16
	
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
