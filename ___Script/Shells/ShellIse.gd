extends Shell

func _init():
	type = G.TYPE_SHELL.Ise

func _on_ShellIse_body_entered(body):
	PlayAudioShell(
		"res://Audio/Shell/Ice/BouncShellIce.wav")
	OnRicochet()
	pass # Replace with function body.

func DestroyShell():
	PlayAudioShell(
		"res://Audio/Shell/Ice/DestroyShellIse.wav")
	.DestroyShell()