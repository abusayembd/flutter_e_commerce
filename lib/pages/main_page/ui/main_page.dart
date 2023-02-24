import 'package:flutter/material.dart';
import 'package:e_commerce/core/constaints/my_colors.dart';
import 'package:e_commerce/core/constaints/asset_locations.dart';
import 'package:e_commerce/pages/main_page/providers/main_page_provider.dart';
import 'package:e_commerce/pages/main_page/ui/fregments/cart_fragment.dart';
import 'package:e_commerce/pages/main_page/ui/fregments/home_fragment.dart';
import 'package:e_commerce/pages/main_page/ui/fregments/wish_list_fragment.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainPageProvider(),
      builder: (context, child) => Scaffold(
        body: Consumer<MainPageProvider>(
            builder: (context, mainPageProvider, child) {
          if (mainPageProvider.getSelectedTabIndex() == 0) {
            return const HomeFragment();
          } else if (mainPageProvider.getSelectedTabIndex() == 1) {
            return const CartFragment();
          } else if (mainPageProvider.getSelectedTabIndex() == 2) {
            return const WishListFragment();
          }
          return const Center(
            child: Text("No Fragment Selected"),
          );
        }),
        bottomNavigationBar: Consumer<MainPageProvider>(
          builder: (context, mainPageProvider, child) => Padding(
            padding: EdgeInsets.all(12.r),
            child: Theme(
              data: Theme.of(context)
                  .copyWith(canvasColor: MyColors.primaryColor),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60.r),
                child: BottomNavigationBar(
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    currentIndex: mainPageProvider.getSelectedTabIndex(),
                    onTap: (index) => mainPageProvider.setTab(index),
                    items: [
                      BottomNavigationBarItem(
                          icon: SizedBox(
                              height: 44.h,
                              width: 44.w,
                              child: Image.asset(AssetLocations.homeIcon)),
                          label: "Home"),
                      BottomNavigationBarItem(
                          icon: SizedBox(
                              height: 44.h,
                              width: 44.w,
                              child: Image.asset(AssetLocations.cartIcon)),
                          label: "Cart"),
                      BottomNavigationBarItem(
                          icon: SizedBox(
                              height: 44.h,
                              width: 44.w,
                              child: Image.asset(AssetLocations.wishlistIcon)),
                          label: "Wish List"),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
