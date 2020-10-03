extends Control

export var textureFocusButton:Texture
export var textureNotFocusButton:Texture

func openLevels():
	focusButtonLevel(G.numberLevel)
	var levelsNode = get_children()
	for i in range(len(levelsNode)):
		if i >= G.maxNumOpenLevel: break
		levelsNode[i].get_node("CloseActive").visible = false
		
func focusButtonLevel(numLevel:int):
	var levelsNode = get_children()
	levelsNode[G.numberLevel-1].texture_normal = textureNotFocusButton
	levelsNode[numLevel - 1].texture_normal = textureFocusButton
	TextureButton
	pass
	
func writeNumberLevel(numLevel:int):
	var levelsNode = get_children()
	if not levelsNode[numLevel-1].get_node("CloseActive").visible:
		if G.numberLevel != numLevel:
			focusButtonLevel(numLevel)
			G.numberLevel = numLevel
			S.emit_signal("clickOnButton")
			
func _on_focusButton(obj):
	writeNumberLevel(int(obj.name))
	pass # Replace with function body.
