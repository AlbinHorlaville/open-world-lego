extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

# limit of the viewing range of the player (in chunks)
var limit_view:int = 2


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
