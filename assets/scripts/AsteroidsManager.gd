extends Node
var _offSets:Array

@export
var _asteroidPrefabs:Array

@export
var spawnTimer:Timer

@export
var playerSpaceships:CharacterBody2D

func _ready() -> void:
	_offSets = [Vector2(1, 0), Vector2(0, 1), Vector2(-1, 0), Vector2(0, -1)]

func _on_asteroids_timer_timeout() -> void:
	var instance = _asteroidPrefabs[(randf_range(0, _asteroidPrefabs.size() - 1) as int)].instantiate() as Node2D
	add_child(instance)
	var spawnPosition:Vector2 = playerSpaceships.global_position + _offSets[(randf_range(0, _offSets.size() - 1) as int)] * 645
	instance.global_position = spawnPosition
	spawnTimer.start(spawnTimer.wait_time)

