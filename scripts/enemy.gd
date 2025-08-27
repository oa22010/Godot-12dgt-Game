extends CharacterBody2D

const SPEED = 80.0
var player : Node2D
var gold_prefab = preload("res://scenes/gold.tscn")
@onready var animation = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	var direction = (player.global_position - global_position)
	velocity = SPEED * direction.normalized()
	var dir = direction.normalized()
	if dir.x < 0:
		animation.play("run_left")
	elif dir.x > 0:
		animation.play("run_right")
	else:
		animation.play("idle_front")
	move_and_slide()

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is Slash:
		# Spawn gold
		var gold = gold_prefab.instantiate()
		gold.position = global_position
		get_tree().root.call_deferred("add_child", gold)
		queue_free()
		area.queue_free()
