extends Shell

func _init():
	type = G.TYPE_SHELL.Stone

func _on_ShellStone_body_entered(body):
	PlayAudioShell(
		"res://Audio/Shell/Rock/BouncShellRock.wav")
	OnRicochet()
	pass # Replace with function body.

func DestroyShell():
	PlayAudioShell(
		"res://Audio/Shell/Rock/DestroyShellRock.wav")
	.DestroyShell()