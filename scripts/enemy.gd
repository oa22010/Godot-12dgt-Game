extends CharacterBody2D

const SPEED = 300.0
@export var player : Node2D

func _physics_process(delta: float) -> void:
	var direction = (player.position - position).normalized()
	velocity = direction * SPEED
	move_and_slide()
