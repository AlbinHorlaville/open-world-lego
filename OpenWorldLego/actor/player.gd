extends CharacterBody3D

# variable keyboard
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

#variable mouse

# var pour bloquer la caméra (ne pas pouvoir regarder en arrière)
var lookAngleHaut = 60.0
var lookAngleBas = -90.0


var mouseSensitivity = 0.4
# mouvement de la souris
var mouseDelta : Vector2


var camera : Camera3D 

# limit of the viewing range of the player (in chunks)
var limit_view:int = 2


func _ready():
	# On récup le neoud camera
	camera = get_node("Camera3D")
	# Permet d'enlever la souris et pouvoir tourner sur les cotés indéfiniement
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	
func _input(event):
	if event is InputEventMouseMotion :
		# On récup le mouvement de la souris
		mouseDelta = event.relative


func _process(delta):
	# On applique la rotation sur la caméra (axe y)
	camera.rotation_degrees -= Vector3(rad_to_deg(mouseDelta.y),0,0) * mouseSensitivity * delta
	
	camera.rotation_degrees =  Vector3(clamp(camera.rotation_degrees.x,lookAngleBas,lookAngleHaut),camera.rotation_degrees.y, camera.rotation_degrees.z)
	
	# rotation sur le perso
	rotation_degrees -= Vector3(0,rad_to_deg(mouseDelta.x),0) * mouseSensitivity * delta
	# reinit 
	mouseDelta = Vector2()
	

func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Handle BackTomenu
	if Input.is_action_just_pressed("BackToMenu"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene_to_file("res://menu/FirstMenu/main_menu.tscn")

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func getCoordChunk():
	return Vector2(int(position.x/16), int(position.z/16))

# Return the position of all neighbors of a chunk in it range vision.
func getBehaviorsChunks():
	var cur_pos =  getCoordChunk()
	var neighbor = []
	for x in range(cur_pos.x-limit_view, cur_pos.x+limit_view+1):
		for y in range(cur_pos.y-limit_view, cur_pos.y+limit_view+1):
			neighbor.append(Vector2(x, y))
	return neighbor
