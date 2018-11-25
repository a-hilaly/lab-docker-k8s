import os

from flask import Flask
from redis import Redis, RedisError

# Connect to Redis
redis = Redis(host="redis", db=0, socket_connect_timeout=2, socket_timeout=2)

app = Flask(__name__)

@app.route("/")
def hello():
    html = "Hostname:{hostname}\n"\
           "Version:{version}\n"
    return html.format(hostname=os.getenv("HOSTNAME", "-"), version=os.getenv("VERSION", "0"))

@app.route("/test")
def test_redis():
    try:
        resp = "value: " + redis.incr("value")
    except RedisError:
        resp = "cannot connect to Redis\n"

    return resp

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)