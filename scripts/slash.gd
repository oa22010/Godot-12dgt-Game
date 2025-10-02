extends Area2D # Attaches script to Area 2D node

# Sets referable name for slash
class_name Slash

# Variable definitions
var speed = 600  # Movement speed for slash
var direction : Vector2 = Vector2.RIGHT  # Initial dierection, not actually used

# Runs constantly at a fixed rate
func _process(delta: float) -> void:
	# Moves slash using direction, speed and at a rate correlated to frame speed for consitency
	translate(direction * speed * delta)
