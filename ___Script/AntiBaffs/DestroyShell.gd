extends AntiBaff

export var reusable = false

func _on_Body_body_entered(body):
	if("tag" in body and body.tag == "Shall"):
		body.DestroyShell()
		if !reusable:
			DestroyAntiBaff()
	pass # Replace with function body.
