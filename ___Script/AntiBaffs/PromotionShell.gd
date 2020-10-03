extends AntiBaff

export var velocityAng = 10000
export var moveLeft = true

func _on_Body_body_entered(body):
	velocityAng = abs(velocityAng)
	if moveLeft: velocityAng = velocityAng * -1
	if("tag" in body and body.tag == "Shall"):
		body.set_angular_velocity(velocityAng)
		body.set_physics_material_override(null)
		DestroyAntiBaff()
	pass # Replace with function body.
