extends Control

@onready var fps = $FPS
@onready var convertissorMenu = $Convertissor

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Handle ShowDebug.
	fps.set_text("FPS : " + str(Engine.get_frames_per_second()))
	if Input.is_action_just_pressed("ShowDebug"):
		fps.visible = !fps.visible
		
	if Input.is_action_just_pressed("convertissorMenu"):
		get_tree().get_root().get_node("Main").get_node("Player").set_physics_process(false)
		get_tree().get_root().get_node("Main").get_node("Player").set_process_input(false)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		convertissorMenu.visible = true

# A Regarder https://www.youtube.com/watch?v=d6bI292_BEk
# Fix le bug des tailles de font
