extends CanvasLayer # Attached script to Canvas Layer node

# Node references
@onready var start_screen = $"."                              # Connects to canvas layer node
@onready var start_sound = $"../Sound/Start_sound"            # Starting music player
@onready var background_music = $"../Sound/Background_music"  # Background music player
@onready var timer = get_tree().get_root().get_node("DeathFade/Timer")                   # Death fade timer
@onready var label = get_tree().get_root().get_node("DeathFade/Label")                   # Death fade text
@onready var anim_sprite = get_tree().get_root().get_node("DeathFade/AnimatedSprite2D")  # Death fade heart
@onready var restart = get_tree().get_root().get_node("DeathFade/Restart")  # Death fade restart text

# Triggers when scene is ready
func _ready():
	start_screen.visible = true  # Makes start screen visible
	Engine.time_scale = 0.0      # Stops game time

# Triggers when start screen button is pressed
func _on_button_pressed() -> void:
	start_screen.visible = false  # Makes start screen invisible
	Engine.time_scale = 1.0       # Sets game time to normal speed
	start_sound.stop()            # Stops starting music
	background_music.play()       # Starts background music
	timer.stop()                  # Stops timer
	# Makes death fade UI invisible
	label.visible = false   
	anim_sprite.visible = false
	restart.visible = false
