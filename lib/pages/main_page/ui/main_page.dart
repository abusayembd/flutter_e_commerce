import 'package:e_commerce/pages/main_page/providers/main_page_provider.dart';
import 'package:e_commerce/pages/main_page/ui/fregments/cart_fragment.dart';
import 'package:e_commerce/pages/main_page/ui/fregments/home_fragment.dart';
import 'package:e_commerce/pages/main_page/ui/fregments/wish_list_fragment.dart';
import 'package:flutter/material.dart';
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
          builder: (context, mainPageProvider, child) => BottomNavigationBar(
              currentIndex: mainPageProvider.getSelectedTabIndex(),
              onTap: (index) => mainPageProvider.setTab(index),
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.badge), label: "Cart"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.heart_broken), label: "Wish List"),
              ]),
        ),
      ),
    );
  }
}
