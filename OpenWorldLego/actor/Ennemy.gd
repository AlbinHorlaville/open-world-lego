extends CharacterBody3D


var player : CharacterBody3D

const JUMP_VELOCITY = 4.5


var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var speed = 2


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_root().get_node("Main/Player")
	set_physics_process(false)
	
	
func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	# Gestion du saut automatique des obstacles
	if is_on_wall() and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
		
	# IA de déplacement de l'ennemi
	var dir = (player.position - position).normalized()*speed
	dir.y = 0;
	velocity += dir*delta
	move_and_slide()
	
	look_at(player.global_transform.origin,Vector3.UP)
	rotate_object_local(Vector3.UP,3.14)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	






func _on_timer_timeout():
	set_physics_process(true)
