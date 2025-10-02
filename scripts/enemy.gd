extends CharacterBody2D # Attaches script to Character Body 2D

# Constant speed defined
const SPEED = 50.0

# Variables defined
var player : Node2D                                 # Defines player to follow as a 2D Node
var gold_prefab = preload("res://scenes/gold.tscn") # Preloads gold from files

# Node refernces
@onready var animation = $AnimatedSprite2D # Animated enemy sprite
@onready var death_sound = $Death_sound    # Death SFX

# Custom death signal
signal died

# Runs at a fixed, reliable rate for physics-related code
func _physics_process(_delta: float) -> void:
	# Defines direction of enemy movement
	var direction = (player.global_position - global_position)
	# Moves enemy in direction with constant speed
	velocity = SPEED * direction.normalized()
	# Checks if direction is not approx zero
	if not direction.is_zero_approx():
		# Normalizes direction in a variable
		var dir = direction.normalized()
		# Checks if normalized direction on x axis is less than zero
		if dir.x < 0:
			animation.play("run_left") # Plays running left animation
		# Checks if normalized direction on x axis is more than zero
		elif dir.x > 0:
			animation.play("run_right") # Plays running right animation
		else:
			animation.play("idle_front") # Plays front idle
		# Moves enemy while handling collisions and sliding along surfaces
		move_and_slide()

# Triggers when enemy's hitbox is entered by another entity
func _on_hitbox_area_entered(area: Area2D) -> void:
	# Checks if entity Slash is in enemy hitbox
	if area is Slash:
		death_sound.play() # Plays death sounds
		var gold = gold_prefab.instantiate()             # Define gold as gold scene
		gold.position = global_position                  # Set gold position
		get_tree().root.call_deferred("add_child", gold) # Spawn gold
		queue_free()         # Deletes enemy
		emit_signal("died")  # Emits death signal
