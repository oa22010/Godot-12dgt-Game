extends Node2D

var slash_prefab = preload("res://scenes/slash.tscn")
var num_slashs = 1

func _on_timer_timeout() -> void:
	shoot()

func spawn_slash(direction : Vector2):
	# Spawn slash
	var slash = slash_prefab.instantiate()
	slash.position = global_position
	slash.direction = direction
	get_tree().root.add_child(slash)

func shoot():
	var direction = Vector2.RIGHT
	for bullet in range(num_slashs):
		spawn_slash(direction)
