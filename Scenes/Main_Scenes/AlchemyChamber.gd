extends Node2D
@onready
var metal_list = $GameUI/Control/GridContainer/Metals/metal_list
@onready
var compound_list = $GameUI/Control/GridContainer/Compounds/compound_list
func _ready():
	metal_list.clear()
	for metal in Loader.metals:
		metal_list.add_item(metal.metal_name, null, true)
	compound_list.clear()
	for compound in Loader.compounds:
		compound_list.add_item(compound.compound_name, null, true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	print("Alchemized") # Replace with function body.
	var metals_selected = metal_list.get_selected_items()
	var compounds_selected = compound_list.get_selected_items()
	



func _on_test_button_pressed():
	print("Test Button")
