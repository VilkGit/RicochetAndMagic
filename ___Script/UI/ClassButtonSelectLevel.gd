extends TextureButton

class_name ButtonSelectLevel

signal focusButton(obj)

func _ready():
	connect("pressed", self, "FocusButton")
	
func FocusButton():
	emit_signal("focusButton", self)