import 'package:e_commerce/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductQuantityModel {
  late ProductModel product;
  late int quantity;

  ProductQuantityModel({required this.product, required this.quantity});
  ProductQuantityModel.fromjson(Map<String, dynamic> json) {
    product = ProductModel.fromJson(json["product"]);
    quantity = json["quantity"];
  }
  Map<String, dynamic> toJson() {
    return {"product": product.toJson(), "quantity": quantity};
  }
}
