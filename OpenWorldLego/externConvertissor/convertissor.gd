extends Node

static var input_folder = "user://importedFiles/"
static var output_folder = "res://externConvertissor/convertedFiles/"
static var leocad_path = "C:\\Program Files\\LeoCAD\\LeoCAD.exe"

# Called when the node enters the scene tree for the first time.

static func convert_ldr_to_dae(file: String):
	var input_file = ProjectSettings.globalize_path(input_folder) + file
	var output_file = ProjectSettings.globalize_path(output_folder) + file.get_basename().split(".")[0] + ".dae"
	# Appeler LeoCAD en mode CLI pour convertir le fichier LDraw en DAE 
	# Exemple: leocad input.ldr -dae output.dae
	match OS.get_name():
		"Windows":
			var process = OS.execute(leocad_path, [input_file, "-dae", output_file],[],true,true)
		"OSX":
			print("MacOS not supported yet.")
			return
		"X11":
			print("Linux not supported yet.")
			return

	var process = OS.execute(leocad_path, [input_file, "-dae", output_file])
	if process != 0:
		print("Erreur lors de la conversion du fichier " + file)
	else:
		print("Conversion du fichier " + file + " terminée.")

static func convertAll():
	# Parcourir les fichiers LDraw dans le dossier d'entrée
	
	# Should check if the input folder exists
	var inputDir = DirAccess.open(input_folder)
	if inputDir == null:
		print("Le dossier d'entrée n'existe pas.")
		DirAccess.open("user://").make_dir("importedFiles")
		return
	
	var listeOfFiles = DirAccess.open(input_folder).get_files()
	if listeOfFiles.size() == 0:
		print("Aucun fichier LDraw trouvé dans le dossier d'entrée.")
		return
		
	print("Conversion en cours...")
	for file in listeOfFiles:
		if file.ends_with(".ldr"):
			convert_ldr_to_dae(file)
	print("Conversion All terminée.")

static func importNewLDR(filePath : String):
	var outputDir = DirAccess.open(input_folder)
	if outputDir == null:
		DirAccess.open("user://").make_dir("importedFiles")
		outputDir = DirAccess.open(input_folder)

	var fileBasename = filePath.get_file()
	var from = filePath
	var to = ProjectSettings.globalize_path(input_folder) + fileBasename
	print("from: " + from)
	print("to: " + to)
	var process = DirAccess.copy_absolute(from, to, true)
	if process != OK:
		print("Erreur lors de la copie du fichier " + fileBasename + " dans le dossier d'entrée.")
		return -1
	else:
		print("Fichier " + fileBasename + " copié dans le dossier d'entrée.")
		convert_ldr_to_dae(fileBasename)
		return 1
