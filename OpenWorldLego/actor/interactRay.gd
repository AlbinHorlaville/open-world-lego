extends RayCast3D

var current_block
var destroyTimer : Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_exception(owner)
	destroyTimer = $Timer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
