import 'package:flutter/material.dart';


class CategoryButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String label;
  final Color selectedColor;
  final Color unselectedColor;
  final Color textColor;
  final Color unselectedTextColor;
  final Color borderColor;
  final bool isSelected;

  const CategoryButton({
    Key? key,
    required this.label,
    this.onTap,
    this.selectedColor = const Color(0x33C70000), 
    this.unselectedColor = Colors.transparent,
    this.textColor = Colors.white,
    this.unselectedTextColor = Colors.white70,
    this.borderColor = const Color(0xFF555555), 
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            color: isSelected ? selectedColor : unselectedColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? selectedColor : borderColor,
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? textColor : unselectedTextColor,
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}




