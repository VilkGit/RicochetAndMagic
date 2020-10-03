extends Control

export(NodePath) var nodeMenuLevels
export(NodePath) var nodeMenuRating
export(NodePath) var nodeSignInUp

var selectLevel = SelectLevel.new()

func _ready():
	get_tree().paused = false
	OS.set_window_size(Vector2(960, 540))
	if G.firstStart:
		hide()
		get_node(nodeSignInUp).show()
		G.firstStart = false
		

func _on_Play_button_up():
	get_tree().change_scene(selectLevel.levels[str(G.numberLevel)])
	pass # Replace with function body.


func _on_Levels_button_up():
	self.hide()
	get_node(nodeMenuLevels).show()
	pass # Replace with function body.


func _on_Rating_button_up():
	self.hide()
	get_node(nodeMenuRating).show()
	pass # Replace with function body.

func PlayAudioClickOnButton():
	S.emit_signal("clickOnButton")
	pass