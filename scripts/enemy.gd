extends CharacterBody2D

const SPEED = 80.0
@export var player : Node2D

func _physics_process(_delta: float) -> void:
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * SPEED
	move_and_slide()
