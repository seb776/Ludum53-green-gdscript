extends Area2D
class_name Asteroid
@export
var _size:AsteroidSize = AsteroidSize.Large

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
	rotation = (rand_range(0, 2d * MathF.PI) as float)
	match _size:
		AsteroidSize.Large:
			speed = rand_range(50, 100)
			_sprite.texture = preload("res://assets/sprites/space/meteors/meteorBrown_big1.png") as Texture2D
			break
		AsteroidSize.Medium:
			speed = rand_range(100, 150)
			_sprite.texture = preload("res://assets/sprites/space/meteors/meteorBrown_med1.png") as Texture2D
			break
		AsteroidSize.Small:
			speed = rand_range(150, 200)
			_sprite.texture = preload("res://assets/sprites/space/meteors/meteorBrown_small1.png") as Texture2D
			break

func _on_body_entered(node) -> void:
	var instance = _missionFailledPackage.instantiate() as Control
	_gameManager.IsDeath = true
	_canvasLayer.add_child(instance)

func _physics_process(delta) -> void:
	global_position += movementVector.rotated(rotation) * speed * (delta as float)
	var cameraCenter:Vector2 = _camera.global_position
	var distance:float = cameraCenter.DistanceTo(position)
	if distance > 2000:
		print("Fin de vie de l'asteroide... destruction de l'objet!")
		queue_free()

