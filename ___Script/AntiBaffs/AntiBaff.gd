extends Node2D

class_name AntiBaff

var audio:AudioStreamPlayer

func DestroyAntiBaff():
	PlayAudioDestroy()
	queue_free()
	
func PlayAudioDestroy():
	audio = AudioStreamPlayer.new()
	$"..".add_child(audio)
	audio.set_stream(load("res://Audio/Baffs/ActivateBaff.wav"))
	audio.set_bus("Audio")
	audio.set_volume_db(-7)
	audio.play()
	audio.connect("finished", audio, "queue_free")
	