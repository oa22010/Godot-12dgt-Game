extends CanvasLayer

@onready var start_screen = $"."
@onready var start_sound = $"../Sound/Start_sound"
@onready var background_music = $"../Sound/Background_music"
@onready var timer = get_tree().get_root().get_node("DeathFade/Timer")
@onready var label = get_tree().get_root().get_node("DeathFade/Label")
@onready var anim_sprite = get_tree().get_root().get_node("DeathFade/AnimatedSprite2D")
@onready var restart = get_tree().get_root().get_node("DeathFade/Restart")

func _ready():
	start_screen.visible = true
	Engine.time_scale = 0.0

func _on_button_pressed() -> void:
	start_screen.visible = false
	Engine.time_scale = 1.0
	start_sound.stop()
	background_music.play()
	timer.stop()
	label.visible = false
	anim_sprite.visible = false
	restart.visible = false
