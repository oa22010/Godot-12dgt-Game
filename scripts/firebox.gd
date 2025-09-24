extends Node2D

@onready var ability_timer = $"../Timer"
var slash_prefab = preload("res://scenes/slash.tscn")
var can_use_ability = true

func spawn_slash(direction : Vector2):
	var slash = slash_prefab.instantiate()
	slash.position = global_position
	slash.direction = direction
	get_tree().root.add_child(slash)

func _input(event):
	if event.is_action_pressed("attack") and can_use_ability:
		use_ability()

func use_ability():
	can_use_ability = false
	ability_timer.start()
	var direction = (get_global_mouse_position() - global_position).normalized()
	spawn_slash(direction)

func _on_timer_timeout() -> void:
	can_use_ability = true
