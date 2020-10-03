extends Baff

export var angle = 60

func _on_Body_body_entered(body):
	if("tag" in body and body.tag == "Shall"):
		var copyShell1 = body.duplicate()
		var copyShell2 = body.duplicate()
		
		var directionVelocityCopy1 = Vector2.ZERO
		var directionVelocityCopy2 = Vector2.ZERO
		var bodyDirectionNormal = body.get_linear_velocity().normalized()
		
		var sinAnglePluse = sin(deg2rad(angle))
		var cosAnglePluse = cos(deg2rad(angle))
		
		var sinAngleMinuse = sin(deg2rad(360 - angle))
		var cosAngleMinuse = cos(deg2rad(360 - angle))
		var v = bodyDirectionNormal
		
		directionVelocityCopy1.x = v.x * cosAnglePluse - v.y * sinAnglePluse
		directionVelocityCopy1.y = v.x * sinAnglePluse + v.y * cosAnglePluse
		
		directionVelocityCopy2.x = v.x * cosAngleMinuse - v.y * sinAngleMinuse
		directionVelocityCopy2.y = v.x * sinAngleMinuse + v.y * cosAngleMinuse		

		copyShell1.directionVelocity = directionVelocityCopy1
		copyShell2.directionVelocity = directionVelocityCopy2
		
		copyShell1.position = body.position
		copyShell2.position = body.position

		copyShell1.fantomActivate = body.fantomActivate
		copyShell2.fantomActivate = body.fantomActivate
		copyShell1.numberMaxRicochets = body.numberMaxRicochets
		copyShell2.numberMaxRicochets = body.numberMaxRicochets


		body.get_parent().add_child(copyShell1)
		body.get_parent().add_child(copyShell2)
		
		DestroyBaff()
	pass # Replace with function body.
