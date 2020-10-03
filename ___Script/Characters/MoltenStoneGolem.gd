extends Enemy

func _init():
	hp = 2
	animNodePath = "Skin/Anim"
	type = G.TYPE_ENEMY.MoltenStoneGolem

func _on_Body_body_entered(body):
	if("tag" in body and body.tag == "Shall"):
		DamageOnCharacter(body.damage)
		body.DestroyShell()
		pass # Replace with function body.

func DamageOnCharacter(damage:Damage):
	PlayAudioCharacter(
		"res://Audio/Characters/MoltenStoneGolem/DamageMagmaGolem.wav")
	.DamageOnCharacter(damage)
	
func KillCharacter():
	PlayAudioCharacter(
		"res://Audio/Characters/MoltenStoneGolem/DeathMagmaGolem.wav")
	.KillCharacter()