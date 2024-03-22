extends RayCast3D

var current_block
var destroyTimer : Timer
var createTimer : Timer
var lego
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
		brick.position = collided.position
		lego = brick # Brick to save to add to the tree game
		createTimer.start(0.1)

# Return a brick to add to the game tree
func addNewBrick():
	var res = lego
	lego = null
	return res

# Check if the player did a left click
func handleLeftClick():
	if Input.is_action_pressed("Hit") and is_colliding():
		if current_block != get_collider():
			if current_block!=null and current_block.has_method("is_destroyable"):
				current_block.resetMaterial()
			current_block = get_collider()
			if current_block.has_method("is_destroyable"):
				destroyTimer.start(1)
				current_block.changeMaterial(load("res://materials/Destroying.tres"))
	else:
		if current_block!=null and current_block.has_method("is_destroyable"):
			current_block.resetMaterial()
		current_block = null
		destroyTimer.stop()


func _on_timer_timeout() -> void:
	if current_block!=null:
		# Destroy the block
		current_block.free()
