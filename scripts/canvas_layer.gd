extends CanvasLayer

@onready var start_screen = $"."

func _ready():
	start_screen.visible = true
	Engine.time_scale = 0.0

func _on_button_pressed() -> void:
	start_screen.visible = false
	Engine.time_scale = 1.0
