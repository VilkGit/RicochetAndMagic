import os
import json

from flask import Flask, request, Response

from InterfaseUserGame import WorkWithUser
from Session import WorkWithSession

app = Flask(__name__)
user = WorkWithUser()
session = WorkWithSession(os.environ.get('KEY_GENERATION'))

# decorator check session to existens
def dec_check_session(func): 
	def wrapper(*args, **kwargs):
		key = request.headers.get("Key-Session-Client")
		if session.check_session(key):
			return func()
		else:
			return "WK" #Wrong key!!!
	wrapper.__name__ = func.__name__
	return wrapper

# read users date from session file
def read_users_date(key_json):
	key = request.headers.get("Key-Session-Client")
	json_session = session.read_from_session(key)
	return json_session[key_json]

@app.route('/signup', methods=["POST"])
def signup():
	if request.method == "POST":
		login = request.form["login"]
		password = request.form["password"]

		return str(user.signup_in_game(login, password))
 
@app.route('/signin', methods=["POST"])
def signin():
	if request.method == "POST":
		login = request.form["login"]
		password = request.form["password"]
		if user.signin_in_game(login, password):
			resp = Response("True")
			key_session = session.create_session()
			resp.headers['Key-Session-Server'] = key_session
			resp.headers["Max-Number-Level"] = user.max_number_level(
				login)
			text_json = {"login":login}
			session.write_in_session(key_session, text_json)

			return resp

		else:
			return "False"

@app.route('/update_score', methods=["POST"])
@dec_check_session
def update_score():
	if request.method == "POST":
		login = read_users_date("login")
		score_user = request.form["score_user"]
		number_level = request.form["number_level"]
		user.update_score(login, score_user, number_level)

		return ""
	
@app.route('/create_rating', methods=["POST"])
@dec_check_session
def create_rating():
	if request.method == "POST":
		login = read_users_date("login")
		number_level = request.form["number_level"]
		
		return str(user.create_rating_user(login, number_level))

@app.route('/prevate_score', methods=["POST"])
@dec_check_session
def prevate_score():
	if request.method == "POST":
		login = read_users_date("login")
		number_level = request.form["number_level"]

		return str(user.prevate_score(login, number_level))

@app.route('/select_top_10', methods=["POST"])
@dec_check_session
def select_top_10():
	if request.method == "POST":
		number_level = request.form["number_level"]

		return str(user.select_top_10(number_level))
	
@app.route('/max_number_level', methods=["POST"])
@dec_check_session
def max_number_level():
	if request.method == "POST":
		login = read_users_date("login")

		return str(user.max_number_level(login))

@app.route('/delete_account', methods=["POST"])
@dec_check_session
def delete_account():
	if request.method == "POST":
		login = read_users_date("login")
		password = request.form["password"]

		return str(user.delete_user(login, password))

@app.route("/check_actuale_app", methods = ["POST"])
def check_actuale_app():
	key = os.environ.get('KEY_APP')
	if request.method == "POST":
		if key == request.headers.get("Key-App"):
			return "True"
		else:
			return "False"

@app.route("/test", methods = ["GET"])
def testConnect():
	if request.method == "GET":
		return "True"
	else:
		return "False"



if __name__ == '__main__':
    PORT = int(os.environ.get('PORT'))
    app.run(host="localhost", port=PORT)

