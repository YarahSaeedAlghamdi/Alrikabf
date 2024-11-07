import requests
import json
import base64

# Replace 'path_to_image.jpg' with the path to an actual image file
with open("test_image.png", "rb") as image_file:
    encoded_string = base64.b64encode(image_file.read()).decode('utf-8')

# Replace 'http://127.0.0.1:5000/predict' with the actual URL your Flask app is using
url = 'http://127.0.0.1:5000/predict'
data = {'image': encoded_string}
headers = {'Content-Type': 'application/json'}

response = requests.post(url, data=json.dumps(data), headers=headers)
print(response.text)
