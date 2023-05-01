extends Node2D
class_name Follow
@export
var Attached:Node2D

var _originalOffset:Vector2

func _ready() -> void:
	self._originalOffset = self.position - Attached.position

func _process(delta) -> void:
	self.position = _originalOffset + Attached.position

