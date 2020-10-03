extends AntiBaff

export var size = 1

func _on_Body_body_entered(body):
	if("tag" in body and body.tag == "Shall"):
		for i in body.get_children():
			if "scale" in i:
				i.scale *= size
		DestroyAntiBaff()
	pass # Replace with function body.

