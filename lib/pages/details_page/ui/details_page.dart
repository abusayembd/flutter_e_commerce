import 'package:e_commerce/core/constaints/asset_locations.dart';
import 'package:e_commerce/core/constaints/my_colors.dart';
import 'package:e_commerce/core/widgets/my_back_button.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/circle_button.dart';

class DetailsPage extends StatelessWidget {
  final ProductModel product;
  const DetailsPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              _Header(
                  imageUrl: product.image ?? "https://picsum.photos/200/300"),
              _Title(
                  title: product.title ?? "No Title avalable",
                  product: product),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.r, vertical: 10.r),
                child: Text(
                  product.description ?? "No description found",
                  style:
                      TextStyle(fontSize: 16.sp, color: MyColors.hintTextColor),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(left: 40.r, right: 10.r),
          child: SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: const Text("Product added")));
                Provider.of<CartProvider>(context, listen: false)
                    .addProduct(product);
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: MyColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetLocations.shoppingcartIcon,
                    width: 32.r,
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Text(
                    "Add to cart  |  \$ ${product.price}",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  Text(
                    "\$190.99",
                    style: TextStyle(
                        fontSize: 10.sp,
                        decoration: TextDecoration.lineThrough),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final ProductModel product;
  final String title;
  const _Title({super.key, required this.title, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.r),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Consumer<CartProvider>(
              builder: (context, cartProvider, child) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () => cartProvider.removeProduct(product),
                    child: const CircleButton(
                      icon: Icon(
                        Icons.remove,
                        color: MyColors.secondaryColor,
                      ),
                    ),
                  ),
                  Text(
                    cartProvider.countProduct(product).toString(),
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () => cartProvider.addProduct(product),
                    child: const CircleButton(
                      icon: Icon(
                        Icons.add,
                        color: MyColors.primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String imageUrl;
  const _Header({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            vertical: 18.r,
            horizontal: 24.r,
          ),
          width: double.infinity,
          height: 400.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
            image: DecorationImage(
                image: NetworkImage(imageUrl), fit: BoxFit.cover),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 35.r,
            horizontal: 40.r,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //here is the back button
              InkWell(
                onTap: () => context.pop(),
                child: const MyBackButton(),
              ),
              CircleAvatar(
                radius: 18.r,
                backgroundColor: Colors.white,
                child: Image.asset(
                  AssetLocations.heartIcon,
                  width: 25.r,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
