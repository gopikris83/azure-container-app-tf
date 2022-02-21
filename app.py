from flask import Flask, app
from flask import render_template
import requests, os


app = Flask(__name__)

@app.route('/')
def welcome_message():
    info = "Welcome to 2022!"
    user_agent = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.82 Safari/537.36'}
    r = requests.get("https://httpbin.org/headers", headers=user_agent)
    return render_template('index.html', welcome_message=info, user_agent_info=r.text)

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(debug=True, host='0.0.0.0', port=port)
