extends Control
class_name GeneralUI
@export
var CashLabel:Label

var _gameManager: GameManager

func _ready() -> void:
	_gameManager = get_node("/root/GameManager")

func _process(delta) -> void:
	CashLabel.text = str(_gameManager.cash) + " / " + str((_gameManager.WinCash + _gameManager.WinCash * 0.20))

