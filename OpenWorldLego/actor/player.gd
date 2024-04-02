extends CharacterBody3D

@export var inventory_data : InventoryData # Declares an exported variable to store inventory data

signal toggle_inventory() # Declares a signal which can be emitted to toggle the inventory

# variable keyboard
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var anim = $AnimationPlayer # Reference to the AnimationPlayer node
@onready var sound = $AudioStreamPlayer3D


# Indicates if the camera is currently in first-person mode
var isFirstPerson = true

#variable mouse

# variables to lock the camera (not be able to look back)
var lookAngleHaut = 60.0
var lookAngleBas = -90.0


var mouseSensitivity = 0.4
# mouvement de la souris
var mouseDelta : Vector2


var head : Node3D 

# limit of the viewing range of the player (in chunks)
var limit_view:int = 2


func _ready():
	# Get the camera node
	head = get_node("Head")
	# Remove the mouse and be able to turn indefinitely on the sides
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_physics_process(false)
	
	
func _input(event):
	if event is InputEventMouseMotion :
		# Get the mouse movement
		mouseDelta = event.relative


func _process(delta):
	
	# Switching between first-person and third-person view
	if Input.is_action_just_pressed("toggle_view") and isFirstPerson:
		isFirstPerson = false
		head.position.y = 1.700
		head.position.z = 1.700
	elif Input.is_action_just_pressed("toggle_view") and !isFirstPerson:
		isFirstPerson = true
		head.position.y = 0.915
		head.position.z = -0.199
		
	# Apply rotation to the camera (y-axis)
	head.rotation_degrees -= Vector3(rad_to_deg(mouseDelta.y),0,0) * mouseSensitivity * delta
	
	head.rotation_degrees =  Vector3(clamp(head.rotation_degrees.x,lookAngleBas,lookAngleHaut),head.rotation_degrees.y, head.rotation_degrees.z)
	
	# Rotation on the character
	rotation_degrees -= Vector3(0,rad_to_deg(mouseDelta.x),0) * mouseSensitivity * delta
	# Reset 
	mouseDelta = Vector2()
	
	
	if Input.is_action_just_pressed("inventory") : 
		toggle_inventory.emit()
		
	
	
	
	


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
	
	if velocity.x ==0 && velocity.z ==0:
		anim.stop()
		sound.stop()
	else:
		anim.play("Marche")
		if is_on_floor():
			if !sound.playing:
				sound.stream = load("res://assets/sound/se/footstep.ogg")
				sound.play()
		else:
			sound.stop() 


func addNewBrick():
	var brick = $Head/InteractRay.addNewBrick()
	if brick!=null:
		# Avoid to put a block on the same position than the player
		if position.x>=brick.position.x-1/2 and position.x<=brick.position.x+1/2:
			if position.z>=brick.position.z-1/2 and position.z<=brick.position.z+1/2:
				if position.y>=brick.position.y-0.1 and position.y<=brick.position.y+1.61+0.1:
					return null
	return brick

func getCoordChunk():
	return Vector3(int(position.x/16), int(position.y/16), int(position.z/16))

# Return the position of all neighbors of a chunk in it range vision.
func getBehaviorsChunks():
	var cur_pos =  getCoordChunk()
	var neighbor = []
	for x in range(cur_pos.x-limit_view, cur_pos.x+limit_view+1):
		for y in range(cur_pos.y-1, cur_pos.y+1):
			for z in range(cur_pos.z-limit_view, cur_pos.z+limit_view):
				neighbor.append(Vector3(x, y, z))
	return neighbor


func _on_timer_timeout():
	set_physics_process(true)
