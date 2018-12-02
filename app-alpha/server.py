import os

from flask import Flask
from redis import Redis, RedisError

# Connect to Redis
redis = Redis(host="redis", db=0, socket_connect_timeout=2, socket_timeout=2)

# Create flask app
app = Flask(__name__)

# Define route /
@app.route("/")
def hello():
    # Response format
    html = "Hostname:{hostname}\n"\
           "Version:{version}\n"

    # return hostname and application version informations
    return html.format(hostname=os.getenv("HOSTNAME", "-"), version=os.getenv("VERSION", "0"))

# Define route /test
@app.route("/test")
def test_redis():
    try:
        # Try to increment value "value"
        resp = "value: " + str(redis.incr("value"))
    except RedisError:
        # If error probably cannot connect to redis
        resp = "cannot connect to redis\n"

    # return resp value or error
    return resp

# Main
if __name__ == "__main__":
    # Run on port 8080
    app.run(host='0.0.0.0', port=8080)