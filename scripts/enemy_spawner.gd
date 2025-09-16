extends Node2D

@onready var my_timer = $Timer
@onready var label = $"../Player/Wave_num"
@export var enemy_prefab : PackedScene
@export var target : Node2D
var wave_num = 0
var enemy_count = 0

func _ready():
	# Set the initial wait time
	my_timer.set_wait_time(1.0)
	my_timer.start()

func change_timer(new_duration):
	if enemy_count > 10:
		wave_num += 1
		enemy_count = 0
		label.text = "Wave: " + str(wave_num)
		my_timer.set_wait_time(10)
		my_timer.start()
	else:
		my_timer.set_wait_time(new_duration)
		my_timer.start()

func _on_timer_timeout() -> void:
	# Spawn enemy
	var enemy = enemy_prefab.instantiate()
	enemy.player = target
	add_child(enemy)
	change_timer(0.1)
	enemy_count += 1
