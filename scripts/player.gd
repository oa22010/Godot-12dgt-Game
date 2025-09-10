extends CharacterBody2D

const SPEED = 250.0
var score = 0
var health = 3
@onready var sword = $Sword
@onready var label = $"../Label"
@onready var animation = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = SPEED * direction.normalized()
	if direction == Vector2.LEFT:
		animation.play("run_left")
	elif direction == Vector2.RIGHT:
		animation.play("run_right")
	elif direction == Vector2.UP:
		animation.play("run_back")
	elif direction == Vector2.DOWN:
		animation.play("run_front")
	elif direction == Vector2.ZERO:
		animation.play("idle_front")
	move_and_slide()

func _on_hitbox_area_entered(area: Area2D) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	if area is Gold:
		score += 1
		area.queue_free()
		sword.num_slashs = score
		sword.num_slashs = clamp(sword.num_slashs, 1, 48)
		label.text = "Score: " + str(score)
	elif area is Enemy and health > 0:
		if direction == Vector2.LEFT:
			animation.play("hurt_left")
		elif direction == Vector2.RIGHT:
			animation.play("hurt_right")
		elif direction == Vector2.UP:
			animation.play("hurt_back")
		elif direction == Vector2.DOWN:
			animation.play("hurt_front")
		health -= 1
	elif area is Enemy and health <= 0:
		animation.play("death")
