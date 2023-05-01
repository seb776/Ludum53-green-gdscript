extends Node2D
class_name TreeVariation
@export
var TexRect:TextureRect

@export
var BranchAngleFactor:float = 0.6

@export
var BarkColor:Color = Color(0, 0, 0, 1)

@export
var LeafColor:Color = Color(1, 0, 0, 1)

func _ready() -> void:
	var shaderMat = TexRect.material as ShaderMaterial
	shaderMat.set_shader_parameter("_barkColor", BarkColor)
	shaderMat.set_shader_parameter("_leafColor", LeafColor)
	shaderMat.set_shader_parameter("_branchAngleFactor", BranchAngleFactor)
	shaderMat.set_shader_parameter("_seed", self.position.x)

func _process(delta) -> void:
	pass

