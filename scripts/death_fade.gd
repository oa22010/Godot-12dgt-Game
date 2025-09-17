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
