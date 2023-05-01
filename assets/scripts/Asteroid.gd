extends Area2D
class_name Asteroid
var _canvasLayer:CanvasLayer

var speed:float


var movementVector:Vector2 = Vector2(0, -1)

var _sprite:Sprite2D

var _camera:Camera2D

var _missionFailledPackage:PackedScene

var _spaceShips:CharacterBody2D

var _gameManager:GameManager

func _ready() -> void:
	_sprite = get_node("Sprite2D")
	_camera = get_viewport().get_camera_2d()
	_missionFailledPackage = preload("res://assets/prefabs/mission_failled_screen.tscn") as PackedScene
	_canvasLayer = get_node("../../HUD")
	_spaceShips = get_node("../../PlayerSpaceships")
	_gameManager = get_node("/root/GameManager")
	rotation = (randf_range(0, 2 * PI) as float)
	speed = randf_range(50, 200)

func _on_body_entered(node) -> void:
	var instance = _missionFailledPackage.instantiate() as Control
	_gameManager.IsDeath = true
	_canvasLayer.add_child(instance)

func _physics_process(delta) -> void:
	global_position += movementVector.rotated(rotation) * speed * (delta as float)
	var cameraCenter:Vector2 = _camera.global_position
	var distance:float = cameraCenter.distance_to(position)
	if distance > 2000:
		queue_free()

