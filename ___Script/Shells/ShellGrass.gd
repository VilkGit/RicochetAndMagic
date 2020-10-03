extends Shell

func _init():
	type = G.TYPE_SHELL.Grass

func _on_ShellGrass_body_entered(body):
	PlayAudioShell(
		"res://Audio/Shell/Grass/BouncGrass.wav")
	OnRicochet()
	pass # Replace with function body.

func DestroyShell():
	PlayAudioShell(
		"res://Audio/Shell/Grass/DestroyShellGrass.wav")
	.DestroyShell()