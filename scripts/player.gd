extends CharacterBody2D

const SPEED = 250.0
var score = 0
@onready var timer = $Timer
@onready var sword = $Sword
@onready var label = $Score
@onready var animation_sprite = $AnimatedSprite2D
@onready var player = $"."
@onready var death_fade = get_tree().get_root().get_node("DeathFade")

func _onready():
	timer.stop()

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = SPEED * direction.normalized()
	if direction == Vector2.LEFT:
		animation_sprite.play("run_left")
	elif direction == Vector2.RIGHT:
		animation_sprite.play("run_right")
	elif direction == Vector2.UP:
		animation_sprite.play("run_back")
	elif direction == Vector2.DOWN:
		animation_sprite.play("run_front")
	elif direction == Vector2.ZERO:
		animation_sprite.play("idle_front")
	move_and_slide()

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is Gold:
		score += 1
		area.queue_free()
		sword.num_slashs = clamp(score, 1, 48)
		label.text = "Score: " + str(score)
	elif area is Enemy:
		animation_sprite.play("death")
		Engine.time_scale = 0.1
		timer.start()
		death_fade.transition_black()

func _on_timer_timeout() -> void:
	Engine.time_scale = 0.0
