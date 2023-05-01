extends Sprite2D
class_name AnimateDrone
var _origiY:float

var _time:float

func _ready() -> void:
	_origiY = self.position.y
	_time = 0.0

func _process(delta) -> void:
	self.position = Vector2(self.position.x, ((_origiY + sin(_time * 2.0)) as float))
	_time += delta

