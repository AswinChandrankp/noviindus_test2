import 'package:flutter/material.dart';
import 'package:noviindus_test2/home/model/home_Model.dart';
import 'package:noviindus_test2/home/provider/home_provider.dart';
import 'package:noviindus_test2/home/provider/video_provider.dart';
import 'package:noviindus_test2/home/service/home_service.dart';
import 'package:noviindus_test2/widgets/timehelper.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoSection extends StatelessWidget {
  final FeedResult video;
  final int index;

  const VideoSection({Key? key, required this.video, required this.index})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoProvider>(
      builder: (context, videoProvider, child) {
        final isPlaying =
            videoProvider.currentlyPlayingIndex == index &&
            videoProvider.videoController != null &&
            videoProvider.videoController!.value.isInitialized;
        final isInitializing =
            videoProvider.currentlyPlayingIndex == index &&
            videoProvider.isInitializing;

        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _UserHeader(),

              const SizedBox(height: 12),

              _VideoPlayer(context, videoProvider, isPlaying, isInitializing),

              const SizedBox(height: 12),

              _Description(),
            ],
          ),
        );
      },
    );
  }

  Widget _UserHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: video.user.image != null
                ? NetworkImage(video.user.image!)
                : null,
            backgroundColor: Colors.grey[600],
            child: video.user.image == null
                ? Text(
                    video.user.name?.substring(0, 1).toUpperCase() ?? "U",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                video.user.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "${Timehelper().getTimeAgo(video.createdAt)}",
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _VideoPlayer(
    BuildContext context,
    VideoProvider videoProvider,
    bool isPlaying,
    bool isInitializing,
  ) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: GestureDetector(
          onTap: () {
            if (isPlaying) {
              videoProvider.togglePlayPause();
            } else {
              videoProvider.playVideo(video.video, index);
            }
          },
          child: AspectRatio(
            aspectRatio: isPlaying
                ? videoProvider.videoController!.value.aspectRatio
                : 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(0),
              ),
              child: isInitializing
                  ? _buildLoadingState()
                  : isPlaying
                  ? _ActiveVideoPlayer(videoProvider)
                  : _buildThumbnail(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Stack(
      children: [
        Image.network(
          video.image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey[800],
            child: const Icon(
              Icons.broken_image,
              color: Colors.white54,
              size: 48,
            ),
          ),
        ),

        Container(
          color: Colors.black45,
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _ActiveVideoPlayer(VideoProvider videoProvider) {
    return Stack(
      children: [
        Center(
          child: AspectRatio(
            aspectRatio: videoProvider.videoController!.value.aspectRatio,
            child: VideoPlayer(videoProvider.videoController!),
          ),
        ),

        Center(
          child: GestureDetector(
            onTap: videoProvider.togglePlayPause,
            child: AnimatedOpacity(
              opacity: !videoProvider.videoController!.value.isPlaying
                  ? 1.0
                  : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 4,
            child: VideoProgressIndicator(
              videoProvider.videoController!,
              allowScrubbing: true,
              colors: const VideoProgressColors(
                playedColor: Colors.red,
                bufferedColor: Colors.white30,
                backgroundColor: Colors.white12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildThumbnail() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          video.image,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return Container(
              color: Colors.grey[800],
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey[800],
            child: const Icon(
              Icons.broken_image,
              color: Colors.white54,
              size: 48,
            ),
          ),
        ),

        Center(
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_arrow,
              size: 30,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _Description() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        video.description,
        style: TextStyle(color: Colors.grey[300], fontSize: 14, height: 1.4),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
