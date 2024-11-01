import 'package:alrikabf/Components/background.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  late VideoPlayerController _controller;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('lib/assets/videos/vid.mp4')
      ..initialize().then((_) {
        setState(() {}); 
      }).catchError((error) {
        print("Error loading video: $error");
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _controller.setVolume(_isMuted ? 0 : 1.0);
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 133, 51),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous page
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white)
      ),
      body: Stack(
        children: [
          Background(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _controller.value.isInitialized
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _controller.value.isPlaying
                                            ? _controller.pause()
                                            : _controller.play();
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.replay_10),
                                    onPressed: () {
                                      final newPosition = _controller.value.position - const Duration(seconds: 10);
                                      _controller.seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.forward_10),
                                    onPressed: () {
                                      final maxPosition = _controller.value.duration;
                                      final newPosition = _controller.value.position + const Duration(seconds: 10);
                                      _controller.seekTo(newPosition < maxPosition ? newPosition : maxPosition);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(_isMuted ? Icons.volume_off : Icons.volume_up),
                                    onPressed: _toggleMute,
                                  ),
                                
                                ],
                              ),
                              VideoProgressIndicator(
                                _controller,
                                allowScrubbing: true,
                                colors: const VideoProgressColors(
                                  playedColor: Color.fromARGB(255, 255, 133, 51),
                                  bufferedColor: Colors.grey,
                                  backgroundColor: Colors.black,
                                ),
                              ),
                            ],
                          )
                        : const CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


