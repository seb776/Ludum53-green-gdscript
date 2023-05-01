extends Area2D
class_name Actor
@export
var _name:String

@export
var deliveryLabel:Label

@export
var labelName:Label

var _gameManager: GameManager

func _ready() -> void:
	_gameManager = get_node("/root/GameManager")
	deliveryLabel.visible = false
	labelName.text = _name

func setLabelVisible(visible, collided) -> void:
	var c:CharacterBody2D = collided as CharacterBody2D
	if c != null:
		self.deliveryLabel.visible = visible

func MissionIsForMe() -> bool:
	return _gameManager.MissionInProgress() && _gameManager.MissionPlanetTarget() == _gameManager.PlanetPosition

func _process(delta) -> void:
	if Input.is_action_just_released("mission_one") && self.deliveryLabel.visible && self.MissionIsForMe():
		_gameManager.MissionSucces()
		self.deliveryLabel.visible = false

func OnBodyEntered(body) -> void:
	if self.MissionIsForMe():
		self.deliveryLabel.text = "E - Give package"
	else:
		self.deliveryLabel.text = "Nothing  to  deliver"
	self.setLabelVisible(true, body)

func OnBodyExited(body) -> void:
	self.setLabelVisible(false, body)

