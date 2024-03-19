extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$PanelContainer/MarginContainer/VBoxContainer/StartButton.grab_focus()
	$Convertissor.convertAll()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://levels/main.tscn")


func _on_quit_button_pressed():
	get_tree().quit(1)


func _on_option_button_pressed():
	get_tree().change_scene_to_file("res://menu/FirstMenu/option_menu.tscn")

#Image Background made by Fez Escalante
