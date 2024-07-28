extends "res://Scripts/Game_Items/pickupable_items.gd"

@export
var metal_name : String

@export
var metal_symbol : String

@export
var metal_type : Alchemy_Enums.Metal_Type

@export
var value : float

func _ready():
	initialize()


#func _on_area_2d_input_event(viewport, event, shape_idx):
	#pass # Replace with function body.
