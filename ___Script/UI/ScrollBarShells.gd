extends Control

var buttonSelectType:Resource
var labelQuntityShell:Label
var scrollBar
var positionButtonInScrollBarX = 0
func _ready():
	S.connect("chenchTypeShell", self, "ChenchVallLabelShell")
	S.connect("characterShot", self, "")
	buttonSelectType = load("res://__Prefab/UI/ButtonSelectShell.tscn")
	scrollBar = get_node("ScrollBar")
	labelQuntityShell = get_node("LabelQuntityShell")

func _on_ButtonOpenBar_button_down():
	S.emit_signal("clickOnButton")
	if scrollBar.visible:
		scrollBar.hide()
	else:
		scrollBar.show()
	
func SetButtonsSelectType(listKeys:Array, quntityShells:Array):
	for i in range(len(listKeys)):
		var obj = buttonSelectType.instance()
		obj.setType(listKeys[i])
		obj.SetLabelQuntityShell(quntityShells[i])
		obj.rect_position.x = positionButtonInScrollBarX
		positionButtonInScrollBarX += obj.rect_size.x + 10
		scrollBar.add_child(obj)

func ChenchVallLabelShell(type):
	for i in scrollBar.get_children():
		if i.getType() == type:
			labelQuntityShell.text = String(i.getQuentity())
	scrollBar.hide()
	pass

