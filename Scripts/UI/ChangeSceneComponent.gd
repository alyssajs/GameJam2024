extends Node2D

@export
var scene_to_go_to : String

#@export
#var is_flipped : bool

#@onready
#var self_node = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	#if is_flipped:
		#self_node.transform
	pass
		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_change_scene_pressed():
	get_tree().change_scene_to_file(scene_to_go_to)
