extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	var Cyclop = load("res://actor/Ennemy.tscn")
	var cyclop = Cyclop.instantiate()
	
	add_child(cyclop)	
	
	cyclop.position = Vector3(510,10,510)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
