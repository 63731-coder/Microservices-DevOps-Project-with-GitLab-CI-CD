from flask import Flask, jsonify
import os


app = Flask(__name__)

@app.route("/api/message")
def message():
    return jsonify({"message": "Hello from Flask!"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))

