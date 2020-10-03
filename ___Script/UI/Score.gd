extends Node

class_name Score

var score = 0 setget ,getScore
const startScore = 200

func getScore():
	return score

func PlusKillChar(type = G.TYPE_ENEMY.None):
	if (type == G.TYPE_ENEMY.None):
		score += startScore * 1.1
		
	elif (type == G.TYPE_ENEMY.FrostGolem):
		score += startScore * 1.5
		
	elif (type == G.TYPE_ENEMY.MoltenStoneGolem):
		score += startScore * 2
		
	elif(type == G.TYPE_ENEMY.Trol):
		score += startScore * 1.75
	
	elif( type == G.TYPE_ENEMY.RockGolem ):
		score += startScore * 1.5
		
	elif(type == G.TYPE_ENEMY.Orc):
		score += startScore * 1.25
		
	elif(type == G.TYPE_ENEMY.Ogre):
		score += startScore * 1.25
		
	else:
		score += startScore
	
func MinusOfTime(time:int):
	if time >= 400: time = 400
	score -= time * 5
	if score < 0: score = 0

func PlusOfQuntityShells(ArrShells:Array):
	score += G.sumArray(ArrShells) * 100
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	