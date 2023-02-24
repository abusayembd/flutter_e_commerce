import 'package:e_commerce/core/constaints/asset_locations.dart';
import 'package:e_commerce/core/constaints/my_colors.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/pages/main_page/providers/home_fragment_provder.dart';
import 'package:e_commerce/providers/auth_provider.dart';
import 'package:e_commerce/router/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeFragmentProvder(),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 24.r, left: 24.r, right: 24.r),
          child: CustomScrollView(
            slivers: [
              const _AppBar(),
              const _SearchBox(),
              const _CategoriesTab(),
              SliverToBoxAdapter(
                child: Consumer<HomeFragmentProvder>(
                    builder: (context, homeFragmentProvder, child) {
                  List<ProductModel> products = homeFragmentProvder.products;

                  return homeFragmentProvder.isProductLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: homeFragmentProvder.products.length,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12.r,
                            mainAxisSpacing: 12.r,
                            childAspectRatio: 3 / 7,
                          ),
                          itemBuilder: (context, index) => ProductCard(
                              onTap: () {
                                context.goNamed(RouteNames.details,
                                    extra: products[index]);
                              },
                              image: products[index].image ??
                                  "https://picsum.photos/200/300",
                              title: (products[index].title!.length > 20
                                      ? "${products[index].title!.substring(0, 20)}... "
                                      : products[index].title) ??
                                  "No Title",
                              category:
                                  products[index].category ?? "No Category",
                              price: "\$${products[index].price.toString()}",
                              stars: products[index].rating!.rate.toString()),
                        );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String category;
  final String price;
  final String stars;
  final VoidCallback? onTap;
  const ProductCard(
      {super.key,
      required this.image,
      required this.title,
      required this.category,
      required this.price,
      required this.stars,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 9,
              child: Container(
                alignment: Alignment.topRight,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.r),
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.cover),
                ),
                child: IconButton(
                    onPressed: () {},
                    icon: const CircleAvatar(
                      backgroundColor: MyColors.primaryColor,
                      child: Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                    )),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.sp),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      category,
                      style: TextStyle(
                          fontSize: 12.sp, color: MyColors.secondaryColor),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          price,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.sp),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              AssetLocations.starIcon,
                              width: 28.w,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              stars,
                              style: TextStyle(fontSize: 18.sp),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CategoriesTab extends StatelessWidget {
  const _CategoriesTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24.r),
        height: 90.h,
        child: Consumer<HomeFragmentProvder>(
          builder: (context, homeFragmentProvder, child) => homeFragmentProvder
                  .isCategoryLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: MyColors.primaryColor,
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: homeFragmentProvder.categories.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () =>
                        homeFragmentProvder.changeProductCategoryTab(index),
                    child: CategoryTab(
                      icon: AssetLocations.allCategoryIcon,
                      title: homeFragmentProvder.categories[index]
                          .toString()
                          .toUpperCase(),
                      isSelected: index == homeFragmentProvder.selectedTabIndex,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class CategoryTab extends StatelessWidget {
  final String icon;
  final String title;
  final bool isSelected;
  const CategoryTab(
      {super.key,
      required this.icon,
      required this.title,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 12.r),
      padding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 8.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: isSelected ? MyColors.primaryColor : Colors.white,
          border: Border.all(color: MyColors.inputBackground)),
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 18.w,
            color: isSelected ? Colors.white : MyColors.primaryColor,
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            title,
            style: TextStyle(
                color: isSelected ? Colors.white : MyColors.primaryColor),
          ),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello Welcome",
                style: TextStyle(fontSize: 14.sp),
              ),
              Text(
                "MD. Abu Sayem",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          InkWell(
            child: const CircleAvatar(
              backgroundImage: AssetImage(AssetLocations.myImageIcon),
            ),
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 34.r),
                child: ElevatedButton(
                  onPressed: () async {
                    bool isSucceed =
                        await Provider.of<AuthProvider>(context, listen: false)
                            .logOut();
                    if (isSucceed) {
                      context.goNamed(RouteNames.logIn);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: MyColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                  ),
                  child: const Text("Logout"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  const _SearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 24.r),
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.all(8.r),
              child: Image.asset(
                AssetLocations.searchIcon,
                width: 24.w,
              ),
            ),
            hintText: "Search Products",
            hintStyle: const TextStyle(color: MyColors.hintTextColor),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xffEDEDED),
                ),
                borderRadius: BorderRadius.circular(12.r)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
      ),
    );
  }
}
