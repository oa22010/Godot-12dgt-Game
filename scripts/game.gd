extends Node2D # Attaches script to a base 2D Node

# Runs at a fixed, reliable rate for physics-related code
func _physics_process(_delta: float) -> void:
	# Checks if user restarts the game and resets game if so
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
