extends Node2D

class_name Enemy

var animNodePath:NodePath
var hp:int = 5 setget ,GetHP
var type = G.TYPE_ENEMY.None
var tag = "Enemy"

func GetHP():
	return hp

	
func MinusHP(value:int):
	var showInfo = load("res://__Prefab/UI/ShowInfo.tscn").instance()
	showInfo.rect_global_position = self.global_position
	showInfo.SetText( str(value) + "dm")
	$"/root".add_child(showInfo)
	hp -= abs(value)

func PlusHP(value:int):
	hp += abs(value)

func _ready():
	S.emit_signal("enemyLoad", self)
	PlayAnimationCharacter("Idle")

func DamageOnCharacter(damage:Damage):
	PlayAnimationCharacter("Hurt")
	damage.DamageToCharacter(self)
	if hp <= 0:
		KillCharacter()

func PlayAnimationCharacter(nameAnimation:String):
	var nAnim = get_node(animNodePath)
	if nAnim is AnimationPlayer:
		nAnim.play(nameAnimation, -1, 1.5)
		
func KillCharacter():
	S.emit_signal("enemyDeath", self)
	PlayAnimationCharacter("Dying")
	#isActive = false
	get_node("Body").queue_free()
	
func PlayAudioCharacter(audioParth):
	var audio = AudioStreamPlayer.new()
	$"..".add_child(audio)
	audio.set_stream(load(audioParth))
	audio.set_volume_db(-6)
	audio.set_bus("Audio")
	audio.play()
	audio.connect("finished", audio, "queue_free")
	
