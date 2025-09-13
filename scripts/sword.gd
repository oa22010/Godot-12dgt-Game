extends Node2D

var num_slashs: int = 1

func _process(_delta):
	global_rotation = global_position.direction_to(get_global_mouse_position()).angle()
