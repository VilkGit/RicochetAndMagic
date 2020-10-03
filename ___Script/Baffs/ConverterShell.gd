tool

extends Baff

export(Resource) var convShell

onready var skinConvert = get_node("Skin/SkinConvert")

func _ready():
	var obj = convShell.instance()
	skinConvert.texture = obj.get_node("Skin").texture

func _process(delta):
	if Engine.editor_hint:
		var obj = convShell.instance()
		skinConvert.texture = obj.get_node("Skin").texture


func _on_Body_body_entered(body):
	if("tag" in body and body.tag == "Shall"):
		var newShell = convShell.instance()
		newShell.directionVelocity = body.linear_velocity
		newShell.position = body.position
		newShell.numberMaxRicochets = body.numberMaxRicochets
		newShell.fantomActivate = body.fantomActivate
		body.get_parent().add_child(newShell)
		body.queue_free()
		DestroyBaff()
	pass # Replace with function body.
