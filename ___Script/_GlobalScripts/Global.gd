extends Node

enum TYPE_ENEMY{
	None = 0,
	FrostGolem = 1,
	MoltenStoneGolem = 2,
	Ogre = 3,
	Orc = 4,
	RockGolem = 5,
	Trol = 6
	}
enum TYPE_SHELL{
	None = 0,
	Magma = 1,
	Ise = 2,
	Stone = 3,
	Grass = 4
	}
var firstStart = true
var numberLevel = 1
var maxNumOpenLevel = 1

var ParticaleNodes = []

func addParticalNode(par:Node2D):
	if len(ParticaleNodes) > 4:
		for i in ParticaleNodes:
			i.queue_free()
		ParticaleNodes = []
	
	ParticaleNodes.append(par)

func sumArray(arr:Array):
	var result = 0
	for i in arr:
		result += float(i)
	return result









	












