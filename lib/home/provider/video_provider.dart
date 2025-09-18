
import 'package:flutter/material.dart';
import 'package:noviindus_test2/home/service/home_service.dart';
import 'package:video_player/video_player.dart';
class VideoProvider with ChangeNotifier {
  final _homeService = HomeService();
  
  int currentlyPlayingIndex = -1;
  VideoPlayerController? videoController;
  bool _isInitializing = false;
  
  bool get isInitializing => _isInitializing;
  
  Future<void> playVideo(String url, int index) async {
    if (currentlyPlayingIndex == index && videoController?.value.isInitialized == true) {
      return;
    }
    
    _isInitializing = true;
    notifyListeners();
    
  
    await _disposeCurrentController();
    
    currentlyPlayingIndex = index;
    
    try {
      final controller = VideoPlayerController.network(
        url,
        videoPlayerOptions: VideoPlayerOptions(
          allowBackgroundPlayback: false,
          mixWithOthers: false,
        ),
      );
      
      videoController = controller;
      await controller.initialize();
      await controller.play();
      
    } catch (e) {
      debugPrint("Error initializing video: $e");
      currentlyPlayingIndex = -1;
    }
    
    _isInitializing = false;
    notifyListeners();
  }
  
  Future<void> _disposeCurrentController() async {
    if (videoController != null) {
      try {
        if (videoController!.value.isInitialized) {
          await videoController!.pause();
        }
        await videoController!.dispose();
      } catch (e) {
        debugPrint("Error disposing controller: $e");
      }
      videoController = null;
    }
  }
  
  void pauseVideo() {
    if (videoController?.value.isInitialized == true) {
      videoController!.pause();
      notifyListeners();
    }
  }
  
  void togglePlayPause() {
    if (videoController == null || !videoController!.value.isInitialized) return;
    
    if (videoController!.value.isPlaying) {
      videoController!.pause();
    } else {
      videoController!.play();
    }
    notifyListeners();
  }
  
  @override
  void dispose() {
    _disposeCurrentController();
    super.dispose();
  }
}
