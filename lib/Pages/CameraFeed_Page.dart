import 'dart:html' as html;
import 'dart:ui_web' as ui;

import 'package:alrikabf/Components/background.dart';
import 'package:alrikabf/Components/navigation_bar.dart';
import 'package:flutter/material.dart';

class CameraFeedPage extends StatefulWidget {
  const CameraFeedPage({super.key});

  @override
  CameraFeedPageState createState() => CameraFeedPageState();
}

class CameraFeedPageState extends State<CameraFeedPage> {
  html.VideoElement? _videoElement;
  bool _isCameraOpen = false;
  String _viewID = 'cameraFeed';
  String _detectedText = "النص سيظهر هنا"; // Placeholder for detected text

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
  }

  void _openCamera() {
    _initializeCamera(); // Reinitialize the camera view

    html.window.navigator.mediaDevices?.getUserMedia({
      'video': {'facingMode': 'environment'},
    }).then((stream) {
      _videoElement?.srcObject = stream;
      if (mounted) {
        setState(() {
          _isCameraOpen = true;
          _detectedText = "مثال على النص المكتشف"; // Sample text for detected content
        });
      }
    }).catchError((error) {
      print('Error accessing camera: $error');
    });
  }

  void _closeCamera() {
    // Stop all video tracks if the camera is open
    _videoElement?.srcObject?.getTracks().forEach((track) {
      track.stop();
    });
    _videoElement?.srcObject = null;

    // Only call setState if the widget is still mounted
    if (mounted) {
      setState(() {
        _isCameraOpen = false;
        _detectedText = "النص سيظهر هنا"; // Reset the detected text
      });
    }
  }

  @override
  void dispose() {
    // Directly release resources without calling setState
    _videoElement?.srcObject?.getTracks().forEach((track) {
      track.stop();
    });
    _videoElement = null; // Clear video element to release memory
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
