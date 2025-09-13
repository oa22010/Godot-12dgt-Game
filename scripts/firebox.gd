extends Node2D

var slash_prefab = preload("res://scenes/slash.tscn")

func _on_timer_timeout() -> void:
	shoot()

func spawn_slash(direction : Vector2):
	var slash = slash_prefab.instantiate()
	slash.position = global_position
	slash.direction = direction
	get_tree().root.add_child(slash)

func shoot():
	var direction = (get_global_mouse_position() - global_position).normalized()
	spawn_slash(direction)
