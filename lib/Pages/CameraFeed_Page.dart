import 'dart:html' as html;
import 'dart:convert';
import 'dart:ui_web' as ui;
import 'package:alrikabf/Components/background.dart';
import 'package:alrikabf/Components/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CameraFeedPage extends StatefulWidget {
  const CameraFeedPage({super.key});

  @override
  CameraFeedPageState createState() => CameraFeedPageState();
}

class CameraFeedPageState extends State<CameraFeedPage> {
  html.VideoElement? _videoElement;
  bool _isCameraOpen = false;
  bool _isUsingFrontCamera = false; // Track which camera is in use
  String _viewID = 'cameraFeed';
  String _detectedText = "النص سيظهر هنا"; // Placeholder for detected text
  late html.CanvasElement _canvas; // Canvas for frame capture

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() {
    _viewID = 'cameraFeed_${DateTime.now().millisecondsSinceEpoch}';

    _videoElement = html.VideoElement()
      ..autoplay = true
      ..style.position = 'absolute'
      ..style.top = '0'
      ..style.left = '0'
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.objectFit = 'cover'
      ..style.borderRadius = '15px';

    // Register the video element with a unique view ID
    ui.platformViewRegistry.registerViewFactory(
      _viewID,
      (int viewId) => _videoElement!,
    );

    // Initialize canvas for capturing frames
    _canvas = html.CanvasElement(width: 300, height: 300);
  }

  void _openCamera() {
    _initializeCamera();

    html.window.navigator.mediaDevices?.getUserMedia({
      'video': {'facingMode': _isUsingFrontCamera ? 'user' : 'environment'},
    }).then((stream) {
      _videoElement?.srcObject = stream;
      if (mounted) {
        setState(() {
          _isCameraOpen = true;
        });
        // Start capturing frames for prediction
        _captureAndSendFrame();
      }
    }).catchError((error) {
      print('Error accessing camera: $error');
    });
  }

  void _toggleCamera() {
    // Close the current camera first
    _closeCamera();
    // Toggle the camera mode
    setState(() {
      _isUsingFrontCamera = !_isUsingFrontCamera;
    });
    // Open the camera again with the new mode
    _openCamera();
  }

  void _captureAndSendFrame() async {
    if (_videoElement != null && _isCameraOpen) {
      // Draw the video frame to the canvas
      _canvas.context2D.drawImage(_videoElement!, 0, 0);
      // Get the frame as a data URL
      final imageData = _canvas.toDataUrl('image/jpeg');
      // Send the frame to the server
      await _sendFrameToServer(imageData);
      // Capture frames periodically
      Future.delayed(const Duration(seconds: 1), _captureAndSendFrame);
    }
  }

  Future<void> _sendFrameToServer(String imageData) async {
    try {
      // Remove the data URL prefix to get pure base64 content
      final base64Image = imageData.split(',').last;

      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/predict'), // Replace with server IP if not on the same device
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'image': base64Image}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          _detectedText = responseData['detected_sign'];
        });
      } else {
        print('Error from server: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending frame to server: $e');
    }
  }

  void _closeCamera() {
    _videoElement?.srcObject?.getTracks().forEach((track) {
      track.stop();
    });
    _videoElement?.srcObject = null;

    if (mounted) {
      setState(() {
        _isCameraOpen = false;
        _detectedText = "النص سيظهر هنا";
      });
    }
  }

  @override
  void dispose() {
    _closeCamera();
    _videoElement = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomNavigationBar(),
      body: Stack(
        children: [
          Background(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black12,
                  ),
                  child: _isCameraOpen
                      ? HtmlElementView(viewType: _viewID)
                      : const Center(child: Text('الكاميرا مغلقة')),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _isCameraOpen ? _closeCamera : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 133, 51),
                      ),
                      child: const Text(
                        'إغلاق الكاميرا',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'AvenirArabic',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _isCameraOpen ? null : _openCamera,
                      child: const Text(
                        'فتح الكاميرا',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'AvenirArabic',
                          color: Color.fromARGB(255, 255, 133, 51),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _isCameraOpen ? _toggleCamera : null,
                      child: const Text(
                        'تبديل الكاميرا',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'AvenirArabic',
                          color: Color.fromARGB(255, 255, 133, 51),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: 300,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Text(
                    _detectedText,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'AvenirArabic',
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
