extends TextureProgressBar
class_name ProgressBar
@export
var _delivryTimer:Timer

func _process(delta) -> void:
	Value = _delivryTimer.TimeLeft

