extends Node

class_name LoadComponent

var compounds_folder = "res://Scripts/Game_Items/_compounds/"
var elements_folder = "res://Scripts/Game_Items/_elements/"
var metals_folder = "res://Scripts/Game_Items/_metals/"
var recipes_folder = "res://Scripts/Game_Items/_recipes/"
var player_save_file = "user://player_save.save"
var default_player_save = "res://Scripts/player/player_save.gd"
@export var compounds : Array[Compound]
@export var metals : Array[Metal]
@export var recipes : Array[Recipe]
var player_save

func save_file_json(file_to_save : String, file_data):
	var file = FileAccess.open(file_to_save, FileAccess.WRITE)
	file.store_line(JSON.stringify(file_data))

func load_file_json(file_to_load):
	if not FileAccess.file_exists(file_to_load):
		save_file_json(file_to_load, default_player_save)
		return
	var file = FileAccess.open(file_to_load, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	return data

func load_resources(folder_location):
	var loaded_resources = []
	var file_paths = get_all_file_paths(folder_location)
	for path in file_paths:
		if ResourceLoader.exists(path):
			var resource = ResourceLoader.load(path,"Script")
			loaded_resources.append(resource)
			print(resource)
	return loaded_resources

func get_all_file_paths(folder_location):
	var file_paths: Array[String] = []  
	var dir = DirAccess.open(folder_location)  
	dir.list_dir_begin()  
	var file_name = dir.get_next()  
	while file_name != "":  
		var file_path = folder_location + "/" + file_name  
		if dir.current_is_dir():  
			file_paths += get_all_file_paths(file_path)  
		else:  
			file_paths.append(file_path)  
		file_name = dir.get_next()  
	return file_paths
	
func load_resource(file_location):
	if ResourceLoader.exists(file_location):
		return load(file_location)
	return null
	
func load_player_save():
	if FileAccess.file_exists(player_save_file):
		var file = FileAccess.open(player_save_file, FileAccess.READ)
		return file.get_var()
	else:
		print("New Save")
		var new_save = load(default_player_save)
		save_player_save(new_save)
		return new_save
		
func save_player_save(player_save):
	#ResourceSaver.save(player_save, player_save_file)
	var file = FileAccess.open(player_save_file, FileAccess.WRITE)
	file.store_var(player_save)
	

#func save_character_data(data):
	#ResourceSaver.save(data, save_path)
	
func _ready():
	var base_compounds = load_resources(compounds_folder)
	for compound in base_compounds:
		if compound is Compound: 
			compounds.append(compound)
	var base_metals = load_resources(metals_folder)
	for metal in base_metals:
		if metal is Metal:
			metals.append(metal)
	var base_recipes = load_resources(recipes_folder)
	for recipe in base_recipes:
		if recipe is Recipe:
			recipes.append(recipe)
	player_save = load_player_save()
	print(compounds)
	print(metals)
	print(recipes)
	print(player_save)
