extends CharacterBody2D # Attaches script to Character Body 2D node

# Node references
@onready var timer = $Timer                        # Timer to pause game
@onready var sword = $Sword                        # Connects to sword node/scene
@onready var label = $Score                        # Label that displays score
@onready var animation_sprite = $AnimatedSprite2D  # Animated player sprite
@onready var player = $"."                         # References player parent node/scene
@onready var death_fade = get_tree().get_root().get_node("DeathFade")  # Connects to death fade for death
@onready var background_music = $"../Sound/Background_music"           # Background player music

# Variable and constant definitions
const SPEED = 250.0                          # Player movement speed
var last_direction : Vector2 = Vector2.DOWN  # Last direction the player was facing
var score = 0                                # Player score

# Triggers immediatley when scene starts
func _onready():
	# Stops timer
	timer.stop()

# Runs at a fixed, reliable rate for physics-related code
func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")  # Finds direction using input
	velocity = SPEED * direction.normalized()  # Moves player using speed and normalized direction
	# Checks what direction the player is moving and plays correlating animation, while setting last direction
	if direction == Vector2.LEFT:
		animation_sprite.play("run_left")
		last_direction = Vector2.LEFT
	elif direction == Vector2.RIGHT:
		animation_sprite.play("run_right")
		last_direction = Vector2.RIGHT
	elif direction == Vector2.UP:
		animation_sprite.play("run_back")
		last_direction = Vector2.UP
	elif direction == Vector2.DOWN:
		animation_sprite.play("run_front")
		last_direction = Vector2.DOWN
	# If player is still, play idle animation in correlation to last facing direction
	elif direction == Vector2.ZERO:
		if last_direction == Vector2.LEFT:
			animation_sprite.play("idle_left")
		elif last_direction == Vector2.RIGHT:
			animation_sprite.play("idle_right")
		elif last_direction == Vector2.UP:
			animation_sprite.play("idle_back")
		else:
			animation_sprite.play("idle_front")
	# Moves enemy while handling collisions and sliding along surfaces
	move_and_slide()

# Triggers when hitbox is entered
func _on_hitbox_area_entered(area: Area2D) -> void:
	# Checks if player collides with Gold or Enemy
	if area is Gold:
		score += 1         # Adds 1 to score
		area.queue_free()  # Deletes gold
		label.text = "Score: " + str(score)  # Updates score
	elif area is Enemy:
		animation_sprite.play("death")  # Plays player death animation
		background_music.stop()         # Stops background music
		Engine.time_scale = 0.1         # Slows down game time scale
		timer.start()                   # Starts timer
		death_fade.transition_black()   # Transitions to death screen

# Triggers when timer ends
func _on_timer_timeout() -> void:
	# Stops game time
	Engine.time_scale = 0.0
