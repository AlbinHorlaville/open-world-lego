extends Control

@onready var windosModeOptions = $TabContainer/Graphics/MarginContainer/VBoxContainer/HBoxContainer/WindowsModeOption
@onready var resolitionOptions = $TabContainer/Graphics/MarginContainer/VBoxContainer/HBoxContainer2/ResolutionOption

const WINDOWS_MODE : Array[String] = [
	"Window Mode",
	"FullScreen",
	"Borderless Windows",
	"Borderless FullScreen"
] 

const WINDOWS_RESOLUTION : Dictionary = {
	"1280x720" : Vector2i(1280,720),
	"1600x900" : Vector2i(1600,900),
	"1920x1080" : Vector2i(1980,1080),
	"1920x1200" : Vector2i(1920,1200)
}


# Called when the node enters the scene tree for the first time.
func _ready():
	add_windowsMode_item() 
	add_windowsResolution_item()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_windowsMode_item():
	for windows_mode in WINDOWS_MODE:
		windosModeOptions.add_item(windows_mode)

func add_windowsResolution_item():
	for windows_res in WINDOWS_RESOLUTION:
		resolitionOptions.add_item(windows_res)

func _on_full_screen_toggled(toggled_on):
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if toggled_on == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_windows_mode_option_item_selected(index):
	match index:
		0: #Windows Mode
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1: # Fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		2: #Borderless windows
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		3: #Borderless fullscrean
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)


func _on_resolution_option_item_selected(index):
	DisplayServer.window_set_size(WINDOWS_RESOLUTION.values()[index])

