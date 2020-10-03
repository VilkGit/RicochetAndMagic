extends CanvasLayer

class_name UILevels

export(NodePath) var partNodeCharacterControl
export(Array, Resource) var shellPrefabs
export(Array, int) var shellPrefabsQuantity

var time = 0

var characterControl
var numCharastersOnLevel = 0

var scrollBar
var shells = Shells.new()
var loadedShell = G.TYPE_SHELL.None
var score:Score
onready var nodeFailGame = get_node("FailGame")
onready var nodeWinGame = get_node("WinGame")
onready var screenTextScore = get_node("Score/Value")
func _ready():
	OS.set_window_size(Vector2(960, 540)) #DELETE
	get_tree().paused = false
	characterControl = get_node(partNodeCharacterControl)
	
	score = Score.new()

	# Код привязки к глобальным сигналам
	S.connect("enemyLoad", self, "EnemyLoad")
	S.connect("enemyDeath", self, "EnemyDeath")
	S.connect("chenchTypeShell", self, "ChenchTypeShell")
	S.connect("characterShot", self, "CharacterShot")
	S.connect("destroyShell", self, "CheckForShells")
	
	S.connect("BaffPluseShell", self, "AddQuntityShell")
	
	# Код для передачи снаряда Персонажу
	for i in range(len(shellPrefabs)):
		shells.addShell(shellPrefabs[i], shellPrefabsQuantity[i])
		
	scrollBar = get_node("ScrollBarShells")
	scrollBar.SetButtonsSelectType(shells.shellObjects.keys(), 
		shells.shellsQuantity)
	
	loadedShell = shells.shellObjects.keys()[0]
	S.emit_signal("chenchTypeShell",loadedShell)
	#ChenchTypeShell(loadedShell)



func _input(event):
	if event is InputEventMouse:
		if event.button_mask == BUTTON_MASK_RIGHT:
			get_tree().reload_current_scene()






func _on_TouchCanvas_gui_input(event):
	if(characterControl.has_method("EventControlCharacter")):
		characterControl.EventControlCharacter(event)
	pass # Replace with function body.

func _on_Timer_timeout():
	time += 1
	get_node("Timer").start()
	pass # Replace with function body.

func EnemyLoad(enemy):
	numCharastersOnLevel += 1

func EnemyDeath(enemy):
	numCharastersOnLevel -= 1
	score.PlusKillChar(enemy.type)
	screenTextScore.text = String(score.getScore())
	if (numCharastersOnLevel <= 0):
		score.MinusOfTime(time)
		score.PlusOfQuntityShells(shells.shellsQuantity)
		if G.numberLevel == G.maxNumOpenLevel:
			CreateRatingServerRequest()
		else:
			UpdateRatingServerRequest()
			

# Work with server
func UpdateRatingServerRequest():
	var url = "update_score"
	var bodyUpdateScore = "score_user={scor}&number_level={nb}".format(
		{"scor":score.getScore(), "nb":G.numberLevel})
		
	$UpdateRatingServer.request(SW.url(url), SW.returnHeaders(), false,
		 HTTPClient.METHOD_POST, bodyUpdateScore)
	pass

func _on_UpdateRatingServer_request_completed(result,
	 response_code, headers, body):
	var text = body.get_string_from_utf8()
	if response_code == 200:
		if SW.CheckWrongKey(text):
			SW.UpdataKeySession(self, "UpdateRatingServerRequest")
			return
			
		TimeShowWinMenu(2)
	pass # Replace with function body.

func CreateRatingServerRequest():
	var url = "create_rating"
	var bodyCreateRating = "number_level={nb}".format(
		{"nb":G.numberLevel + 1})
		
	$CreateRatingServer.request(SW.url(url), SW.returnHeaders(), false,
		 HTTPClient.METHOD_POST, bodyCreateRating)
	pass

func _on_CreateRatingServer_request_completed(result,
	response_code, headers, body):
	var text = body.get_string_from_utf8()
	if response_code == 200:
		if SW.CheckWrongKey(text):
			SW.UpdataKeySession(self, "CreateRatingServerRequest")
			return
			
		if text == "True":
			G.maxNumOpenLevel += 1
		
		UpdateRatingServerRequest()
	pass # Replace with function body.

#End work with server



func ChenchTypeShell(type):
	loadedShell = type
	var shellPrefabsKey = shells.shellObjects.keys()
	for i in range(len(shellPrefabsKey)):
		if shellPrefabsKey[i] == type:
			if shells.shellsQuantity[i] > 0:
				characterControl.prefShell = shells.shellObjects[type]

func CharacterShot():
	var shellPrefabsKey = shells.shellObjects.keys()
	for i in range(len(shellPrefabsKey)):
		if shellPrefabsKey[i] == loadedShell:
			shells.shellsQuantity[i] -= 1
			if shells.shellsQuantity[i] <= 0:
				characterControl.prefShell = null 
			ChenchLabelQuntityShell(loadedShell)


func CheckForShells():
	if (G.sumArray(shells.shellsQuantity) <= 0 and
		len(characterControl.BoxShell.get_children()) <= 1):
			TimeShowFailMenu(3)

func ShowFailMenu():
	get_tree().paused = true
	nodeFailGame.setScoreInMenu(str(score.getScore()))
	nodeFailGame.show()

func TimeShowFailMenu(time:int):
	var t = Timer.new()
	add_child(t)
	t.wait_time = time;
	t.start()
	t.connect("timeout", self, "ShowFailMenu")

func ShowWinMenu():
	get_tree().paused = true
	nodeWinGame.setScoreInMenu(str(score.getScore()))
	nodeWinGame.show()

func TimeShowWinMenu(time:int):
	var t = Timer.new()
	add_child(t)
	t.wait_time = time;
	t.start()
	t.connect("timeout", self, "ShowWinMenu")
	
func ChenchLabelQuntityShell(type):
	var shellPrefabsKey = shells.shellObjects.keys()
	for i in range(len(shellPrefabsKey)):
		if shellPrefabsKey[i] == type:
			for j in scrollBar.get_node("ScrollBar").get_children():
				if j.getType() == type:
					j.SetLabelQuntityShell(shells.shellsQuantity[i])
					scrollBar.ChenchVallLabelShell(j.getType())
			
func AddQuntityShell(type, quntity:int):
	shells.PluseQuntityShell(type, quntity)
	ChenchLabelQuntityShell(type)







