extends CanvasLayer  # Attaches script to Canvas Layer node

# Node references
@onready var color_rect = $ColorRect            # Colored rectangle
@onready var animation = $AnimationPlayer       # Animation player for fade to black
@onready var anim_sprite = $AnimatedSprite2D    # Animated heart sprite
@onready var death_sound = $Death_sound         # Music for death screen
@onready var label = $Label                     # Label reading "You died"
@onready var restart = $Restart                 # Text detailing how to restart the game
@onready var timer = $Timer                     # Timer controlling when sprite, label and restart text appears

# Called when the scene is ready
func _ready() -> void:
	# Hide all UI elements and stop timer
	timer.stop()
	color_rect.visible = false
	anim_sprite.visible = false
	label.visible = false
	restart.visible = false

# Trigger death transition
func transition_black():
	# Fade to black, plays heart break animation and plays music
	death_sound.play()
	color_rect.visible = true
	animation.play("fade_to_black")
	anim_sprite.play("heart_break")
	timer.start()  # Starts timer

# Runs at a fixed, reliable rate for physics-related code
func _physics_process(_delta: float) -> void:
	# Check if the player presses the restart key
	if Input.is_action_just_pressed("restart"):
		# Hide death UI and reset animations/music
		color_rect.visible = false
		anim_sprite.visible = false
		label.visible = false
		restart.visible = false
		animation.play("fade_to_black")
		animation.stop()  # Resets anmation
		Engine.time_scale = 1.0  # Resume normal game speed
		death_sound.stop()       # Stop death sound

# Called when the timer finishes
func _on_timer_timeout() -> void:
	# Show the restart options and death visuals
	anim_sprite.visible = true
	label.visible = true
	restart.visible = true
