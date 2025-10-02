extends Node2D # Attaches script to a base 2D Node

# Node references
@onready var ability_timer = $"../Timer"        # Timer for ability cooldown
@onready var attack_sound = $"../Attack_sound"  # SFX for attack sound player

# Variable definitions
var slash_prefab = preload("res://scenes/slash.tscn")  # Prefabricated slash scene for projectile
var can_use_ability = true                             # Whether ability can be used or not

# Triggers when spawning a slash projectile
func spawn_slash(direction : Vector2):
	# Defines slash as slash scene
	var slash = slash_prefab.instantiate()
	attack_sound.play()  # Play attack sound
	slash.position = global_position  # Set slash position
	slash.direction = direction       # Set slash direction
	get_tree().root.add_child(slash)  # Spawn slash

# Triggers when input is given by user
func _input(event):
	# Checks if the user attacks using click and if so, uses ability
	if event.is_action_pressed("attack") and can_use_ability:
		use_ability()

# Triggers if user tries to attack
func use_ability():
	can_use_ability = false  # Resets if ability can be used
	ability_timer.start()    # Starts cooldown timer for ability
	var direction = (get_global_mouse_position() - global_position).normalized()  # Sets direction for slash
	spawn_slash(direction)   # Spawns slash in direction

# Triggers when timer ends
func _on_timer_timeout() -> void:
	# Allows player to use ability
	can_use_ability = true
