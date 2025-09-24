extends Node2D

@onready var my_timer = $Timer          # main spawn timer
@onready var pre_spawn_timer = $Pre_spawn  # a second Timer node, set to 1s
@onready var label = $"../Player/Wave_num"
@onready var enemy_label = $"../Player/Enemy_count"
@onready var animation = $AnimatedSprite2D
@export var enemy_prefab : PackedScene
@export var target : Node2D
var wave_num = 0
var countdown = 0         # enemies spawned in current wave
var enemy_count = 0       # enemies alive
var wave_size = 0         # total enemies this wave

func _ready():
	label.text = "Wave: 0"
	enemy_label.text = "Enemy count: 0"
	start_new_wave()

func start_new_wave():
	wave_num += 1
	label.text = "Wave: " + str(wave_num)
	wave_size = 5 + (wave_num * 2)
	countdown = 0
	animation.play("enemy_spawning")
	pre_spawn_timer.start()

func _on_enemy_died():
	enemy_count -= 1
	# If all enemies are dead and the wave is finished, start the next wave
	if enemy_count <= 0 and countdown >= wave_size:
		start_new_wave()

func _process(_delta: float) -> void:
	enemy_label.text = "Enemy count: " + str(enemy_count)

func _on_timer_timeout() -> void:
# Spawn one enemy
	var enemy = enemy_prefab.instantiate()
	enemy.player = target
	enemy.died.connect(_on_enemy_died)
	add_child(enemy)
	enemy.z_index = -1

	countdown += 1
	enemy_count += 1

	# Stop spawning once wave_size is reached
	if countdown >= wave_size:
		my_timer.stop()
		pre_spawn_timer.stop()
		animation.stop() # end pre-spawn animation once all are spawned

func _on_pre_spawn_timeout() -> void:
	# Start spawning enemies every 0.1s
	my_timer.set_wait_time(0.1)
	my_timer.start()
