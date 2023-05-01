extends Node2D
class_name DoTheParallax
@export
var Speed:float = 0.1

func _process(delta) -> void:
	var diffX:float = get_viewport().get_camera_2d().global_position.x * Speed
	self.position = Vector2(diffX, self.position.y)

