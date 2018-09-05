#!flask/bin/python
import os
from flask import Flask, request, jsonify

app = Flask(__name__)
API_MSG =  str(os.environ.get('API_MSG'))
API_AUTH = str(os.environ.get('API_AUTH'))

@app.route('/')
def index():
    if API_AUTH == "no-auth":
        return jsonify(dict({"no-auth": API_MSG}))
    elif API_AUTH == "key-auth":
        return jsonify(dict({"key-auth": API_MSG}))
    elif API_AUTH == "basic-auth":
        return jsonify(dict({"basic-auth": API_MSG}))
    else:
        return jsonify(dict({"error": "No type."}))

@app.route('/json', methods=["GET"])
def json():
    return jsonify(dict({"route": "json", "API_type" : API_AUTH, "message": "API :{}".format(API_MSG)}))

@app.route('/text', methods=["GET"])
def text():
    return API_MSG

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True, port=8241)
