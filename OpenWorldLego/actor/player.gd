extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	# var scene_main = get_node("/root/Main")
	# var limit_map = scene_main.
	# get_export("limit_map")
	# # Control that the player doesn't leave the map
	# if position.x < 0:
	# 	position.x = 0
	# elif position.x > limit_map.x:
	#	position.x = limit_map.x
	# if position.y < 0:
	#	position.y = 0
	# elif position.y > limit_map.y:
	#	position.y = limit_map.y
	# if position.z < 0:
	#	position.z = 0
	# elif position.z > limit_map.z:
	#	position.z = limit_map.z

func getCoordChunk():
	return Vector2(int(position.x/16), int(position.z/16))

# Return the position of all neighbors of a chunk and it position.
#  XXX
#  XOX
#  XXX
func getBehaviorsChunks():
	var cur_pos =  getCoordChunk()
	var neighbor = []
	for x in range(cur_pos.x-1, cur_pos.x+2):
		for y in range(cur_pos.y-1, cur_pos.y+2):
			neighbor.append(Vector2(x, y))
	return neighbor
