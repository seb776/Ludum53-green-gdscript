extends Node2D
class_name LastMission
@export
var label:Label

var _gameManager: GameManager

func _ready() -> void:
	_gameManager = get_node("/root/GameManager")
	label.visible = false

func _process(delta) -> void:
	if Input.is_action_just_released("mission_one") && label.visible:
		_gameManager.MissionSucces()

func setLabelVisible(visible_, body) -> void:
	var p:CharacterBody2D = body as CharacterBody2D
	if p != null:
		label.visible = visible_

func OnBodyEntered(body) -> void:
	self.setLabelVisible(true, body)

func OnBodyExited(body) -> void:
	self.setLabelVisible(false, body)

