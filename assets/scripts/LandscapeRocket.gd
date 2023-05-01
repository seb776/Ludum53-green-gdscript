extends Area2D
class_name LandscapeRocket
@export
var InfoLabel:Control

@export
var costLabel:Label

@export
var GoingSpaceCost:int = 10

var _gameManager: GameManager

func _ready() -> void:
	_gameManager = get_node("/root/GameManager")
	self.InfoLabel.visible = false
	self.costLabel.text = "Cost:   " + str(GoingSpaceCost)
	if _gameManager.MissionInProgress() && _gameManager.MissionPlanetTarget() != _gameManager.PlanetPosition && GoingSpaceCost > _gameManager.cash:
		_gameManager.ClearMission()

func CanGoInSpace() -> bool:
	return self.GoingSpaceCost <= _gameManager.cash

func _process(delta) -> void:
	if Input.is_action_just_released("mission_one") && self.InfoLabel.visible && CanGoInSpace():
		self.InfoLabel.visible = false
		_gameManager.Pay(GoingSpaceCost)
		_gameManager.GoInSpace()

func setLabelVisible(visible_, collided) -> void:
	var c:CharacterBody2D = collided as CharacterBody2D
	if c != null:
		self.InfoLabel.visible = visible_

func OnBodyEntered(body) -> void:
	self.setLabelVisible(true, body)

func OnBodyExited(body) -> void:
	self.setLabelVisible(false, body)

