"""
Yuma.AI Backend Application

A Flask-based backend leveraging Claude AI for intelligent features.
"""

from flask import Flask, jsonify
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

app = Flask(__name__)


@app.route("/health", methods=["GET"])
def health_check():
    """Health check endpoint."""
    return jsonify({"status": "healthy", "service": "Yuma.AI Backend"}), 200


@app.route("/api/v1/status", methods=["GET"])
def status():
    """API status endpoint."""
    return jsonify({"version": "1.0.0", "ready": True}), 200


if __name__ == "__main__":
    port = int(os.getenv("PORT", 5000))
    app.run(debug=True, host="0.0.0.0", port=port)
