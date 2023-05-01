extends Node
var _asteroidPrefabs:PackedScene

var _offSets:Array

@export
var spawnTimer:Timer

@export
var playerSpaceships:CharacterBody2D

func _ready() -> void:
	_asteroidPrefabs = preload("res://assets/prefabs/asteroid.tscn") as PackedScene
	_offSets = [Vector2(1, 0), Vector2(0, 1), Vector2(-1, 0), Vector2(0, -1)]

func _on_asteroids_timer_timeout() -> void:
	var instance = _asteroidPrefabs.instantiate() as Node2D
	add_child(instance)
	var spawnPosition:Vector2 = playerSpaceships.global_position + _offSets[(rand_range(0, _offSets.size()() - 1) as int)] * 645
	instance.global_position = spawnPosition
	spawnTimer.Start(spawnTimer.WaitTime)

