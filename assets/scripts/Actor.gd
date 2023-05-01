extends Area2D
class_name Actor
@export
var _name:String

@export
var deliveryLabel:Label

@export
var labelName:Label

var _gameManager: GameManager

@export
var LookLeft:bool

@export
var Interface:Node2D

var _baseScale:Vector2

var _interfaceBaseScale:Vector2

func _ready() -> void:
	_gameManager = get_node("/root/GameManager")
	deliveryLabel.visible = false
	labelName.text = _name
	_interfaceBaseScale = Interface.scale
	_baseScale = self.scale

func setLabelVisible(visible_, collided) -> void:
	var c:CharacterBody2D = collided as CharacterBody2D
	if c != null:
		self.deliveryLabel.visible = visible_

func MissionIsForMe() -> bool:
	return _gameManager.MissionInProgress() && _gameManager.MissionPlanetTarget() == _gameManager.PlanetPosition

func _process(delta) -> void:
	if Input.is_action_just_released("mission_one") && self.deliveryLabel.visible && self.MissionIsForMe():
		_gameManager.MissionSucces()
		self.deliveryLabel.visible = false
	if LookLeft:
		Interface.scale = Vector2(_interfaceBaseScale.x * -1, _interfaceBaseScale.y)
		self.scale = Vector2(_baseScale.x * -1, _baseScale.y)
	else:
		Interface.scale = _interfaceBaseScale
		self.scale = _baseScale

func OnBodyEntered(body) -> void:
	if self.MissionIsForMe():
		self.deliveryLabel.text = "E  -  Give   package"
	else:
		self.deliveryLabel.text = "Nothing   to   deliver"
	self.setLabelVisible(true, body)

func OnBodyExited(body) -> void:
	self.setLabelVisible(false, body)

