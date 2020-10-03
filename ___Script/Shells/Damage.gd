extends Node

class_name Damage

var typeShell = G.TYPE_SHELL.None
var character

func _init(typeShell):
	self.typeShell = typeShell
	pass

func DamageToCharacter(character):
	self.character = character
	
	if(character.type == G.TYPE_ENEMY.FrostGolem):
		DamageForFrostGolem()
		
	elif(character.type == G.TYPE_ENEMY.MoltenStoneGolem):
		DamageForMoltenStoneGolem()

	elif(character.type == G.TYPE_ENEMY.RockGolem):
		DamageForRockGolem()
		
	elif(character.type == G.TYPE_ENEMY.Ogre):
		DamageForOgre()
		
	elif(character.type == G.TYPE_ENEMY.Orc):
		DamageForOrc()
		
	elif(character.type == G.TYPE_ENEMY.Trol):
		DamageForTrol()
		
	else:
		DamageToOthers()
		pass
		
	self.character = null

func DamageToOthers():
	character.MinusHP(0)
	pass
	
func DamageForFrostGolem():
	if(typeShell == G.TYPE_SHELL.Magma):
		character.MinusHP(2)
		pass
	
	elif(typeShell == G.TYPE_SHELL.Ise):
		character.MinusHP(0)
	
	else:
		character.MinusHP(1)
		
func DamageForMoltenStoneGolem():
	if(typeShell == G.TYPE_SHELL.Ise):
		character.MinusHP(2)
	else:
		character.MinusHP(0)
	
func DamageForRockGolem():
	if(typeShell == G.TYPE_SHELL.Grass):
		character.MinusHP(2)
	elif(typeShell == G.TYPE_SHELL.Ise):
		character.MinusHP(0)	
	else:
		character.MinusHP(1)

func DamageForOgre():
	if(typeShell == G.TYPE_SHELL.Magma):
		character.MinusHP(1)
	else:
		character.MinusHP(1)
	
func DamageForOrc():
	if(typeShell == G.TYPE_SHELL.Magma):
		character.MinusHP(1)
	else:
		character.MinusHP(1)

func DamageForTrol():
	if(typeShell == G.TYPE_SHELL.Magma):
		character.MinusHP(1)
	else:
		character.MinusHP(1)

