extends CharacterBody2D

const SPEED = 50.0
var player : Node2D
var gold_prefab = preload("res://scenes/gold.tscn")
@onready var animation = $AnimatedSprite2D
@onready var death_sound = $Death_sound
signal died

func _physics_process(_delta: float) -> void:
	var direction = (player.global_position - global_position)
	velocity = SPEED * direction.normalized()
	if not direction.is_zero_approx():
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
		death_sound.play()
		var gold = gold_prefab.instantiate()
		gold.position = global_position
		get_tree().root.call_deferred("add_child", gold)
		queue_free()
		emit_signal("died")
