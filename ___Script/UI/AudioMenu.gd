extends Node2D


func _ready():
	S.connect("clickOnButton", self, "PlayAudioButtonClick")
		
func PlayAudioButtonClick():
	$AudioButtonClick.play()

func _on_MussicMenu_finished():
	$MussicMenu.play()
	pass # Replace with function body.
