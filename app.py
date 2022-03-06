from flask import Flask, app
from flask import render_template
import requests, os


app = Flask(__name__)

# App to print the User Agent Information
@app.route('/')
def welcome_message():
    info = "Welcome to 2022!"
    r = requests.utils.default_headers()
    return render_template('index.html', welcome_message=info, user_agent_info=r['User-Agent'])

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(debug=True, host='0.0.0.0', port=port)
