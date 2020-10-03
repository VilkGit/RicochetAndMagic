extends Node

class_name CheckLoginPass

var characters = "ABCDEFGHIKLMNOPQRSTUVWXYZabcdefghiklmnopqrstuvwxyz1234567890"

func check_login(login:String):
	check_login_on_char(login)
	check_login_on_len(login)
	
func check_password(password:String):
	check_password_on_char(password)
	check_password_on_len(password)
	
func check_login_on_char(login:String):

	for i in login:
		var find:bool = false
		for j in characters:
			if i == j:
				find = true
				break
		if not find:
			return false
	return true

func check_login_on_len(login:String):
	if len(login) < 5:
		return false
	else:
		return true
	
func check_password_on_char(password:String):
	for i in password:
		var find:bool = false
		for j in characters:
			if i == j:
				find = true
				break
		if not find:
			return false
	return true

func check_password_on_len(password:String):
	if len(password) < 6:
		return false
	else:
		return true