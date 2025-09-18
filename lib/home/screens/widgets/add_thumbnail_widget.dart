import 'package:flutter/material.dart';
import 'package:noviindus_test2/home/provider/home_provider.dart';
import 'package:noviindus_test2/home/screens/widgets/boarder_painter.dart';

class AddThumbnailWidget extends StatelessWidget {
final Homeprovider homeprovider;
  const AddThumbnailWidget({super.key, required this.homeprovider});

  @override
  Widget build(BuildContext context) {
    return    Padding(
                  padding: const EdgeInsets.all(20),
                  child: homeprovider.thumbnailFile != null
                      ? Container(
                          height: 150,
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
                            child: Image.file(
                              homeprovider.thumbnailFile!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            homeprovider.pickImage();
                          },
                          child: Container(
                            height: 150,
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
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/Group 2362@2x.png",
                                      height: 25,
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      "Add a Thumbnail",
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
                )

;
  }
}