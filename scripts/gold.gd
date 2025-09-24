extends Area2D

class_name Gold

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		queue_free()
