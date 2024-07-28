extends Resource

class_name Recipe

@export var recipe_name : String
@export var metal_output : Metal
@export var metal_input : Array[Metal]
@export var compound_input : Array[Compound]
@export var element_input: Array[AlchemyEnums.Elements]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
