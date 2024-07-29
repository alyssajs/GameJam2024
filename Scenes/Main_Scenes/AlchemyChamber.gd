extends Node2D
@onready
var metal_list = $GameUI/Control/GridContainer/Metals/metal_list
@onready
var compound_list = $GameUI/Control/GridContainer/Compounds/compound_list

@onready 
var cook_label = $GameUI/Control/GridContainer/Alchemize/cook_label
@onready
var cook_slider = $GameUI/Control/GridContainer/Alchemize/cook_timer_slider

var cook_timer := 4 
var cooking := false
var metals_selected
var compounds_selected
var element_buttons_clicked : Array[AlchemyEnums.Elements]
var cook_time_default := 300
var cook_label_default_text = "Add Elements to Mix!!"

func _ready():
	metals_selected = []
	compounds_selected = []
	cook_label.visible = false
	cook_label.text = cook_label_default_text
	cook_slider.visible = false
	set_item_lists()

	
func set_item_lists():
	metal_list.clear()
	for metal in Loader.player_save.metals_unlocked:
		metal_list.add_item(metal.metal_name, null, true)

	compound_list.clear()
	for compound in Loader.player_save.compounds_unlocked:
		compound_list.add_item(compound.compound_name, null, true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(cooking and cook_timer > 0):
		cook_timer -= delta
		cook_slider.value = cook_timer
		if not cook_label.visible:
			cook_label.visible = true
		if not cook_slider.visible:
			cook_slider.visible = true
	elif (cooking and cook_timer <= 0):
		finish_cooking()
		
func finish_cooking():
	match_metal_to_selected()
	match_compound_to_selected()
	cooking = false
	var learned_recipe = check_recipe()
	if learned_recipe:
		if learned_recipe.compound_output:
			if not Loader.player_save.compounds_unlocked.has(learned_recipe.compound_output):
				Loader.player_save.compounds_unlocked.append(learned_recipe.compound_output)
				Loader.save_player_save()
				cook_label.text = str("You Learned: ", learned_recipe.recipe_name, "!")
			else:
				cook_label.text = str("You already knew: ", learned_recipe.recipe_name, "!")
		if learned_recipe.metal_output:
			if not Loader.player_save.metals_unlocked.has(learned_recipe.metal_output):
				Loader.player_save.metals_unlocked.append(learned_recipe.metal_output)
				Loader.save_player_save()
				cook_label.text = str("You Learned: ", learned_recipe.recipe_name, "!")
			else:
				cook_label.text = str("You already knew: ", learned_recipe.recipe_name, "!")
		set_item_lists()
		
		cook_slider.visible = false
	else: 
		cook_label.visible = false
		cook_slider.visible = false

func match_metal_to_selected():
	metals_selected.clear()
	for index in metal_list.get_selected_items():
		var metal_in_list = metal_list.get_item_text(index)
		for metal in Loader.metals:
			if metal.metal_name == metal_in_list:
				metals_selected.append(metal)
				break 

func match_compound_to_selected():
	compounds_selected.clear()
	for index in compound_list.get_selected_items():
		var compound_in_list = compound_list.get_item_text(index)
		for compound in Loader.compounds:
			if compound.compound_name == compound_in_list:
				compounds_selected.append(compound)
				break 
		

func check_recipe():
	var matches_recipe = false
	var matched_recipe : Recipe
	for recipe in Loader.recipes:
		matches_recipe = false
		for metal in metals_selected:
			if recipe.metal_input.has(metal):
				matches_recipe = true
		if not matches_recipe:
			continue
		for compound in compounds_selected:
			if recipe.compound_input.has(compound):
				matches_recipe = true
		if not matches_recipe:
			continue
		
		matched_recipe = recipe
	if matched_recipe:
		var index = 0
		for element in element_buttons_clicked:
			if element != matched_recipe.element_input[index]:
				return null
			index+=1
		
	return matched_recipe
	


func _on_button_pressed():
	if cooking:
		finish_cooking()
	else:
		element_buttons_clicked.clear()
		cooking = true
		cook_timer = cook_time_default
		cook_label.text = cook_label_default_text
		cook_slider.max_value = cook_time_default
		cook_slider.min_value = 0
		cook_slider.value = cook_timer
	
func _on_button_pressed_fire():
	element_buttons_clicked.append(Alchemy_Enums.Elements.FIRE)

func _on_button_pressed_earth():
	element_buttons_clicked.append(Alchemy_Enums.Elements.EARTH)

func _on_button_pressed_water():
	element_buttons_clicked.append(Alchemy_Enums.Elements.WATER)

func _on_button_pressed_air():
	element_buttons_clicked.append(Alchemy_Enums.Elements.AIR)
