import json
import nexmo


class NexmoAPI:

  def __init__(self):
      with open("./nexmo_cred.json") as credentials:
          cred = json.load(credentials)
          key = cred["key"]
          secret = cred["secret"]
      self.client = nexmo.Client(key=key, secret=secret)

  def send_code(self, phone_number):
      self.response = self.client.start_verification(
          number=phone_number,
          brand="TradIn",
          workflow_id="5",
          code_length="4")
      self.output_response()


  def verify_code(self, request_id, code):
      self.response = self.client.check_verification(request_id, code=code)
      self.output_response()


  def output_response(self):
      if self.response["status"] == "0":
          print("Started verification request_id is %s" %
                (self.response["request_id"]))
      else:
          print("Error: %s" % self.response["error_text"])
