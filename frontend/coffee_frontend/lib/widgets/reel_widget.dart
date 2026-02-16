import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class ReelWidget extends StatefulWidget {
  final String videoUrl;
  const ReelWidget({super.key, required this.videoUrl});

  @override
  _ReelWidgetState createState() => _ReelWidgetState();
}

class _ReelWidgetState extends State<ReelWidget> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      showControls: false,
      aspectRatio: _videoPlayerController.value.aspectRatio,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
        ? AspectRatio(
            aspectRatio: _chewieController!.aspectRatio!,
            child: Chewie(controller: _chewieController!),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
