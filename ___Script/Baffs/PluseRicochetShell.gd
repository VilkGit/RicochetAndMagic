extends Baff

export var quntityPlusRicochet:int = 1





func _on_Body_body_entered(body):
	if("tag" in body and body.tag == "Shall"):
		var showInfo = load("res://__Prefab/UI/ShowInfo.tscn").instance()
		showInfo.rect_global_position = self.global_position
		showInfo.SetText( "+" + str(quntityPlusRicochet))
		$"/root".add_child(showInfo)
		body.numberMaxRicochets += quntityPlusRicochet
		DestroyBaff()
	pass # Replace with function body.
