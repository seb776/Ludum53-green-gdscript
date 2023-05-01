extends HBoxContainer
class_name MissionIndicator
@export
var planetLabel:Label

var _gameManager:GameManager

func _ready() -> void:
	_gameManager = get_node("/root/GameManager")

func _process(delta) -> void:
	if _gameManager.MissionInProgress():
		self.visible = true
		planetLabel.text = _gameManager.PlanetNames[_gameManager.MissionPlanetTarget()]
	else:
		self.visible = false

