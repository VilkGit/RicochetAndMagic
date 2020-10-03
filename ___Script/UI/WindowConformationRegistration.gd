extends Control


func _on_Yes_button_up():
	var login = $"../Edits/EditNick".text
	var password = $"../Edits/EditPassword".text
	
	var url = "signup"
	var headers = ["Content-Type: application/x-www-form-urlencoded"]
	var body = "login={login}&password={password}".format(
		{"login":login, "password":password})
	get_node("SignUpServer").request(
		SW.url(url), headers, false, HTTPClient.METHOD_POST, body)

func _on_No_button_up():
	hide()
	pass # Replace with function body.


func _on_SignUpServer_request_completed(result, response_code, headers, body):
	print("work")
	if response_code == 200:
		var tBody = body.get_string_from_utf8()
		
		if tBody == "True":
			$"../LabelTextInfo".text = "You are registered"
		else:
			$"../LabelTextInfo".text = "This login is registered !!!"
		hide()
	pass # Replace with function body.
