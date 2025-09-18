import 'package:flutter/material.dart';
import 'package:noviindus_test2/home/provider/home_provider.dart';
import 'package:noviindus_test2/home/screens/widgets/boarder_painter.dart';
import 'package:video_player/video_player.dart';

class AddVideoWidget extends StatelessWidget {
final Homeprovider homeprovider;
  const AddVideoWidget({super.key, required this.homeprovider});

  @override
  Widget build(BuildContext context) {
    return    Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () {
                      homeprovider.pickVideo();
                    },
                    child: Container(
                      height: 280,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF1A1A1A),
                      ),
                      child: CustomPaint(
                        painter: DashedBorderPainter(
                          color: const Color.fromARGB(176, 255, 255, 255),
                          strokeWidth: .5,
                          dashPattern: [20, 25],
                        ),
                        child: homeprovider.videoFile != null
                            ? Stack(
                                children: [
                                  Container(
                                    height: 280,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xFF1A1A1A),
                                    ),
                                    child: Stack(
                                      children: [
                                        VideoPlayer(
                                          homeprovider.videoController!,
                                        ),
                                        Container(
                                          height: 280,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            color: Color.fromARGB(
                                              192,
                                              26,
                                              26,
                                              26,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: InkWell(
                                            onTap: () {
                                              homeprovider.playVideo();
                                            },
                                            child:
                                                homeprovider
                                                    .videoController!
                                                    .value
                                                    .isPlaying
                                                ? const SizedBox()
                                                : const Icon(
                                                    Icons.play_arrow_rounded,
                                                    color: Colors.white,
                                                    size: 50,
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Positioned(
                                  //   top: 10,
                                  //   right: 10,
                                  //   child: Container(

                                  //   )
                                ],
                              )
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/Group 2364.png"),
                                    SizedBox(height: 10),
                                    Text(
                                      "Select a video from Gallery",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                );
  }
}