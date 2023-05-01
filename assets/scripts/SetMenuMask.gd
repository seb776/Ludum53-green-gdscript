extends TextureRect
class_name SetMenuMask
@export
var MaskTexture:Texture

func _ready() -> void:
	var shaderMat = self.material as ShaderMaterial
	shaderMat.set_shader_parameter("maskTexture", MaskTexture)

func _process(delta) -> void:
	pass

