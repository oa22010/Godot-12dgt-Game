extends Area2D # Attaches script to Area 2D node

# Sets referable name for gold
class_name Gold

# Runs at a fixed, reliable rate for physics-related code
func _physics_process(_delta: float) -> void:
	# If game restarts, delete all gold
	if Input.is_action_just_pressed("restart"):
		queue_free()
