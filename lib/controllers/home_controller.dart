import 'package:flutter/material.dart';

import '../models/Product.dart';
import '../models/ProductItem.dart';

enum HomeState { normal, cart }

class HomeController extends ChangeNotifier {
  HomeState homeState = HomeState.normal;

  void changeHomeState(HomeState state) {
    homeState = state;
    notifyListeners();
  }

  List<ProductItem> cart = [];

  void addProductToCart(Product product) {
    for (ProductItem item in cart) {
      if (item.product!.title == product.title) {
        item.increment();
        notifyListeners();
        return;
      }
    }
    cart.add(ProductItem(product: product));
    notifyListeners();
  }

  int totalCartItems() => cart.fold(0, (previousValue, element) => previousValue + element.quantity);
}
