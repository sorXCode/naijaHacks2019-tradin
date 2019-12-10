import json
import nexmo
import urllib3

with open("./nexmo_cred.json") as credentials:
    cred = json.load(credentials)
    key = cred["key"]
    secret = cred["secret"]

http = urllib3.PoolManager()


# response = http.request(
#     'GET', f"https://rest.nexmo.com/sc/us/2fa/json?api_key={key}&api_secret={secret}&to=07039127884&pin=3434")
client = nexmo.Client(key=key, secret=secret)


response = client.start_verification(
  number="2347039127884",
  brand="TradIn",
  workflow_id="5",
  code_length="4")

if response["status"] == "0":
  print("Started verification request_id is %s" % (response["request_id"]))
else:
  print("Error: %s" % response["error_text"])

# response = client.check_verification("6c70fc14815140d79dacbf5fcc9085b1", code=8678)


print(response)
