extends MarginContainer
class_name OffsetAdaptor
func _ready() -> void:
	pass

func _process(delta) -> void:
	pass

func SizeChange() -> void:
	self.PivotOffset = Vector2(self.Size.x, self.PivotOffset.y)

