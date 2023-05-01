extends Node2D
class_name Indicator
@export
var planet:Node2D

@export
var rocket:Node2D

var direction:Vector2

func _process(delta) -> void:
	direction = (planet.global_position - rocket.global_position).normalized()
	self.global_position = rocket.global_position + direction * 100
	self.global_rotation = (atan2(direction.y, direction.x) as float) + 0.5 * (PI as float)

