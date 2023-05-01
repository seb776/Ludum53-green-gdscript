extends Node2D
class_name HoveringScript
@export
var Speed:float = 1.0

@export
var Amplitude:float = 1.0

@export
var Seed:float = 0.0

var _origY:float

var _time:float

func _ready() -> void:
	_origY = self.position.y

func _process(delta) -> void:
	self.position = Vector2(self.position.x, (((self.position.y as float) + Amplitude * sin((_time + Seed * 11.33) * Speed)) as float))
	_time += delta

