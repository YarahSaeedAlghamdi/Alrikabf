// import 'dart:html' as html;
// import 'dart:ui_web' as ui;

// import 'package:flutter/material.dart';

// class CameraFeedPage extends StatefulWidget {
//   const CameraFeedPage({Key? key}) : super(key: key);

//   @override
//   _CameraFeedPageState createState() => _CameraFeedPageState();
// }

// class _CameraFeedPageState extends State<CameraFeedPage> {
//   late html.VideoElement _videoElement;
//   bool _isCameraOpen = false;

//   @override
//   void initState() {
//     super.initState();

//     // Initialize the video element for the camera feed
//     _videoElement = html.VideoElement()
//       ..autoplay = true
//       ..style.width = '100%'
//       ..style.height = '100%'
//       ..style.borderRadius = '15px';

//     // Register the custom view
//     const String viewType = 'camera-feed';
//     // ignore: undefined_prefixed_name
//     ui.platformViewRegistry.registerViewFactory(viewType, (int viewId) => _videoElement);
//   }

//   void _openCamera() {
//     html.window.navigator.mediaDevices?.getUserMedia({
//       'video': {'facingMode': 'environment'}, // Use the back camera if available
//     }).then((stream) {
//       _videoElement.srcObject = stream;
//       setState(() {
//         _isCameraOpen = true;
//       });
//     }).catchError((error) {
//       print('Error accessing camera: $error');
//     });
//   }

//   void _closeCamera() {
//     _videoElement.srcObject?.getTracks().forEach((track) {
//       track.stop();
//     });
//     setState(() {
//       _isCameraOpen = false;
//     });
//   }

//   @override
//   void dispose() {
//     _closeCamera();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Camera Feed'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 300,
//               height: 300,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.black, width: 2),
//                 borderRadius: BorderRadius.circular(15),
//                 color: Colors.black12,
//               ),
//               child: _isCameraOpen
//                   ? HtmlElementView(viewType: 'camera-feed')
//                   : const Center(child: Text('Camera is off')),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: _isCameraOpen ? null : _openCamera,
//                   child: const Text('Open Camera'),
//                 ),
//                 const SizedBox(width: 20),
//                 ElevatedButton(
//                   onPressed: _isCameraOpen ? _closeCamera : null,
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                   child: const Text('Close Camera'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
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
      ..style.position = 'absolute' // Ensures the video fits the container
      ..style.top = '0'
      ..style.left = '0'
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.objectFit = 'cover' // Makes sure video covers the container
      ..style.borderRadius = '15px';

    ui.platformViewRegistry.registerViewFactory(
      _viewID,
      (int viewId) => _videoElement!,
    );
  }

  void _openCamera() {
    html.window.navigator.mediaDevices?.getUserMedia({
      'video': {'facingMode': 'environment'},
    }).then((stream) {
      _videoElement?.srcObject = stream;
      setState(() {
        _isCameraOpen = true;
      });

      // Placeholder function to simulate AI text detection from the camera
      _startTextDetection();
    }).catchError((error) {
      print('Error accessing camera: $error');
    });
  }

  void _startTextDetection() {
    // TODO: Integrate your AI model to update detected text
    // This is a simulation of text detection output
    setState(() {
      _detectedText =
          "مثال على النص المكتشف"; // Replace this with actual model output
    });
  }

  void _closeCamera() {
    _videoElement?.srcObject?.getTracks().forEach((track) {
      track.stop();
    });
    _videoElement?.remove();
    setState(() {
      _isCameraOpen = false;
      _initializeCamera();
      _detectedText =
          "النص سيظهر هنا"; // Reset detected text when the camera is closed
    });
  }

  @override
  void dispose() {
    _closeCamera();
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
                        backgroundColor: Color.fromARGB(255, 255, 133, 51),
                      ),
                      child: const Text(
                        'إغلاق الكاميرا',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'AvenirArabic',
                          color: Colors.white
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
