extends Control
class_name mission_failled_screen
var _isOnRetry:bool = true

var _isOnQuit:bool = false

var _gameManager:GameManager

var _menuScene:String = "res://scenes/game/menu.tscn"

@export
var LabelRetry:Label

@export
var LabelQuit:Label

func _ready() -> void:
	_gameManager = get_node("/root/GameManager")

func _process(delta) -> void:
	if Input.is_action_just_released("forward") || Input.is_action_just_released("backward"):
		_isOnRetry = !_isOnRetry
		print(_isOnRetry)
		if _isOnRetry:
			LabelRetry.text = "X"
			LabelQuit.text = ""
		else:
			LabelRetry.text = ""
			LabelQuit.text = "X"
	if Input.is_action_just_released("enter"):
		if _isOnRetry:
			_gameManager.IsDeath = false
			_gameManager.LandingOn(_gameManager.PlanetPosition)
		else:
			_gameManager.LoadScene(_menuScene)

