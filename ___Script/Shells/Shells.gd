extends Node

class_name Shells

var shellObjects = {}
var shellsQuantity = []

func addShell(shell:Resource, quantity:int):
	var obj = shell.instance()
	shellObjects[obj.type] = shell
	shellsQuantity.append(quantity)

func PluseQuntityShell(key, quntity:int):
	var shellPrefabsKey = shellObjects.keys()
	for i in range(len(shellPrefabsKey)):
		if shellPrefabsKey[i] == key:
			shellsQuantity[i] += quntity