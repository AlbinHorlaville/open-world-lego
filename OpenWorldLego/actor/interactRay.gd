extends RayCast3D

var b_destroying
var destroyTimer : Timer
var createTimer : Timer
var b_creating
# Dimension Lego piece 2x2 = 16x16x9,6
var hlego:float = 9.6/16

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_exception(owner)
	destroyTimer = $Destroy
	createTimer = $Create
	createTimer.set_one_shot(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handleLeftClick()
	handleRightClick()

# Check if the player did a left click
func handleRightClick():
	var dirt = load("res://blocks/dirt.tscn")
	if createTimer.is_stopped() and Input.is_action_pressed("Action") and is_colliding():
		var collided = get_collider()
		var brick = dirt.instantiate()
		brick.material = load("res://materials/Water.tres")
		brick.changeMaterial(brick.material)
		
		# In function of wich face we clicked on, we determine the position of the new object
		
		brick.position = get_pos_object(collided.position)
		
		b_creating = brick # Brick to save to add to the tree game
		createTimer.start(0.1)

# Return the position of the new object in function of the collision point
func get_pos_object(pos_brick):
	var size_col = get_collider().get_collision().shape.size
	var pos_collision = get_collision_point()
	# UP FACE
	if pos_collision.y>=pos_brick.y-0.1 and pos_collision.y<=pos_brick.y+0.1:
		return pos_brick+Vector3(0, hlego, 0)
	# DOWN FACE
	if pos_collision.y>=pos_brick.y-size_col.y-0.1 and pos_collision.y<=pos_brick.y-size_col.y+0.1:
		return pos_brick+Vector3(0, -hlego, 0)
	# EAST FACE
	if pos_collision.x>=pos_brick.x+size_col.x/2-0.1 and pos_collision.x<=pos_brick.x+size_col.x/2+0.1:
		return pos_brick+Vector3(1, 0, 0)
	# WEST FACE
	if pos_collision.x>=pos_brick.x-size_col.x/2-0.1 and pos_collision.x<=pos_brick.x-size_col.x/2+0.1:
		return pos_brick+Vector3(-1, 0, 0)
	# NORTH FACE
	if pos_collision.z>=pos_brick.z+size_col.z/2-0.1 and pos_collision.z<=pos_brick.z+size_col.z/2+0.1:
		return pos_brick+Vector3(0, 0, 1)
	# SOUTH FACE
	if pos_collision.z>=pos_brick.z-size_col.z/2-0.1 and pos_collision.z<=pos_brick.z-size_col.z/2+0.1:
		return pos_brick+Vector3(0, 0, -1)
	# ERROR CASE
	return null
	

# Return a brick to add to the game tree
func addNewBrick():
	var res = b_creating
	b_creating = null
	return res

# Check if the player did a left click
func handleLeftClick():
	if Input.is_action_pressed("Hit") and is_colliding():
		if b_destroying != get_collider():
			if b_destroying!=null and b_destroying.has_method("is_destroyable"):
				b_destroying.resetMaterial()
			b_destroying = get_collider()
			if b_destroying.has_method("is_destroyable") and b_destroying.is_destroyable():
				destroyTimer.start(1)
				b_destroying.changeMaterial(load("res://materials/Destroying.tres"))
	else:
		if b_destroying!=null and b_destroying.has_method("is_destroyable"):
			b_destroying.resetMaterial()
		b_destroying = null
		destroyTimer.stop()


func _on_timer_timeout() -> void:
	if b_destroying!=null:
		# Destroy the block
		b_destroying.free()
