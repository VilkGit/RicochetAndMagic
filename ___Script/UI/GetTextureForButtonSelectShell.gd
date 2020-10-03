extends Node

var dictTexture = {
	G.TYPE_SHELL.Ise : "res://Image/UI/UILevel/Ise.png",
	G.TYPE_SHELL.Magma : "res://Image/UI/UILevel/Magma.png",
	G.TYPE_SHELL.Stone : "res://Image/UI/UILevel/Rock.png",
	G.TYPE_SHELL.Grass : "res://Image/UI/UILevel/Grass.png"
	}

func GetTexture(typeShell):
	return load(dictTexture[typeShell])