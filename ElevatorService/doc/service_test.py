
import requests

HOST = "http://192.168.77.47:3000"

# Create a new case
params = {"engineer_id": "1", "case_name": "sample_case", "elevator_tag": "ELEVATOR_001", "description": "What's wrong?"}
r = requests.post("{}/service/create_case".format(HOST), params)
print(r.text)

# Create problem for the new case
files = {"photo": open("sample.jpg", "rb")}
params = {"case_name": "sample_case", "label": "Cable broken.", "description": "Red cable broken."}
r = requests.post("{}/service/create_problem".format(HOST), params, files=files)
print(r.text)
