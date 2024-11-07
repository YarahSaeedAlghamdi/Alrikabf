import pickle
import numpy as np
from flask import Flask, request, jsonify
from flask_cors import CORS
import base64
from PIL import Image
import io

# Initialize Flask app
app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Load your trained model
with open('trained_model.pickle', 'rb') as f:
    model = pickle.load(f)

# Preprocessing function
def preprocess_image(image):
    # Convert image to grayscale
    image = image.convert('L')  # 'L' mode is for grayscale

    # Resize the image to the expected input size (modify as needed)
    image = image.resize((64, 64))  # Replace with your model's expected input size

    # Convert to numpy array
    image_array = np.array(image)

    # Normalize the image to the range [0, 1]
    image_array = image_array / 255.0

    # Expand dimensions to match model input (for batch size of 1)
    image_array = np.expand_dims(image_array, axis=0)

    return image_array

@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Get JSON data from the request
        data = request.get_json()
        print("Received data:", data)  # Log the received data for debugging

        # Check if 'image' key is in data
        if 'image' not in data:
            print("No 'image' key in the data")
            return jsonify({'error': 'No image provided'}), 400

        # Decode the base64 image
        base64_image = data['image']
        
        try:
            image_data = base64.b64decode(base64_image)
        except Exception as decode_error:
            print(f"Error decoding base64: {decode_error}")
            return jsonify({'error': 'Invalid base64 image data'}), 400

        # Convert the decoded data to an image
        image = Image.open(io.BytesIO(image_data))

        # Preprocess the image
        processed_image = preprocess_image(image)

        # Predict using the model
        prediction = model.predict(processed_image)

        # Decode the prediction if needed
        detected_sign = decode_prediction(prediction)

        # Return the prediction as JSON
        return jsonify({'detected_sign': detected_sign}), 200

    except Exception as e:
        print(f'Error: {e}')
        return jsonify({'error': str(e)}), 500

def decode_prediction(prediction):
    # Example: Convert model output to a label
    class_labels = ['Alef', 'Beh', 'Seen', 'Kaf']  # Replace with your actual labels
    predicted_index = np.argmax(prediction)  # Assuming prediction is a probability array
    return class_labels[predicted_index]

if __name__ == '__main__':
    app.run(debug=True, port=5001)  # Use a different port if needed
