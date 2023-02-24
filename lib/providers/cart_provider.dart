import 'dart:convert';

import 'package:e_commerce/core/constaints/shared_preference_keys.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/models/product_quantity_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  List<ProductQuantityModel> _items = [];
  List<ProductQuantityModel> get items {
    return _items;
  }

  double totalPrice = 0;
  int totalItemCount = 0;
  late SharedPreferences _sp;

  CartProvider() {
    _loadCart();
  }

  void addProduct(ProductModel product) {
    for (var item in _items) {
      if (item.product.id == product.id) {
        item.quantity = item.quantity + 1;
        notifyListeners();
        _calculateTotalPriceAndItems();
        _saveCart();
        return;
      }
    }
    _items.add(ProductQuantityModel(product: product, quantity: 1));
    notifyListeners();
    _calculateTotalPriceAndItems();
    _saveCart();
  }

  void removeProduct(ProductModel product) {
    for (var item in _items) {
      if (item.product.id == product.id) {
        item.quantity = item.quantity - 1;

        if (item.quantity == 0) {
          _items.remove(item);
        }
        notifyListeners();
        _calculateTotalPriceAndItems();
        _saveCart();
      }
    }
    notifyListeners();
    _calculateTotalPriceAndItems();
    _saveCart();
  }

  void _calculateTotalPriceAndItems() {
    totalPrice = 0;
    //totalItemCount = 0;
    for (var item in _items) {
      totalPrice = (item.product.price ?? 0) * item.quantity;
      totalItemCount = item.quantity;
    }
    notifyListeners();
  }

  int countProduct(ProductModel product) {
    for (var item in _items) {
      if (item.product.id == product.id) {
        return item.quantity;
      }
    }
    return 0;
  }

  bool payNow(String cardNumber) {
    Map response = jsonDecode(FakePaymentClint.pay(cardNumber));
    if (response["Success"] == true) {
      _items = [];
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> _saveCart() async {
    List<String> cartData = [];
    for (var item in items) {
      cartData.add(jsonEncode(item.toJson()));
    }
    _sp = await SharedPreferences.getInstance();
    _sp.setString(SharedPreferenceKeys.CART, cartData.toString());
  }

  void _loadCart() async {
    _sp = await SharedPreferences.getInstance();
    List cartDate = jsonDecode(_sp.getString(SharedPreferenceKeys.CART) ?? "");
    for (var item in cartDate) {
      _items.add(ProductQuantityModel.fromjson(item));
    }
    notifyListeners();
  }
}

//data moking
class FakePaymentClint {
  static String pay(String cardNumber) {
    if (cardNumber == "1111") {
      return '''
      {
        "Success": true
      }

      ''';
    }
    return '''
    {
      "Success": false
    }

    ''';
  }
}
