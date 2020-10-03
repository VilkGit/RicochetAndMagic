extends Enemy

func _init():
	hp = 3
	animNodePath = "Skin/Anim"
	type = G.TYPE_ENEMY.Trol

func _on_Body_body_entered(body):
	if("tag" in body and body.tag == "Shall"):
		DamageOnCharacter(body.damage)
		body.DestroyShell()
	pass # Replace with function body.

func DamageOnCharacter(damage:Damage):
	PlayAudioCharacter(
		"res://Audio/Characters/Trol/DamageTrol.wav")
	.DamageOnCharacter(damage)
	
func KillCharacter():
	PlayAudioCharacter(
		"res://Audio/Characters/Trol/DeathTrol.wav")
	.KillCharacter()