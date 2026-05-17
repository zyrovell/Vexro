"""
Vexro Raspberry Pi Sync Server
Roblox emote favoriting system backend.
"""

import json
import os
from datetime import datetime, timezone
from functools import wraps
from flask import Flask, request, jsonify

# ── Configuration ─────────────────────────────────────────────────────────────

API_KEY = "change-me-before-deploy"
DATA_FILE = os.path.join(os.path.dirname(__file__), "vexro_favorites.json")
MAX_FAVORITES = 25
HOST = "0.0.0.0"
PORT = 5000

# ─────────────────────────────────────────────────────────────────────────────

app = Flask(__name__)


# ── Helpers ───────────────────────────────────────────────────────────────────

def load_data() -> dict:
    """Return the favorites store, creating the file if absent."""
    if not os.path.exists(DATA_FILE):
        return {}
    with open(DATA_FILE, "r", encoding="utf-8") as f:
        return json.load(f)


def save_data(data: dict) -> None:
    """Persist the favorites store to disk."""
    with open(DATA_FILE, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2)


def now_iso() -> str:
    return datetime.now(timezone.utc).isoformat()


def log_request(endpoint: str) -> None:
    ts = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S UTC")
    print(f"[{ts}] {request.method} {endpoint} — {request.remote_addr}")


def require_api_key(f):
    """Decorator: reject requests that lack the correct X-Api-Key header."""
    @wraps(f)
    def wrapper(*args, **kwargs):
        key = request.headers.get("X-Api-Key", "")
        if key != API_KEY:
            return jsonify({"error": "Unauthorized"}), 401
        return f(*args, **kwargs)
    return wrapper


# ── Routes ────────────────────────────────────────────────────────────────────

@app.route("/favorites", methods=["GET"])
@require_api_key
def get_favorites():
    log_request("/favorites")

    user_id = request.args.get("userId", "").strip()
    if not user_id:
        return jsonify({"error": "userId query parameter is required"}), 400

    data = load_data()
    entry = data.get(user_id, {"favorites": [], "updatedAt": None})

    return jsonify({
        "favorites": entry["favorites"],
        "updatedAt": entry.get("updatedAt"),
    })


@app.route("/favorites", methods=["POST"])
@require_api_key
def post_favorites():
    log_request("/favorites")

    body = request.get_json(silent=True)
    if not body:
        return jsonify({"error": "JSON body required"}), 400

    user_id = str(body.get("userId", "")).strip()
    if not user_id:
        return jsonify({"error": "userId is required"}), 400

    favorites = body.get("favorites")
    if not isinstance(favorites, list):
        return jsonify({"error": "favorites must be a list"}), 400

    # Enforce server-side cap
    favorites = favorites[:MAX_FAVORITES]

    data = load_data()
    data[user_id] = {
        "favorites": favorites,
        "updatedAt": now_iso(),
    }
    save_data(data)

    return jsonify({"ok": True})


@app.route("/health", methods=["GET"])
def health():
    log_request("/health")
    data = load_data()
    return jsonify({"ok": True, "users": len(data)})


# ── Entry point ───────────────────────────────────────────────────────────────

if __name__ == "__main__":
    print(f"[*] Vexro sync server starting on {HOST}:{PORT}")
    print(f"[*] Data file: {DATA_FILE}")
    app.run(host=HOST, port=PORT, debug=False)
