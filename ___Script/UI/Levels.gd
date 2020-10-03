extends Control

export(NodePath) var nodeMainMenu

func _ready():
	connect("visibility_changed", $BoxButtonLevels, "openLevels")


func _on_Back_button_up():
	hide()
	get_node(nodeMainMenu).show()	
	pass # Replace with function body.

func PlayAudioClickOnButton():
	S.emit_signal("clickOnButton")
	pass

