import 'package:e_commerce/core/constaints/my_colors.dart';
import 'package:e_commerce/models/product_quantity_model.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartProductItem extends StatelessWidget {
  final ProductQuantityModel productQuantity;
  const CartProductItem({super.key, required this.productQuantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.r, horizontal: 18.r),
      padding: EdgeInsets.only(bottom: 10.r),
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: MyColors.borderColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 80.r,
              width: 80.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                image: DecorationImage(
                    image: NetworkImage(productQuantity.product.image ??
                        "https://picsum.photos/200/300"),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 18.r,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productQuantity.product.title ?? "No title available",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.r),
                    child: Text(
                      productQuantity.product.category ??
                          "No Category available",
                      style: TextStyle(
                          color: MyColors.secondaryColor,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    "\$${productQuantity.product.price}",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () =>
                          Provider.of<CartProvider>(context, listen: false)
                              .addProduct(productQuantity.product),
                      child: Container(
                        decoration: BoxDecoration(
                          color: MyColors.primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                            bottomLeft: Radius.circular(10.r),
                          ),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: 22.h,
                      decoration:
                          const BoxDecoration(color: MyColors.primaryColor),
                      child: Consumer<CartProvider>(
                        builder: (context, cartProvider, child) => Text(
                          productQuantity.quantity.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () =>
                          Provider.of<CartProvider>(context, listen: false)
                              .removeProduct(productQuantity.product),
                      child: Container(
                        decoration: BoxDecoration(
                          color: MyColors.primaryColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.r),
                            bottomRight: Radius.circular(10.r),
                          ),
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
