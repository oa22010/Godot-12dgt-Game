extends CharacterBody2D

const SPEED = 300.0

func _physics_process(_delta: float) -> void:
	var move_dir = Vector2(Input.get_axis("left", "right"), 
	Input.get_axis("up", "down"))
	
	if move_dir != Vector2.ZERO:
		velocity = SPEED * move_dir.normalized()
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()
