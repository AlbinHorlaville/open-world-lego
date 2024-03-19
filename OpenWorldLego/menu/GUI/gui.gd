extends Control

@onready var fps = $FPS

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Handle ShowDebug.
	if Input.is_action_just_pressed("ShowDebug"):
		fps.visible = !fps.visible
		
	fps.set_text("FPS : " + str(Engine.get_frames_per_second()))

# A Regarder https://www.youtube.com/watch?v=d6bI292_BEk
# Fix le bug des tailles de font
