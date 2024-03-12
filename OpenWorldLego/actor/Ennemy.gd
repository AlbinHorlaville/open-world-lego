extends CharacterBody3D


var player : CharacterBody3D


var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var speed = 1.5


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_root().get_node("Main/Player")
	
	
func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	
	var dir = (player.position - position).normalized()
	dir.y = 0;
	
	velocity += dir*speed
	move_and_slide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

