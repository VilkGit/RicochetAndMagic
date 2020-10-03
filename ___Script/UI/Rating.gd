extends Control

export(NodePath) var nodeMainMenu
var arrRating = []
func _on_Reload_button_up():
	RequestReloadServer()
	pass # Replace with function body.


func _on_Back_button_up():
	hide()
	get_node(nodeMainMenu).show()
	pass # Replace with function body.

func RequestReloadServer():
	var url = "select_top_10"
	var headers = [
		"Content-Type: application/x-www-form-urlencoded",
		"Key-Session-Client: {key}".format({"key":SW.keySession})
	]
	var body = "number_level="+str(G.numberLevel)
	$ReloadServer.request(SW.url(url), headers, false, HTTPClient.METHOD_POST, body)


func _on_ReloadServer_request_completed(result, response_code, headers, body):
	var text = body.get_string_from_utf8()
	if response_code == 200:
		if SW.CheckWrongKey(text):
			SW.UpdataKeySession(self, "RequestReloadServer")
			return
		arrRating = SW.DecryptArrHttpResponse(text)
		$TableRating.WriteInTable(arrRating)
	pass # Replace with function body.

func PlayAudioClickOnButton():
	S.emit_signal("clickOnButton")
	pass