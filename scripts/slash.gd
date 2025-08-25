extends Area2D
class_name Slash

var speed = 600
var direction : Vector2 = Vector2.RIGHT

func _process(delta: float) -> void:
	translate(direction * speed * delta)
