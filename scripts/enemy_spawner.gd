extends Node2D # Attaches script to a base 2D Node

# Node refernces
@onready var my_timer = $Timer                       # TImer for enemy/wave spawning
@onready var pre_spawn_timer = $Pre_spawn            # Timer for triggering code before enemies spawn
@onready var label = $"../Player/Wave_num"           # Connects to wave number label in player node
@onready var enemy_label = $"../Player/Enemy_count"  # Connects to enemy count label in player node
@onready var animation = $AnimatedSprite2D           # Animated sprite for spawner
@onready var spawn_sound = $Spawn_sound              # SFX for spawning enemies
@export var enemy_prefab : PackedScene               # Prefabricated enemy scene for spawning
@export var target : Node2D                          # Identifies target as a specific player 2D node

# Variable definitions
var wave_num = 0          # wave number
var countdown = 0         # enemies spawned in current wave
var enemy_count = 0       # enemies alive
var wave_size = 0         # total enemies this wave

# Called when the scene is ready
func _ready():
	label.text = "Wave: 0"                 # Sets default wave number text
	enemy_label.text = "Enemy count: 0"    # Sets default enemy count text
	start_new_wave()  # Starts first wave

# Triggers when new wave is started
func start_new_wave():
	wave_num += 1                          # Adds one to wave size
	label.text = "Wave: " + str(wave_num)  # Updates wave number text
	wave_size = 5 + (wave_num * 2)         # Sets wave size
	countdown = 0                          # Resets number of enemies spawned in current wave
	animation.play("enemy_spawning")       # Plays spawning animation
	pre_spawn_timer.start()                # Starts timer before enemies are spawned

# Triggered when enemy dies
func _on_enemy_died():
	# Subtracts one from enemy count
	enemy_count -= 1
	# If all enemies are dead and the wave is finished, start the next wave
	if enemy_count <= 0 and countdown >= wave_size:
		start_new_wave()

# Runs constantly at a fixed rate
func _process(_delta: float) -> void:
	# Updates enemy count text
	enemy_label.text = "Enemy count: " + str(enemy_count)

# Triggers when Timer ends
func _on_timer_timeout() -> void:
	var enemy = enemy_prefab.instantiate()  # Defines enemy as enemy scene
	enemy.player = target                   # Sets player as enemy target to follow
	enemy.died.connect(_on_enemy_died)      # Connects death signal
	add_child(enemy)                        # Spawns enemy
	# If spawn sound is not playing then play spawn sound
	if spawn_sound.is_playing():
		pass
	else:
		spawn_sound.play()
	enemy.z_index = -1  # Sets what visibility layer enemy is on
	countdown += 1      # Adds 1 to enemy spawned in wave and enemy count
	enemy_count += 1
	# Stop spawning once wave_size is reached
	if countdown >= wave_size:
		my_timer.stop()
		pre_spawn_timer.stop()
		animation.stop() # end pre-spawn animation once all are spawned

# Triggers when pre-spawn timer ends
func _on_pre_spawn_timeout() -> void:
	# Set timer to 0.1 sec and start
	my_timer.set_wait_time(0.1)
	my_timer.start()
