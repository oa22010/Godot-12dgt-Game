extends CharacterBody2D

const SPEED = 300.0
var score = 0
@onready var sword = $Sword

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = SPEED * direction
	move_and_slide()

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is Gold:
		score += 1
		sword.num_slashs = score + 1
		sword.num_slashs = clamp(sword.num_slashs, 1, 12)
		area.queue_free()
