extends Shell

func _init():
	type = G.TYPE_SHELL.Fire

func _on_ShellFire_body_entered(body):
	OnRicochet()
	pass # Replace with function body.
