extends Control

@onready var fileToImport = $MarginContainer/Panel/VBoxContainer/SubVBox/FileToImport
@onready var typeOfNode = $MarginContainer/Panel/VBoxContainer/SubVBox/TypeOfNode
@onready var subBox = $MarginContainer/Panel/VBoxContainer/SubVBox
@onready var emptyFolder = $MarginContainer/Panel/VBoxContainer/EmptyFolderLabel

const nodeType = preload("res://externConvertissor/nodeType.gd")
const convertissor = preload("res://externConvertissor/convertissor.gd")


var output_folder = convertissor.output_folder

# Called when the node enters the scene tree for the first time.
func _ready():
	addItemsToOption()
	addItemsToTypeOfNode()

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

func addItemsToTypeOfNode():
	# Get the list of node type 
	for type in nodeType.type:
		typeOfNode.add_item(type)

func addOneItemToOption(file):
	fileToImport.add_item(file)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("cancel"):
		goBackToGame()
	if DirAccess.open(output_folder).get_files().size() == 0:
		emptyFolder.visible = true
		subBox.visible = false
	else:
		emptyFolder.visible = false
		subBox.visible = true

func _on_import_pressed():
	# index du fichier à importer
	var index = fileToImport.get_selected_id()
	var listeOfFiles = DirAccess.open(output_folder).get_files()
	
	if listeOfFiles.size() == 0:
		print("Aucun fichier LDraw trouvé dans le dossier d'entrée.")
		return

	var i = 0
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
		i = 0
		for type in nodeType.type:
			# Check if the type of node is the same as the one selected
			var test = typeOfNode.get_selected_id()
			if i == typeOfNode.get_selected_id():
				get_tree().get_root().get_node("Main").importCustomerDae(output_folder + fileToImport, type)
				break
			i += 1
		
	goBackToGame()
	
func goBackToGame():
	self.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().get_root().get_node("Main").get_node("Player").set_physics_process(true)
	get_tree().get_root().get_node("Main").get_node("Player").set_process_input(true)

func _on_cancel_pressed():
	goBackToGame()


func _on_file_dialog_file_selected(path):
	# Check if the file is a .dae file
	if path.ends_with(".ldr"):
		var process = convertissor.importNewLDR(path)
		if process == 1:
			#Flush the list
			fileToImport.clear()
			# Add the file to the list
			addItemsToOption()
	else:
		print("Le fichier sélectionné n'est pas un fichier LDraw.")
		
func _on_import_file_pressed():
	# Open a file dialog to select only one file to import in the import folder
	var dialog = FileDialog.new()
	dialog.set_access(FileDialog.ACCESS_FILESYSTEM)
	dialog.set_current_dir(output_folder)
	dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	get_tree().get_root().add_child(dialog)
	dialog.set_size( get_viewport().get_size())
	dialog.popup_centered()
	# put the dialog to the size of the screen

	# Restrict the file type to .ldr
	dialog.clear_filters()
	dialog.add_filter("*.ldr", "LDraw File")

	dialog.connect("file_selected", _on_file_dialog_file_selected)
	# Add to tree

	


