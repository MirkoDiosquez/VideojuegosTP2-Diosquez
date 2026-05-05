extends Node2D

const BOSS_SCENE = preload("res://Escenas/boss.tscn")
const HEALTH_PICKUP_SCENE = preload("res://Escenas/health_pickup.tscn")
const MAX_PICKUPS = 3
const PICKUP_SPAWN_TIME = 15.0

func _ready() -> void:
	_spawn_boss()
	_spawn_pickup_gradual()

func _spawn_boss() -> void:
	var boss = BOSS_SCENE.instantiate()
	boss.position = Vector2(700, 350)
	add_child(boss)

func _spawn_pickup_gradual() -> void:
	for i in MAX_PICKUPS:
		await get_tree().create_timer(i * 3.0).timeout
		if get_tree() == null:
			return
		_spawn_pickup()
	await get_tree().create_timer(PICKUP_SPAWN_TIME).timeout
	if get_tree() == null:
		return
	_spawn_pickup_gradual()

func _spawn_pickup() -> void:
	var pickup = HEALTH_PICKUP_SCENE.instantiate()
	pickup.position = Vector2(randf_range(100, 900), randf_range(150, 550))
	add_child(pickup)
