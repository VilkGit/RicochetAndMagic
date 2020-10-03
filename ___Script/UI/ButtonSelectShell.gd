extends TextureButton

var typeShell = G.TYPE_SHELL.None setget setType,getType
var quntityShell:int = 0 setget ,getQuentity
var textureSelectButtonShell = load(
		"res://___Script/UI/GetTextureForButtonSelectShell.gd").new()

func getType():
	return typeShell

func setType(type):
	typeShell = type
	texture_normal = textureSelectButtonShell.GetTexture(type)
func getQuentity():
	return quntityShell

func _on_ButtonSelectShell_button_up():
	S.emit_signal("chenchTypeShell", typeShell)
	pass # Replace with function body.

func SetLabelQuntityShell(qunShell:int):
	var LabelQuntityShell = get_node("QuantityShell")
	quntityShell = qunShell
	LabelQuntityShell.set_text(String(qunShell))



