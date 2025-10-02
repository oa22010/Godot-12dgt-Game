extends Node2D # Attaches script to base 2D nodes

# Runs constantly at a fixed rate
func _process(_delta):
	# Sets sword rotation to face mouse
	global_rotation = global_position.direction_to(get_global_mouse_position()).angle()
