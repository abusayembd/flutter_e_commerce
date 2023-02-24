import 'package:e_commerce/core/constaints/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleButton extends StatelessWidget {
  final Widget icon;
  const CircleButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28.h,
      width: 28.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          50.r,
        ),
        border: Border.all(
          color: MyColors.borderColor,
        ),
      ),
      child: icon,
    );
  }
}
