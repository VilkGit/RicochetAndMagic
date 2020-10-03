extends Node2D

func _ready():
	S.connect("clickOnButton", self, "PlayAudioButtonClick")
		
func PlayAudioButtonClick():
	$AudioButtonClickUI.play()

func _on_MussicMenu_finished():
	$MussicLevel.play()
	pass # Replace with function body.
