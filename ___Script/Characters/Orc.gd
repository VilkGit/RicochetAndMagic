extends Enemy

func _init():
	hp = 1
	animNodePath = "Skin/Anim"
	type = G.TYPE_ENEMY.Orc

func _on_Body_body_entered(body):
	if("tag" in body and body.tag == "Shall"):
		DamageOnCharacter(body.damage)
		body.DestroyShell()
	pass # Replace with function body.

func DamageOnCharacter(damage:Damage):
	PlayAudioCharacter(
		"res://Audio/Characters/Orc/DamageOrc.wav")
	.DamageOnCharacter(damage)
	
func KillCharacter():
	PlayAudioCharacter(
		"res://Audio/Characters/Orc/DeathOrc.wav")
	.KillCharacter()