extends Baff

export var reusable = false

func _on_Body_body_entered(body):
	if("tag" in body and body.tag == "Shall"):
		body.fantomActivate = true
	if !reusable:
		DestroyBaff()
	pass # Replace with function body.
