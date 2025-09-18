import 'package:flutter/material.dart';
import 'package:noviindus_test2/home/provider/home_provider.dart';
import 'package:noviindus_test2/home/screens/addfeed_screen.dart';
import 'package:noviindus_test2/home/screens/video_section.dart';
import 'package:noviindus_test2/widgets/customCategorybutton.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    
    
    Scaffold(
      backgroundColor: const Color(0xFF171717),
      appBar:  AppBar(
      backgroundColor: const Color(0xFF171717),
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Hello Maria",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Welcome back to Section",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: CircleAvatar(
            minRadius: 20,
            backgroundImage: AssetImage('assets/images/Logo.png',),
          ),
        ),
      ],
    ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.red.shade900,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddfeedScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body:
       SafeArea(
        child: Consumer<Homeprovider>(
          builder: (context, homeprovider, child) {
      
            return Column(
              children: [
              SizedBox(height: 40,),
                SizedBox(
                  height: 40,
                  child: Row(
                    children: [
               
                      Padding(
                        padding: const EdgeInsets.only(left: 16,right: 10),
                        child: GestureDetector(
                          onTap: () {
                            homeprovider.setSelectedIndex(0); 
                          },
                          child: CategoryButton(
                            label: 'EXPLORE',
                            isSelected: homeprovider.selectedintex == 0,
                          ),
                        ),
                      ),

                     
                      Container(
                        height: 40,
                        width: 1,
                        color: Colors.white24,
                      ),

                   
                      Expanded(
                        child: ListView.builder(

                          itemCount: homeprovider.categorys.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final category = homeprovider.categorys[index];
                            final isSelected = homeprovider.selectedintex == index +1;

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: GestureDetector(
                                onTap: () {
                                  homeprovider.setSelectedIndex(index+1);
                                },
                                child: CategoryButton(
                                  label: category.title! ,
                                  isSelected: isSelected,

                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

           SizedBox(height: 20,),
              
                Expanded(
  child: ListView.builder(
    itemCount: homeprovider.feedVideos.length,
    itemBuilder: (context, index) {
      return VideoSection(  
        video: homeprovider.feedVideos[index],
        index: index,
      );
    },
  ),
)
              ],
            );
          },
        ),
      ),
    );
  
  
  }
}

