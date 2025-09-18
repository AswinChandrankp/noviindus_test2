import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:noviindus_test2/home/provider/home_provider.dart';
import 'package:noviindus_test2/home/screens/category_section.dart';
import 'package:noviindus_test2/home/screens/widgets/add_thumbnail_widget.dart';
import 'package:noviindus_test2/home/screens/widgets/add_video_widget.dart';
import 'package:provider/provider.dart';

class AddfeedScreen extends StatelessWidget {
  const AddfeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Homeprovider>(
      builder: (context, homeprovider, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF171717),
          appBar: AppBar(
            backgroundColor: Color(0xFF171717),
            elevation: 0,
            scrolledUnderElevation: 0,
            title: Text(
              "Add Feeds",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
            leadingWidth: 60,
            leading: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade600, width: 0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.chevron_left,
                      color: Colors.white70,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: InkWell(
                  onTap: () {
                    homeprovider.addVideo(context);
                  },
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF7A1F1F),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      "Share Post",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50),
                AddVideoWidget(homeprovider: homeprovider),

                SizedBox(height: 20),

                AddThumbnailWidget(homeprovider: homeprovider),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add Description",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: homeprovider.descriptionController,
                        style: TextStyle(
                          color: Color.fromARGB(131, 255, 255, 255),
                        ),
                        maxLines: 5,
                        decoration: InputDecoration(
                          focusColor: Colors.white,
                          labelStyle: TextStyle(color: Colors.grey),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color.fromARGB(131, 255, 255, 255),
                              width: .2,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color.fromARGB(131, 255, 255, 255),
                              width: .2,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color.fromARGB(131, 255, 255, 255),
                              width: .2,
                            ),
                          ),
                          // labelText: "Description goes here",
                          hintText: "Description goes here",
                        ),
                      ),

                      SizedBox(height: 50),

                      CategorySection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
