extends Node2D
class_name PlanetPrefab
@export
var ColorA:Color

@export
var ColorB:Color

@export
var _sprite:Sprite2D

func _process(delta) -> void:
	var shaderMat = _sprite.material as ShaderMaterial
	shaderMat.set_shader_parameter("colorA", ColorA)
	shaderMat.set_shader_parameter("colorB", ColorB)

