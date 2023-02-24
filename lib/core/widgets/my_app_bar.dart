import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Hello Wellcome",
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(
                  height: 21.h,
                  width: 14.h,
                  child: Image.asset("assets/graphics/common/wave.png"),
                ),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              "Let's Login or Signup",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            )
          ],
        ),
        const CircleAvatar(
          backgroundImage: AssetImage("assets/graphics/common/avater.png"),
        )
      ],
    );
  }
}
