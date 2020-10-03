extends Node

var playMussic = true
var playAudio = true

var audioBus = load("res://Audio/default_bus_layout.tres")

func _ready():
	AudioServer.set_bus_layout(audioBus)
	
func SwitchPlayMussic(isPlay:bool):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Mussic"), !isPlay)
	playMussic = isPlay
	
func SwitchPlayAudio(isPlay:bool):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Audio"), !isPlay)
	playAudio = isPlay