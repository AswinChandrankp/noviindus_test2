import 'package:flutter/material.dart';
import 'package:noviindus_test2/home/provider/home_provider.dart';
import 'package:noviindus_test2/widgets/customCategorybutton.dart';
import 'package:provider/provider.dart';


class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Homeprovider>(
      builder: (context, homeprovider, child) {
        return Container(
          width: double.infinity,
         
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Categories This Project",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                     
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, 
                        vertical: 4.0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'View All',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white54, 
                                width: 1,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white70,
                              size: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
               SizedBox(height: 20,),
           
              homeprovider.newcategories.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Center(
                        child: Text(
                          'No categories available',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                  : Wrap(
                    spacing: 12.0, 
                    runSpacing: 12.0, 
                    children: homeprovider.newcategories
                        .asMap()
                        .entries
                        .map((entry) {
                      final index = entry.key;
                      final category = entry.value;
                      return CategoryButton(
                        borderColor:  Color(0x33C70000),
                        label: category.categorie.title!,
                        isSelected: category.isSelected,
                        onTap: () {
                          homeprovider.updateCategory(index);
                        },
                      );
                    }).toList(),
                  ),
            ],
          ),
        );
      },
    );
  }
}
