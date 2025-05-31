from flask import Flask, request, jsonify
import ast
import os
import subprocess
import re

app = Flask(__name__)

# Environment-based password (instead of hardcoded)
PASSWORD = os.environ.get("APP_PASSWORD", "")

@app.route('/')
def hello():
    name = request.args.get('name', 'World')
    if not name.isalnum():
        return jsonify({"error": "Invalid name"}), 400
    return f"Hello, {name}!"

@app.route('/ping')
def ping():
    ip = request.args.get('ip')
    # Basic validation: IP must be in valid IPv4 format
    if not ip or not re.match(r"^\d{1,3}(\.\d{1,3}){3}$", ip):
        return jsonify({"error": "Invalid IP address"}), 400
    try:
        result = subprocess.run(["ping", "-c", "1", ip], capture_output=True, text=True, check=True)
        return result.stdout
    except subprocess.CalledProcessError as e:
        return jsonify({"error": "Ping failed", "details": e.stderr}), 500

@app.route('/calculate')
def calculate():
    expression = request.args.get('expr')
    try:
        # Only evaluate literal expressions (e.g., numbers, lists, basic arithmetic)
        result = ast.literal_eval(expression)
        return str(result)
    except (ValueError, SyntaxError):
        return jsonify({"error": "Invalid expression"}), 400

if __name__ == '__main__':
    # Run only on localhost for security
    app.run(host='127.0.0.1', port=5000)
#app.run(host='0.0.0.0', port=5000) 
