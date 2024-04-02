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
			var process = OS.execute("open -a leocad", [input_file, "-dae", output_file],[],true,true)
			return
		"X11":
			var process = OS.execute("leocad", [input_file, "-dae", output_file],[],true,true)
			return

	var process = OS.execute(leocad_path, [input_file, "-dae", output_file])
	if process != 0:
		print("Erreur lors de la conversion du fichier " + file)
	else:
		print("Conversion du fichier " + file + " terminée.")
		
# Convert of LDraw if not all ready done
static func convertAll():	
	# Should check if the input folder exists
	var inputDir = DirAccess.open(input_folder)
	if inputDir == null:
		# Create Dir file is not created et
		DirAccess.open("user://").make_dir("importedFiles")
		return
	
	var listeOfFiles = DirAccess.open(input_folder).get_files()
	if listeOfFiles.size() == 0:
		return
		
	for file in listeOfFiles:
		if file.ends_with(".ldr") || file.ends_with(".mpd"):
			# si le fichier n'a pas déjà été converti
			if !DirAccess.open(output_folder).file_exists(file.get_basename().split(".")[0] + ".dae"):
				convert_ldr_to_dae(file)
			else:
				print("File " + file + " is already converted")

# Import new Ldraw file into the input folder
static func importNewLDR(filePath : String):
	var outputDir = DirAccess.open(input_folder)
	if outputDir == null:
		DirAccess.open("user://").make_dir("importedFiles")
		outputDir = DirAccess.open(input_folder)

	var fileBasename = filePath.get_file()
	var from = filePath
	var to = ProjectSettings.globalize_path(input_folder) + fileBasename
	var process = DirAccess.copy_absolute(from, to, true)
	if process != OK:
		printerr("Error on the copy of the file " + fileBasename + " in the input folder.")
		return -1
	else:		
		convert_ldr_to_dae(fileBasename)
		# Refresh the list of files in the output folder
		DirAccess.open(output_folder).list_dir_begin()
		return 1
