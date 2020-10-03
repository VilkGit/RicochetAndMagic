extends RigidBody2D

class_name Shell

var tag = "Shall"

var type = G.TYPE_SHELL.None
var fantomActivate = false

export var directionVelocity = Vector2(0,0)
export var speedVelocity = 1200
export var numberMaxRicochets = 5

var numberRicochets = 0
onready var damage:Damage = Damage.new(type)


func _ready():
	#Seting RigidBoby
	gravity_scale = 0
	contacts_reported = 1
	contact_monitor = true
	linear_damp = 0
	
	set_axis_velocity(directionVelocity.normalized() * speedVelocity)

func OnRicochet():
	if (numberRicochets >= numberMaxRicochets or
		 get_linear_velocity().length() < 20):
		fantomActivate = false
		DestroyShell()

	numberRicochets += 1

func DestroyShell():
	if not fantomActivate:
		ShowDestroyShell()
		queue_free()
		S.emit_signal("destroyShell")
		
func PlayAudioShell(audioParth):
	var audio = AudioStreamPlayer.new()
	$"/root".add_child(audio)
	audio.set_stream(load(audioParth))
	audio.set_volume_db(-6)
	audio.set_bus("Audio")
	audio.play()
	audio.connect("finished", audio, "queue_free")
	
func ShowDestroyShell():
	var parPref = load("res://__Prefab/Efects/ParticaleShell.tscn")
	var par = parPref.instance()
	G.addParticalNode(par)
	for i in get_children():
		if i.is_class("Sprite"):	
			par.texture = i.texture
	$"/root".add_child(par)
	par.restart()
	par.position = self.global_position
	