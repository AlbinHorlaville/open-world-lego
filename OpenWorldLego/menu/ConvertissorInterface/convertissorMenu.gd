extends Control

var output_folder = "res://externConvertissor/convertedFiles/"
@onready var fileToImport = $MarginContainer/Panel/VBoxContainer/FileToImport

# Called when the node enters the scene tree for the first time.
func _ready():
	addItemsToOption()
	

func addItemsToOption():
	# Should check if the input folder exists
	var listeOfFiles = DirAccess.open(output_folder).get_files()
	
	if listeOfFiles.size() == 0:
		print("Aucun fichier LDraw trouvé dans le dossier d'entrée.")
		return
		
	for file in listeOfFiles:
		if file.ends_with(".dae"):
			# Ajouter un noeud
			fileToImport.add_item(file.get_basename().split(".")[0])

func addOneItemToOption(file):
	fileToImport.add_item(file)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("cancel"):
		goBackToGame()

func _on_import_pressed():
	var index = fileToImport.get_index()
	var listeOfFiles = DirAccess.open(output_folder).get_files()
	
	if listeOfFiles.size() == 0:
		print("Aucun fichier LDraw trouvé dans le dossier d'entrée.")
		return

	var i = 1
	var fileToImport = ""
	for file in listeOfFiles:
		if file.ends_with(".dae"):
			if i == index:
				fileToImport = file
				break
			i += 1
	
	print("Fichier sélectionné : " + fileToImport)
	# Appeler le script d'import sur main
	if fileToImport != "":
		get_tree().get_root().get_node("Main").importCustomerDae(output_folder + fileToImport)
		
	goBackToGame()
	
func goBackToGame():
	self.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().get_root().get_node("Main").get_node("Player").set_physics_process(true)
	get_tree().get_root().get_node("Main").get_node("Player").set_process_input(true)
	
	


func _on_cancel_pressed():
	goBackToGame()
