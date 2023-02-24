import 'package:e_commerce/core/constaints/asset_locations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 18.r,
      backgroundColor: Colors.white,
      child: Image.asset(
        AssetLocations.backArrow,
        width: 25.w,
      ),
    );
  }
}
