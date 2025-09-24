extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var animation = $AnimationPlayer
@onready var anim_sprite = $ColorRect/AnimatedSprite2D

func _ready() -> void:
	color_rect.visible = false

func transition_black():
	color_rect.visible = true
	animation.play("fade_to_black")
	anim_sprite.play("heart_break")

func transition_normal():
	animation.play("fade_to_black")
	color_rect.visible = false

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		color_rect.visible = false
		animation.play("fade_to_black")
		animation.stop()
		Engine.time_scale = 1.0
