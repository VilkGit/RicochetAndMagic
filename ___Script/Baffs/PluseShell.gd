extends Baff

export var quntityPluseShell = 5

func _on_Body_body_entered(body):
	if("tag" in body and body.tag == "Shall"):
		var showInfo = load("res://__Prefab/UI/ShowInfo.tscn").instance()
		showInfo.rect_global_position = self.global_position
		showInfo.SetText( "+" + str(quntityPluseShell))
		$"/root".add_child(showInfo)
		S.emit_signal("BaffPluseShell", body.type, quntityPluseShell)
		DestroyBaff()
		pass
	pass # Replace with function body.
