extends Node

#const URL_SERVER = "http://127.0.0.1:8080"
const URL_SERVER = "http://ricochet1.herokuapp.com"
var login = ""
var password = ""
var keySession = ""
const keyApp = "RI43CU3J47V32JC7"

func _ready():
	CheckActualeApp()

func url(path):
	return URL_SERVER+"/"+path

func returnHeaders():
	var headers = [
		"Content-Type: application/x-www-form-urlencoded",
		"Key-Session-Client:{key}".format({"key": keySession})
		]
	return headers

func CheckWrongKey(text):
	if text == "WK":
		return true
	else:
		return false

# Start UpdateKeySession	
var quntityRequestUpdata = 0
var nodePathSceneSignIn = "res://__Scene/Menu/Menu.tscn"
var httpRequstUpdataKey = null
var selfObjCallFunction = null
var selfNameCallFunction = ""

func UpdataKeySession(objCallFunction = null, nameCallFunction = ""):
	if login == "" and password == "":
		print("login or password is empty")
		G.firstStart = true
		get_tree().change_scene(nodePathSceneSignIn)
		return false
	
	if httpRequstUpdataKey == null:
		print("HTTP null")
		httpRequstUpdataKey = HTTPRequest.new()
		$".".add_child(httpRequstUpdataKey)
		httpRequstUpdataKey.connect("request_completed",self,
			"RequestSignInCompleted")
			
	selfObjCallFunction = objCallFunction
	selfNameCallFunction = nameCallFunction
		
	var url = "signin"
	var headers = [
		"Content-Type: application/x-www-form-urlencoded",
		]
	var body = "login={login}&password={password}".format(
		{"login":login, "password":password})
	httpRequstUpdataKey.request(
		url(url), headers, false, HTTPClient.METHOD_POST, body)
	return true
	
func RequestSignInCompleted(result, response_code, headers, body):
	if response_code == 200:
		var t_body = body.get_string_from_utf8()
		if t_body == "True":
			httpRequstUpdataKey.queue_free()
			httpRequstUpdataKey = null
			keySession = SearchHeadersValInArr(
				"Key-Session-Server", headers)
			G.maxNumOpenLevel = int(SearchHeadersValInArr(
				"Max-Number-Level", headers))
			login = login
			password = password
			if selfObjCallFunction != null or selfNameCallFunction != "":
				if selfObjCallFunction.has_method(selfNameCallFunction):
					selfObjCallFunction.call(selfNameCallFunction)
					
		elif t_body == "False":
			print("Not right login or password")
			G.firstStart = true
			get_tree().change_scene(nodePathSceneSignIn)
			
	elif quntityRequestUpdata >= 5:
		quntityRequestUpdata += 1
		UpdataKeySession()
	
	elif quntityRequestUpdata < 5:
		G.firstStart = true
		get_tree().change_scene(nodePathSceneSignIn)
	pass
	
# End UpdataKeySession	
	
func SearchHeadersValInArr(search_header, array_headers):
	for i in len(array_headers):
		if len(array_headers[i]) < len(search_header): continue
		if SliceStr(array_headers[i], 0, len(search_header)) == search_header:
			return ReturnValHeader(array_headers[i])
			
	return null
	
func SliceStr(text, start=0, stop=-1, step=1):
	if stop == -1: stop = len(text)
	var record = ""
	for i in range(start, stop, step):
		record += text[i]
		
	return record

func ReturnValHeader(header):
	var id_char = -1
	for i in range(len(header)):
		if header[i] == ":":
			id_char = i
			break
			
	if id_char != -1:
		return SliceStr(header, id_char+1)

func DecryptArrHttpResponse(str_arr):
	var intermediate_chr_arr = ""
	for i in str_arr:
		if i == "[":
			pass
			
		elif i == "]":
			intermediate_chr_arr += "|"
			
		elif i == "'":
			pass
			
		else:
			intermediate_chr_arr += i
			
	intermediate_chr_arr = SliceStr(intermediate_chr_arr, 0, len(intermediate_chr_arr)-2)
	var arr = intermediate_chr_arr.split("|")
	for i in range(1, len(arr)):
		arr[i] = SliceStr(arr[i], 1)
		
	var return_arr = []
	for i in range(len(arr)):
		var intermediate_arr = arr[i].split(",")
		return_arr.append(intermediate_arr)
		
	return return_arr

# request for check actuale version the game
var req:HTTPRequest
func CheckActualeApp():
	req = HTTPRequest.new()
	$".".add_child(req)
	req.connect("request_completed", self, "AnswerCheckActualeApp")
	
	var url = "check_actuale_app"
	var headers = ["Content-Type: application/x-www-form-urlencoded",
		"Key-App: " + keyApp]
	var body = ""
	req.request(
		url(url), headers, false, HTTPClient.METHOD_POST, body)

func AnswerCheckActualeApp(result, response_code, headers, body):
	if (response_code != 200): get_tree().quit()
	var t_body = body.get_string_from_utf8()
	if t_body != "True": get_tree().quit()
	req.queue_free()

