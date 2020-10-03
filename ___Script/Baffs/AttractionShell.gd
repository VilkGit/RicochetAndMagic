extends Baff

export(NodePath) var NodeCharacters



func _on_Body_body_entered(body):
	if("tag" in body and body.tag == "Shall"):
		var characters = get_node(NodeCharacters).get_children() 
		var nearestCharacter = characters[0]
		
		for i in range(len(characters)):
			if !characters[i].has_method("GetHP"): continue
			if characters[i].GetHP() <= 0: continue
	
			var positionRegardingShell = abs(
				characters[i].global_position.length() - 
				global_position.length())

			var actualPositonNearestCharacters = abs(
				nearestCharacter.global_position.length() -
			 	global_position.length())
			
			if (positionRegardingShell < 
				actualPositonNearestCharacters):
				nearestCharacter = characters[i]
		
		body.linear_velocity = (nearestCharacter.global_position - 
			global_position).normalized() * (body.speedVelocity / 2.5)
		DestroyBaff()
		pass
	pass # Replace with function body.
