import 'package:e_commerce/core/constaints/my_colors.dart';
import 'package:e_commerce/core/widgets/cart_product_item.dart';
import 'package:e_commerce/core/widgets/my_back_button.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/router/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CartFragment extends StatelessWidget {
  const CartFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const _Header(),
          const _ProductsSection(),
          _BillingSection(),
        ],
      ),
    );
  }
}

class _BillingSection extends StatelessWidget {
  _BillingSection({
    super.key,
  });
  TextEditingController _cardNumberTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shipping Information",
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: MyColors.primaryColor),
            ),
            TextField(
              controller: _cardNumberTextController,
              decoration: InputDecoration(
                hintText: "Card Number",
                hintStyle:
                    TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
                fillColor: MyColors.inputBackground,
                filled: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 26.r, horizontal: 18.r),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 0),
                ),
                focusedBorder: OutlineInputBorder(
                  gapPadding: 0.0,
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.r),
              child: Consumer<CartProvider>(
                builder: (context, cartProvider, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Totoal (${cartProvider.totalItemCount} Items)",
                      style: const TextStyle(color: MyColors.primaryColor),
                    ),
                    Text(
                      "\$${cartProvider.totalPrice}",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: MyColors.primaryColor),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Sheeping Fee",
                    style: TextStyle(color: MyColors.primaryColor),
                  ),
                  Text(
                    "\$10",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: MyColors.primaryColor),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Sub Total",
                    style: TextStyle(color: MyColors.primaryColor),
                  ),
                  Text(
                    "\$131",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: MyColors.primaryColor),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: () {
                  print(_cardNumberTextController.text);
                  bool isPaymentSucceed =
                      Provider.of<CartProvider>(context, listen: false)
                          .payNow(_cardNumberTextController.text);
                  if (!isPaymentSucceed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Payment failed !")));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Payment Successfull")));
                    context.goNamed(RouteNames.mainPage);
                  }
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
                    Text(
                      "Pay Now",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductsSection extends StatelessWidget {
  const _ProductsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<CartProvider>(
        builder: (context, cartProvider, child) => cartProvider.items.isEmpty
            ? const Center(
                child: Text("No Products in cart"),
              )
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: cartProvider.items.length,
                itemBuilder: (context, index) =>
                    CartProductItem(productQuantity: cartProvider.items[index]),
              ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 18.r, vertical: 18.r),
      sliver: SliverAppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => context.pop(),
            child: const MyBackButton(),
          ),
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "CheckOut",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: MyColors.primaryColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
