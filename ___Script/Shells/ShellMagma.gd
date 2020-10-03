extends Shell

func _init():
	type = G.TYPE_SHELL.Magma

func _on_ShellMagma_body_entered(body):
	PlayAudioShell(
		"res://Audio/Shell/Magma/BouncShellMagma.wav")
	OnRicochet()
	pass # Replace with function body.

func DestroyShell():
	PlayAudioShell(
		"res://Audio/Shell/Magma/DestroyShellMagma.wav")
	.DestroyShell()