extends CharacterBody2D

const SPEED = 300.0

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = SPEED * direction
	move_and_slide()
