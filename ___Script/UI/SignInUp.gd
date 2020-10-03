extends Control

export(NodePath) var nodeMainMenu
var login
var password
onready var lableTextInfo = $LabelTextInfo

func _on_SignIn_button_up():
	if CheckEdits():
		RequestSignInServer()

func _on_SignUp_button_up():
	if CheckEdits():
		$WindowConformationRegistration.show()


func CheckEdits():
	var checkLP = CheckLoginPass.new()
	login = $"Edits/EditNick".text
	password = $"Edits/EditPassword".text
	
	lableTextInfo.text = ""
	if checkLP.check_login_on_char(login):
		if checkLP.check_login_on_len(login):
			if checkLP.check_password_on_char(password):
				if checkLP.check_password_on_len(password):
					
					return true
					
				else:
					lableTextInfo.text = """Password must be
						 longer than 6 characters """
			else:
				lableTextInfo.text = """Password can only consist of
					 latin characters and numbers """
		else:
			lableTextInfo.text = """Login length must be more
				 than 5 characters """
	else:
		lableTextInfo.text = """Login can only consist of
					 latin characters and numbers """
	
	return false

func RequestSignInServer():
	lableTextInfo.text = ""
	var url = "signin"
	var headers = ["Content-Type: application/x-www-form-urlencoded"]
	var body = "login={login}&password={password}".format(
		{"login":login, "password":password})
	get_node("SignInServer").request(
		SW.url(url), headers, false, HTTPClient.METHOD_POST, body)

	pass

func _on_SignInServer_request_completed(result, response_code, headers, body):
	print(response_code)
	if response_code == 200:
		var tBody = body.get_string_from_utf8()
		if tBody == "True":
			SW.keySession = SW.SearchHeadersValInArr("Key-Session-Server", headers)
			G.maxNumOpenLevel = int(SW.SearchHeadersValInArr("Max-Number-Level", headers))
			SW.login = login
			SW.password = password
			hide()
			get_node(nodeMainMenu).show()
			
		elif tBody == "False":
			lableTextInfo.text = "Not right login or password"

	pass # Replace with function body.

func PlayAudioClickOnButton():
	S.emit_signal("clickOnButton")
	pass